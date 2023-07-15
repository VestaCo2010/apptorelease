#include "ServiceVoteResult.h"

ServiceVoteResult::ServiceVoteResult()
{
    m_modelVotePartyResult = new ModelVotePartyResult();
    m_modelVoteCondidateResult = new ModelVoteCondidateResult();

    connect(this, SIGNAL(sigTimeOut(QString)), this, SLOT(endOffServiceExecution(QString)));
}

ServiceVoteResult::~ServiceVoteResult()
{
    delete m_modelVotePartyResult;
    delete m_modelVoteCondidateResult;
}


// Total result
void ServiceVoteResult::requestGetTotalResult()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/fundReport");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataGetTotalResult(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageGetTotalResult(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void ServiceVoteResult::getReceivedDataGetTotalResult(QJsonObject *result)
{
    endOffServiceExecution();

    QJsonObject qJsonObject = (*result)["result"].toObject()["data"].toObject();

    emit sigSuccessGetTotalResult(qJsonObject["totalVote"].toInt(),
                                  qJsonObject["totalFund"].toInt(),
                                  qJsonObject["CountFund"].toInt(),
                                  qJsonObject["percentFund"].toInt());
    result = nullptr;
}

void ServiceVoteResult::getReceivedMessageGetTotalResult(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count()==0)
        emit sigRejectGetTotalResult((*result)["result"].toObject()["message"].toString());
    else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectGetTotalResult(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}


// Party result
void ServiceVoteResult::requestGetVotePartyResult()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/partyReport");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataGetVotePartyResult(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageGetVotePartyResult(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void ServiceVoteResult::getReceivedDataGetVotePartyResult(QJsonObject *result)
{
    endOffServiceExecution();
    m_modelVotePartyResult->removeData();

    foreach (const QJsonValue &value, (*result)["result"].toObject()["data"].toObject()["reportCount"].toArray()) {
        m_modelVotePartyResult->addData(EntityVotePartyResult(
            value["partyId"].toInt(),
            value["partyNameEn"].toString(),
            value["partyNameKu"].toString(),
            value["partyCode"].toString(),
            value["logo"].toString(),
            value["count"].toInt(),
            value["percent"].toDouble()));
    }

    emit sigSuccessGetVotePartyResult();
    result = nullptr;
}

void ServiceVoteResult::getReceivedMessageGetVotePartyResult(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count()==0)
        emit sigRejectGetVotePartyResult((*result)["result"].toObject()["message"].toString());
    else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectGetVotePartyResult(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}


// Condidate result
void ServiceVoteResult::requestGetVoteCondidateResult()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/candidateReport");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataGetVoteCondidateResult(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageGetVoteCondidateResult(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void ServiceVoteResult::getReceivedDataGetVoteCondidateResult(QJsonObject *result)
{
    endOffServiceExecution();
    m_modelVoteCondidateResult->removeData();

    foreach (const QJsonValue &value, (*result)["result"].toObject()["data"].toObject()["reportCount"].toArray()) {
        m_modelVoteCondidateResult->addData(EntityVoteCondidateResult(
            value["candidateNameEn"].toString(),
            value["candidateNameKu"].toString(),
            value["candidateFamilyEn"].toString(),
            value["candidateFamilyKu"].toString(),
            value["candidateCode"].toString(),
            value["count"].toInt(),
            value["percent"].toDouble()));
    }

    emit sigSuccessGetVoteCondidateResult();
    result = nullptr;
}

void ServiceVoteResult::getReceivedMessageGetVoteCondidateResult(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count()==0)
        emit sigRejectGetVoteCondidateResult((*result)["result"].toObject()["message"].toString());
    else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectGetVoteCondidateResult(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}

// Disconnect signal & slot
void ServiceVoteResult::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataGetTotalResult(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageGetTotalResult(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataGetVotePartyResult(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageGetVotePartyResult(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataGetVoteCondidateResult(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageGetVoteCondidateResult(QJsonObject*)));
}
