#include "ServiceSignIn.h"

ServiceSignIn::ServiceSignIn()
{
    token = new VOTE::Util::Token();
    connect(this, SIGNAL(sigTimeOut(QString)), this, SLOT(endOffServiceExecution(QString)));
}

ServiceSignIn::~ServiceSignIn()
{   
    token->deleteLater();
}

// Signin
void ServiceSignIn::signIn(const QString& username, const QString& pass)
{
    QJsonObject qJsonObject;
    qJsonObject.insert("username", username);
    qJsonObject.insert("password", pass);
    QJsonDocument qJsonDocument(qJsonObject);

    QUrl qUrl;
    qUrl.setPath("/signIn");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataSignIn(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageSignIn(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, false, "POST");
}

void ServiceSignIn::getReceivedDataSignIn(QJsonObject *result)
{
    endOffServiceExecution();

    QString userType = (*result)["result"].toObject()["data"].toObject()["userType"].toString();

    if(userType == "admin") {
        emit sigReject(QObject::tr("This account is not allowed to enter the application"));
    } else {
        token->setToken((*result)["result"].toObject()["data"].toObject()["accessToken"].toString(),
                        (*result)["result"].toObject()["data"].toObject()["refreshToken"].toString());

        emit sigSuccess(userType);
    }

    result = nullptr;
}

void ServiceSignIn::getReceivedMessageSignIn(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count()==0)
        emit sigReject((*result)["result"].toObject()["message"].toString());
    else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigReject(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}

// Disconnect signal
void ServiceSignIn::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataSignIn(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageSignIn(QJsonObject*)));
}
