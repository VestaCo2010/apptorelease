#include "PartyTbl.h"

PartyTbl* instanceParty = nullptr;

QObject *PartyTbl::getInstanceParty(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if(!instanceParty)
        instanceParty = new PartyTbl;

    return instanceParty;
}

PartyTbl *PartyTbl::getInstanceParty()
{
    if(!instanceParty)
        instanceParty = new PartyTbl;

    return instanceParty;
}

PartyTbl::PartyTbl()
{
    this->createTable();
    this->setTableName("Party");

    m_modelParty = new ModelParty;
}

PartyTbl::~PartyTbl()
{
    instanceParty->deleteLater();
    delete m_modelParty;
}


// Database
void PartyTbl::createTable()
{
    QSqlQuery sqlQuery(this->db);
    QString queryStr("CREATE TABLE IF NOT EXISTS 'Party' ("
                     "'id'     INTEGER NOT NULL,"
                     "'code'   TEXT NOT NULL,"
                     "'nameKu' TEXT NOT NULL,"
                     "'nameEn' TEXT NOT NULL,"
                     "'logo'   TEXT NOT NULL,"
                     "PRIMARY KEY('id')"
                     ");"
                     );

    sqlQuery.prepare(queryStr);
    if(sqlQuery.exec() != true)
    {
        QSqlError error = sqlQuery.lastError();
    }
}

void PartyTbl::addToDb(const int &partyId, const QString &partyCode, const QString &partyNameKu, const QString &partyNameEn, const QString &partyLogo)
{
    QVariantMap map;

    map["id"] = partyId;
    map["code"] = partyCode;
    map["nameKu"] = partyNameKu;
    map["nameEn"] = partyNameEn;
    map["logo"] = partyLogo;

    int insertRowId = this->insert(map);

    if(insertRowId > -1)
    {
        QVariantMap item = this->getAllByRowId(insertRowId);
        EntityParty newRecord (
            item["id"].toInt(),
            item["code"].toString(),
            item["nameKu"].toString(),
            item["nameEn"].toString(),
            item["logo"].toString());

        m_modelParty->addData(newRecord);
    }
}

void PartyTbl::getFromDb(const QString &filter)
{
    QString query = QString("SELECT * FROM Party WHERE (code LIKE '%%1%') || (nameEn LIKE '%%1%') || (nameKu LIKE '%%1%') ").arg(filter);

    QList<QVariantMap> allItem = this->getByQuery(query);

    m_modelParty->removeData();

    foreach (QVariantMap item, allItem) {
        EntityParty newRecord (
            item["id"].toInt(),
            item["code"].toString(),
            item["nameKu"].toString(),
            item["nameEn"].toString(),
            item["logo"].toString());

        m_modelParty->addData(newRecord);
    }
}

void PartyTbl::clearData()
{
    this->deleteAll();
}

QString PartyTbl::getPartyNameFromDb(const int &partyId, const bool& isEn)
{
    QVariantMap item = this->getAllById(partyId);
    return isEn ? item["nameEn"].toString() : item["nameKu"].toString();
}


// Api
void PartyTbl::requestParty()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/party");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataParty(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageParty(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void PartyTbl::getReceivedDataParty(QJsonObject *result)
{
    endOffServiceExecution();

    foreach (const QJsonValue &value, (*result)["result"].toObject()["data"].toArray()) {
        addToDb(value["id"].toInt(),
                value["code"].toString(),
                value["nameKu"].toString(),
                value["nameEn"].toString(),
                value["logo"].toString());
    }

    dataExist.syncPartyTbl();
    emit sigSuccessGetParty();
    result = nullptr;
}

void PartyTbl::getReceivedMessageParty(QJsonObject *result)
{
    endOffServiceExecution();
    if((*result)["message"].toArray().count()==0)
        emit sigRejectGetParty((*result)["result"].toObject()["message"].toString());
    else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectGetParty(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}


// Disconnect signal
void PartyTbl::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataParty(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageParty(QJsonObject*)));
}
