#include "ServiceParty.h"

ServiceParty::ServiceParty()
{
    m_modelParty = new ModelParty;
}

ServiceParty::~ServiceParty()
{
    delete m_modelParty;
}


// Api
void ServiceParty::requestParty()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/party");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataParty(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageParty(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void ServiceParty::getReceivedDataParty(QJsonObject *result)
{
    endOffServiceExecution();

    foreach (const QJsonValue &value, (*result)["result"].toObject()["data"].toArray()) {
        EntityParty newRecord (
            value["id"].toInt(),
            value["code"].toString(),
            value["nameKu"].toString(),
            value["nameEn"].toString(),
            value["logo"].toString());

        m_modelParty->addData(newRecord);
    }

    emit sigSuccessGetParty();
    result = nullptr;
}

void ServiceParty::getReceivedMessageParty(QJsonObject *result)
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
void ServiceParty::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataParty(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageParty(QJsonObject*)));
}
