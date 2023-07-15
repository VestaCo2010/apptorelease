#include "ServiceFund.h"

void ServiceFund::requestGetFund()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/userFund");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataFund(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageFund(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void ServiceFund::getReceivedDataFund(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["result"].toObject()["data"].toObject()["region"].toString().length() < 1 ||
        (*result)["result"].toObject()["data"].toObject()["fundNumber"].toString().length() < 1) {
        emit sigRejectFundNumber(QObject::tr("Found number or region code invalid"));
    } else {
        emit sigSuccessFundNumber((*result)["result"].toObject()["data"].toObject()["region"].toString(),
                                  (*result)["result"].toObject()["data"].toObject()["fundNumber"].toString());
    }
    result = nullptr;
}

void ServiceFund::getReceivedMessageFund(QJsonObject *result)
{
    endOffServiceExecution();

    emit sigRejectFundNumber((*result)["result"].toObject()["message"].toString());
    result = nullptr;
}

void ServiceFund::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataFund(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageFund(QJsonObject*)));
}

