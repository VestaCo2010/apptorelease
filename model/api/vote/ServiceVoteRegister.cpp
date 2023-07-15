#include "ServiceVoteRegister.h"

ServiceVoteRegister::ServiceVoteRegister()
{
    connect(this, SIGNAL(sigTimeOut(QString)), this, SLOT(endOffServiceExecution(QString)));
}

// Verify party vote
void ServiceVoteRegister::requestPartyVoteVerify(const QVariantList& array)
{
    QJsonArray qJsonArray;

    for (const auto& row : array) {
        const QVariantList rowData = row.toList();

        if(rowData[0].toString().isEmpty() || rowData[1].toString().isEmpty()) {
            emit sigRejectPartyVoteRegister();
            return;
        }

        QJsonObject qJsonObject;
        qJsonObject.insert("partyId", rowData[0].toString());
        qJsonObject.insert("count", rowData[1].toString());

        qJsonArray.push_back(qJsonObject);
    }

    m_qJsonArrayParty = qJsonArray;

    emit sigSuccessPartyVoteVerify();
}


// Register party vote
void ServiceVoteRegister::requestPartyVoteRegister(const QString& imageId)
{
    QJsonObject qJsonObject;
    qJsonObject.insert("info", m_qJsonArrayParty);
    qJsonObject.insert("imageId", imageId);

    QJsonDocument qJsonDocument(qJsonObject);

    QUrl qUrl;
    qUrl.setPath("/partyVote");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataPartyVoteRegister(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessagePartyVoteRegister(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "POST");
}

void ServiceVoteRegister::getReceivedDataPartyVoteRegister(QJsonObject *result)
{
    Q_UNUSED(result);
    endOffServiceExecution();

    emit sigSuccessPartyVoteRegister();
    result = nullptr;
}

void ServiceVoteRegister::getReceivedMessagePartyVoteRegister(QJsonObject *result)
{
    qDebug() << "getReceivedMessagePartyVoteRegister ";
    endOffServiceExecution();

    emit sigRejectPartyVoteRegister();
    result = nullptr;
}


// Verify condidate vote
void ServiceVoteRegister::requestCondidateVoteVerify(const QVariantList &array)
{
    QJsonArray qJsonArray;

    for (const auto& row : array) {
        const QVariantList rowData = row.toList();

        if(rowData[0].toString().isEmpty() || rowData[1].toString().isEmpty()) {
            emit sigRejectCondidateVoteRegister();
            return;
        }

        QJsonObject qJsonObject;
        qJsonObject.insert("candidateId", rowData[0].toString());
        qJsonObject.insert("count", rowData[1].toString());

        qJsonArray.push_back(qJsonObject);
    }

    m_qJsonArrayCondidate = qJsonArray;

    emit sigSuccessVerifyVoteRegister();
}


// Register condidate vote
void ServiceVoteRegister::requestCondidateVoteRegister(const QString& imageId)
{
    QJsonObject qJsonObject;
    qJsonObject.insert("info", m_qJsonArrayCondidate);
    qJsonObject.insert("imageId", imageId);

    QJsonDocument qJsonDocument(qJsonObject);

    QUrl qUrl;
    qUrl.setPath("/candidateVote");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCondidateVoteRegister(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCondidateVoteRegister(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "POST");
}

void ServiceVoteRegister::getReceivedDataCondidateVoteRegister(QJsonObject *result)
{
    Q_UNUSED(result);
    endOffServiceExecution();

    emit sigSuccessCondidateVoteRegister();
    result = nullptr;
}

void ServiceVoteRegister::getReceivedMessageCondidateVoteRegister(QJsonObject *result)
{
    qDebug() << "getReceivedMessageCondidateVoteRegister ";
    endOffServiceExecution();

    emit sigRejectCondidateVoteRegister();
    result = nullptr;
}



void ServiceVoteRegister::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataPartyVoteRegister(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessagePartyVoteRegister(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataCondidateVoteRegister(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageCondidateVoteRegister(QJsonObject*)));
}

