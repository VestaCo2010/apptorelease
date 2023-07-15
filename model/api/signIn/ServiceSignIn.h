#ifndef SERVICESIGNIN_H
#define SERVICESIGNIN_H

#include <QUrl>
#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>

#include "../../da/NetworkHandler.h"
#include "../../../util/storage/authentication/Token.h"

class ServiceSignIn : public NetworkHandler
{
    Q_OBJECT

public:

    ServiceSignIn();
    ~ServiceSignIn();
    Q_INVOKABLE void signIn(const QString &username, const QString &pass);

private:

    VOTE::Util::Token* token;

signals:

    void sigSuccess(QString userType);
    void sigReject(QString message);

    void sigInvalidUrl(QString message);
    void sigValidUrl(QString message);

public slots:

    void getReceivedDataSignIn(QJsonObject *result);
    void getReceivedMessageSignIn(QJsonObject *result);
    void endOffServiceExecution(QString message = {});
};

#endif // SERVICESIGNIN_H
