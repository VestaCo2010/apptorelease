#include "CandidateTbl.h"

CandidateTbl* instanceCandidate = nullptr;

QObject *CandidateTbl::getInstanceCandidate(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if(!instanceCandidate)
        instanceCandidate = new CandidateTbl;

    return instanceCandidate;
}

CandidateTbl *CandidateTbl::getInstanceCandidate()
{
    if(!instanceCandidate)
        instanceCandidate = new CandidateTbl;

    return instanceCandidate;
}

CandidateTbl::CandidateTbl()
{
    this->createTable();
    this->setTableName("Candidate");

    m_modelCandidate = new ModelCandidate;
}

CandidateTbl::~CandidateTbl()
{
    instanceCandidate->deleteLater();
    delete m_modelCandidate;
}



// Database
void CandidateTbl::createTable()
{
    qDebug() << "createTable Candidate";

    QSqlQuery sqlQuery(this->db);
    QString queryStr("CREATE TABLE IF NOT EXISTS 'Candidate' ("
                     "'partyId'           INTEGER NOT NULL,"
                     "'partyCode'         TEXT NOT NULL,"
                     "'candidateId'       INTEGER NOT NULL,"
                     "'candidateCode'     TEXT NOT NULL,"
                     "'candidateNameKu'   TEXT NOT NULL,"
                     "'candidateNameEn'   TEXT NOT NULL,"
                     "'candidateFamilyKu' TEXT NOT NULL,"
                     "'candidateFamilyEn' TEXT NOT NULL,"
                     "PRIMARY KEY('candidateId')"
                     ");"
                     );


    sqlQuery.prepare(queryStr);
    if(sqlQuery.exec() != true)
    {
        QSqlError error = sqlQuery.lastError();
    }
}

void CandidateTbl::addToDb(const int &partyId, const QString &partyCode, const int &candidateId, const QString &candidateCode,
                           const QString &candidateNameKu, const QString &candidateNameEn,
                           const QString &candidateFamilyKu, const QString &candidateFamilyEn)
{
    QVariantMap map;

    map["partyId"] = partyId;
    map["partyCode"] = partyCode;
    map["candidateId"] = candidateId;
    map["candidateCode"] = candidateCode;
    map["candidateNameKu"] = candidateNameKu;
    map["candidateNameEn"] = candidateNameEn;
    map["candidateFamilyKu"] = candidateFamilyKu;
    map["candidateFamilyEn"] = candidateFamilyEn;

    int insertRowId = this->insert(map);

    if(insertRowId > -1)
    {
        QVariantMap item = this->getAllByRowId(insertRowId);
        EntityCandidate newRecord (
            item["partyId"].toInt(),
            item["partyCode"].toString(),
            item["candidateId"].toInt(),
            item["candidateCode"].toString(),
            item["candidateNameKu"].toString(),
            item["candidateNameEn"].toString(),
            item["candidateFamilyKu"].toString(),
            item["candidateFamilyEn"].toString()
            );
        m_modelCandidate->addData(newRecord);
    }
}

void CandidateTbl::getFromDb(const QString &filter)
{
    QString query = QString("SELECT * FROM Candidate "
                            "WHERE (candidateCode LIKE '%%1%') || "
                            "(candidateNameKu LIKE '%%1%') || "
                            "(candidateNameEn LIKE '%%1%') || "
                            "(candidateFamilyKu LIKE '%%1%') || "
                            "(candidateFamilyEn LIKE '%%1%') "
                            "LIMIT 30 "
                            ).arg(filter);

    QList<QVariantMap> allItem = this->getByQuery(query);

    m_modelCandidate->removeData();

    foreach (QVariantMap item, allItem) {
        EntityCandidate newRecord (
            item["partyId"].toInt(),
            item["partyCode"].toString(),
            item["candidateId"].toInt(),
            item["candidateCode"].toString(),
            item["candidateNameKu"].toString(),
            item["candidateNameEn"].toString(),
            item["candidateFamilyKu"].toString(),
            item["candidateFamilyEn"].toString()
            );

        m_modelCandidate->addData(newRecord);
    }
}

void CandidateTbl::clearData()
{
    this->deleteAll();
}


// Api
void CandidateTbl::requestCandidate()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/Candidate");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCandidate(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCandidate(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void CandidateTbl::getReceivedDataCandidate(QJsonObject *result)
{
    endOffServiceExecution();

    foreach (const QJsonValue &value, (*result)["result"].toObject()["data"].toArray()) {
        addToDb(value["partyId"].toInt(),
                value["partyCode"].toString(),
                value["candidateId"].toInt(),
                value["candidateCode"].toString(),
                value["candidateNameKu"].toString(),
                value["candidateNameEn"].toString(),
                value["candidateFamilyKu"].toString(),
                value["candidateFamilyEn"].toString()
                );
    }

    dataExist.syncCandidateTbl();
    emit sigSuccessGetCandidate();
    result = nullptr;
}

void CandidateTbl::getReceivedMessageCandidate(QJsonObject *result)
{
    endOffServiceExecution();
    if((*result)["message"].toArray().count()==0)
        emit sigRejectGetCandidate((*result)["result"].toObject()["message"].toString());
    else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectGetCandidate(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}


// Disconnect signal
void CandidateTbl::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCandidate(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCandidate(QJsonObject*)));
}

