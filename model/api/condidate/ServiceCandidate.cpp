#include "ServiceCandidate.h"

ServiceCandidate::ServiceCandidate()
{
    m_modelCandidate = new ModelCandidate;
}

ServiceCandidate::~ServiceCandidate()
{
    delete m_modelCandidate;
}


// Api
void ServiceCandidate::requestCandidate()
{
    QJsonDocument qJsonDocument;

    QUrlQuery querystr;
    querystr.addQueryItem("favorite", "1");

    QUrl qUrl;
    qUrl.setPath("/Candidate");
    qUrl.setQuery(querystr);

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCandidate(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCandidate(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void ServiceCandidate::getReceivedDataCandidate(QJsonObject *result)
{
    endOffServiceExecution();

    foreach (const QJsonValue &value, (*result)["result"].toObject()["data"].toArray()) {
        EntityCandidate newRecord (
            value["partyId"].toInt(),
            value["partyCode"].toString(),
            value["candidateId"].toInt(),
            value["candidateCode"].toString(),
            value["candidateNameKu"].toString(),
            value["candidateNameEn"].toString(),
            value["candidateFamilyKu"].toString(),
            value["candidateFamilyEn"].toString()
            );

        m_modelCandidate->addData(newRecord);
    }

    emit sigSuccessGetCandidate();
    result = nullptr;
}

void ServiceCandidate::getReceivedMessageCandidate(QJsonObject *result)
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
void ServiceCandidate::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCandidate(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCandidate(QJsonObject*)));
}

