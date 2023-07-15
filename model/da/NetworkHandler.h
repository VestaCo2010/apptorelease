#pragma once

#include <QUrl>
#include <QTimer>
#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QSslConfiguration>
#include <QNetworkAccessManager>
#include <QtNetwork/QSslConfiguration>

#include "../../util/log/ClassLog.h"
#include "../../util/error/ClassErrorHandling.h"
#include "../../util/storage/language/Language.h"
#include "../../util/storage/authentication/Token.h"

#define SERVER_SCHEME         "https"
#define SERVER_IP_ADDRESS     "api.voting-iraq.com"
#define SERVER_PORT           0

#define SERVER_NOT_RESPONCE   "SERVER_NOT_RESPONCE"
#define INTERNAL_SERVER_ERROR "INTERNAL_SERVER_ERROR"
#define SERVER_TIME_OUT       "TIME_OUT_SERVICE"
#define TIME_OUT               20000

class NetworkHandler : public QObject , VOTE::Util::ClassLog
{
    Q_OBJECT

public:

    NetworkHandler();
    ~NetworkHandler();
    void sendRequest(const QJsonDocument & json, const QUrl &address, const bool &useToken, const QString &methode);
    static QUrl qUrl;

    QVariant property(const char* name) const;
    void setProperty(const char* name,const QVariant &value);

    VOTE::Util::ClassErrorHandling *classErrorHandling() const;
    void setClassErrorHandling(VOTE::Util::ClassErrorHandling *newClassErrorHandling);
    Q_PROPERTY(VOTE::Util::ClassErrorHandling *classErrorHandling READ classErrorHandling WRITE setClassErrorHandling NOTIFY classErrorHandlingChanged)
    QTimer* timer;

private:

    VOTE::Util::ClassErrorHandling* errorHandling;
    VOTE::Util::ClassErrorHandling* m_classErrorHandling;
    QNetworkAccessManager* networkManager;
    QJsonDocument chashApiJson;
    QUrl chashApiAddress;
    QString chashApiMethod;
    bool isRefreshToken;

signals:

    void sigTimeOut(QString message);
    void sigHidLoading();
    void sigInvalidToken();
    void sigInternalServerError();
    void sigServerNotResponse();
    void sigLoginByUserPass(QJsonObject *result);
    void sigGetRefreshToken(QJsonObject *);
    void sigGetReceivedData(QJsonObject *);
    void sigGetReceivedMessage(QJsonObject *);
    void sigInvalidRefreshToken();
    void classErrorHandlingChanged();

private slots:

    void refreshToken();
    void getResponse(QNetworkReply *reply);
    void getRefreshToken(QJsonObject *result);
    void chashRequest(const QJsonDocument& json, const QUrl &address, const QString &methode);
    void timeOut();
};
