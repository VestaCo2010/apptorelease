#include "ServiceCheckVotingRegister.h"


// Check party voting register
void ServiceCheckVotingRegister::requestCheckPartyVotingRegister()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/checkPartyVotingRegister");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCheckPartyVotingRegister(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCheckPartyVotingRegister(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void ServiceCheckVotingRegister::getReceivedDataCheckPartyVotingRegister(QJsonObject *result)
{
    endOffServiceExecution();

    emit sigWaitingPartyVoteRegister((*result)["result"].toObject()["data"].toObject()["party"].toObject()["state"].toString(),
                                     (*result)["result"].toObject()["data"].toObject()["party"].toObject()["message"].toString());
    result = nullptr;
}

void ServiceCheckVotingRegister::getReceivedMessageCheckPartyVotingRegister(QJsonObject *result)
{
    Q_UNUSED(result);
    endOffServiceExecution();

    emit sigReadyPartyVoteRegister();
    result = nullptr;
}


// Check candidate voting register
void ServiceCheckVotingRegister::requestCheckCandidateVotingRegister()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/checkCandidateVotingRegister");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCheckCondidateVotingRegister(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCheckCondidateVotingRegister(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void ServiceCheckVotingRegister::getReceivedDataCheckCondidateVotingRegister(QJsonObject *result)
{
    endOffServiceExecution();

    emit sigWaitingCandidateVoteRegister((*result)["result"].toObject()["data"].toObject()["candidate"].toObject()["state"].toString(),
                                         (*result)["result"].toObject()["data"].toObject()["candidate"].toObject()["message"].toString());
    result = nullptr;
}

void ServiceCheckVotingRegister::getReceivedMessageCheckCondidateVotingRegister(QJsonObject *result)
{
    Q_UNUSED(result);
    endOffServiceExecution();

    emit sigReadyCandidateVoteRegister();
    result = nullptr;
}


// Disconnect signal & slot
void ServiceCheckVotingRegister::endOffServiceExecution(QString message)
{
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCheckPartyVotingRegister(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCheckPartyVotingRegister(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCheckCondidateVotingRegister(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCheckCondidateVotingRegister(QJsonObject*)));
}
