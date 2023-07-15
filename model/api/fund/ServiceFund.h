#ifndef SERVICEFUND_H
#define SERVICEFUND_H

#include <QUrl>
#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>

#include "../../da/NetworkHandler.h"

class ServiceFund : public NetworkHandler
{
    Q_OBJECT

public:

    ServiceFund() = default;
    Q_INVOKABLE void requestGetFund();

signals:

    void sigSuccessFundNumber(QString regionCode, QString fundNumber);
    void sigRejectFundNumber(QString message);

public slots:

    void getReceivedDataFund(QJsonObject *result);
    void getReceivedMessageFund(QJsonObject *result);

    void endOffServiceExecution(QString message = {});
};

#endif // SERVICEFUND_H
