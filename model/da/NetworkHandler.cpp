#include "NetworkHandler.h"

QUrl NetworkHandler::qUrl;

NetworkHandler::NetworkHandler()
{
    timer = new QTimer;
    timer->setSingleShot(true);

    isRefreshToken  = false;
    chashApiJson    = QJsonDocument();
    chashApiAddress = QString();
    chashApiMethod  = QString();

    networkManager  = new QNetworkAccessManager();
    errorHandling   = new VOTE::Util::ClassErrorHandling();

    connect(timer, SIGNAL(timeout()), this, SLOT(timeOut()));
    connect(networkManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(getResponse(QNetworkReply*)));
}

NetworkHandler::~NetworkHandler()
{
    errorHandling->deleteLater();
    networkManager->deleteLater();
    timer->deleteLater();
}

void NetworkHandler::sendRequest(const QJsonDocument& json, const QUrl& address, const bool& useToken, const QString &methode)
{
    chashRequest(json, address, methode);

    qUrl.setScheme(SERVER_SCHEME);
    qUrl.setHost(SERVER_IP_ADDRESS);
    if(SERVER_PORT)
        qUrl.setPort(SERVER_PORT);
    qUrl.setPath(address.path());
    qUrl.setQuery(address.query());

    QString strJson(json.toJson(QJsonDocument::Compact));
    QByteArray qByteArray(strJson.toUtf8());

    QSslConfiguration config = QSslConfiguration::defaultConfiguration();
    config.setProtocol(QSsl::AnyProtocol); // TlsV1_2 TlsV1SslV3 AnyProtocol

    QNetworkRequest request;
    request.setSslConfiguration(config);
    request.setUrl(qUrl);

    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    QSslConfiguration::setDefaultConfiguration(conf);
    request.setSslConfiguration(conf);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("accept-language", VOTE::Util::Language::currentLanguage.toUtf8());

    if(useToken){
        request.setRawHeader("token", VOTE::Util::Token::accessToken);
    }

    networkManager->setProperty("apiAddress", qUrl.toString());

    if(methode == "POST")
        networkManager->post(request, qByteArray);
    else if(methode == "GET")
        networkManager->get(request);
    else if(methode == "DELETE")
        networkManager->deleteResource(request);
    else if(methode == "PUT")
        networkManager->put(request,qByteArray);

    timer->stop();
    timer->start(TIME_OUT);

    // Display log data sent to the server
#ifdef QT_DEBUG
    VOTE::Util::ClassLog::requestLog(methode, qUrl.toString(), json);
#endif
}

QVariant NetworkHandler::property(const char *name) const
{
    return networkManager->property(name);
}

void NetworkHandler::setProperty(const char *name, const QVariant &value)
{
    networkManager->setProperty(name,value);
}

void NetworkHandler::getResponse(QNetworkReply *reply)
{
    timer->stop();
    emit sigHidLoading();

    QJsonDocument qJsonDocument = QJsonDocument::fromJson(reply->readAll());
    QJsonObject* qJsonObject = new QJsonObject(qJsonDocument.object());

    // int httpStatusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    // int httpStatusCode = (*qJsonObject)["result"].toObject()["code"].toInt();

    // Display log data received from the server
#ifdef QT_DEBUG
    VOTE::Util::ClassLog::reciverLog(networkManager->property("apiAddress").toString(), httpStatusCode, (*qJsonObject));
#endif

    if(isRefreshToken) {
        emit sigGetRefreshToken(qJsonObject);
    }
    // Get data
    else if ((*qJsonObject)["result"].toObject()["code"].toInt() == 200) {
        emit sigGetReceivedData(qJsonObject);
    }
    // Get Message
    else if ((*qJsonObject)["result"].toObject()["code"].toInt() == 204) {
        emit sigGetReceivedMessage(qJsonObject);
    }
    // Expire token
    else if ((*qJsonObject)["result"].toInt() == 401) {
        if(m_classErrorHandling) {
            m_classErrorHandling->showLoginPage();
        }
        emit sigGetReceivedMessage(qJsonObject);
    }
    // Input validation error
    else if ((*qJsonObject)["result"].toObject()["code"].toInt() == 400) {
        if(m_classErrorHandling) {
            m_classErrorHandling->showLoginPage();
        }
        emit sigGetReceivedMessage(qJsonObject);
    }
    // Internal server error
    else if ((*qJsonObject)["result"].toInt() == 500) {
        if(m_classErrorHandling) {
            m_classErrorHandling->showError(INTERNAL_SERVER_ERROR);
        }
        emit sigInternalServerError();
    }
    else {
        emit sigGetReceivedMessage(qJsonObject);
    }

    qJsonDocument = QJsonDocument();
    reply->deleteLater();
}

void NetworkHandler::refreshToken()
{
    isRefreshToken = true;

    QJsonObject qJsonObject;
    // qJsonObject.insert("refreshToken", QString::fromUtf8(VOTE::Util::Token::refreshToken));

    QJsonDocument qJsonDocument(qJsonObject);

    QUrl qUrl;
    qUrl.setPath("/api/v1/users/sessions");

    sendRequest(qJsonDocument, qUrl, false,"PUT");
    connect(this, SIGNAL(sigGetRefreshToken(QJsonObject*)), this, SLOT(getRefreshToken(QJsonObject*)));
}

void NetworkHandler::getRefreshToken(QJsonObject *result)
{
    isRefreshToken = false;

    if((*result)["status"].toInt() == 200) {
        VOTE::Util::Token::setToken((*result)["result"].toObject()["jwt"].toString().toUtf8(),
                (*result)["result"].toObject()["refreshToken"].toString().toUtf8());
        sendRequest(chashApiJson, chashApiAddress, true, chashApiMethod);
    } else {
        emit sigInvalidRefreshToken();
    }
}

void NetworkHandler::chashRequest(const QJsonDocument &json, const QUrl &address, const QString &methode)
{
    if(!isRefreshToken) {
        chashApiJson = json;
        chashApiAddress = address;
        chashApiMethod = methode;
    }
}

void NetworkHandler::timeOut()
{
    emit sigTimeOut(SERVER_TIME_OUT);
    emit sigHidLoading();
}

VOTE::Util::ClassErrorHandling *NetworkHandler::classErrorHandling() const
{
    return m_classErrorHandling;
}

void NetworkHandler::setClassErrorHandling(VOTE::Util::ClassErrorHandling *newClassErrorHandling)
{
    if (m_classErrorHandling == newClassErrorHandling)
        return;

    m_classErrorHandling = newClassErrorHandling;
    emit classErrorHandlingChanged();
}
