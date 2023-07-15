#include "ServiceUserManagement.h"
#include "qurlquery.h"

ServiceUserManagement::ServiceUserManagement()
{
    connect(this, SIGNAL(sigTimeOut(QString)), this, SLOT(endOffServiceExecution(QString)));
}

// [Input validation]
void ServiceUserManagement::validatePersonalityInfo(const QString name, const QString family)
{
    if (name.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Name is required"));
        return;
    }

    if (family.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Family is required"));
        return;
    }

    m_name = name;
    m_family = family;

    emit sigSuccessValidateInfo();
}

void ServiceUserManagement::validateLocationInfo(const QString region, const QString fundNumber, const QString pollesterId)
{
    if (region.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Center code is required"));
        return;
    }

    if (fundNumber.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Fund code is required"));
        return;
    }

    if (pollesterId.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Supervisor code is required"));
        return;
    }

    m_region = region;
    m_fundNumber = fundNumber;
    m_pollesterId = pollesterId;

    requestVerifyFundNumber(region, fundNumber, pollesterId);
}

void ServiceUserManagement::validateAccountInfo(const QString mobile, const QString username)
{
    if (mobile.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Mobile is required"));
        return;
    }

    if (username.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Username is required"));
        return;
    }

    m_mobile = mobile;
    m_username = username;

    emit sigSuccessValidateInfo();
}

void ServiceUserManagement::validatePasswordInfo(const QString password, const QString confirmPassword)
{
    if (password.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Password is required"));
        return;
    }

    if (password.length() < 10){
        emit sigRejectValidateInfo(QObject::tr("Password at least 10 character is required"));
        return;
    }

    if (confirmPassword.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Confirm password is required"));
        return;
    }

    if (password != confirmPassword){
        emit sigRejectValidateInfo(QObject::tr("Password and confirm password are not equal"));
        return;
    }

    m_password = password;

    emit sigSuccessValidateInfo();
}

void ServiceUserManagement::validateImageInfo(const QString image)
{
    if (image.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Image is required"));
        return;
    }

    emit sigSuccessValidateInfo();
}

void ServiceUserManagement::validateEditPasswordInfo(const QString currentPassword, const QString newPassword, const QString confirmPassword)
{
    if (currentPassword.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Password is required"));
        return;
    }

    if (newPassword.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("New password is required"));
        return;
    }

    if (confirmPassword.isEmpty()){
        emit sigRejectValidateInfo(QObject::tr("Confirm password is required"));
        return;
    }

    if ( newPassword != confirmPassword ){
        emit sigRejectValidateInfo(QObject::tr("New password and confirm password are not equal"));
        return;
    }

    editUserPassword(currentPassword,newPassword);
}


// [Register User Profile]
void ServiceUserManagement::registerUser(const int imageId)
{
    QJsonObject qJsonObject;
    qJsonObject.insert("name", m_name);
    qJsonObject.insert("family", m_family);
    qJsonObject.insert("fundId", m_fundId);
    qJsonObject.insert("mobile", m_mobile);
    qJsonObject.insert("username", m_username);
    qJsonObject.insert("password", m_password);
    qJsonObject.insert("imageId", imageId);
    qJsonObject.insert("state", 0);
    QJsonDocument qJsonDocument(qJsonObject);

    QUrl qUrl;
    qUrl.setPath("/signUp");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataRegisterUser(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageRegisterUser(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, false, "POST");
}

void ServiceUserManagement::getReceivedDataRegisterUser(QJsonObject *result)
{
    endOffServiceExecution();

    emit sigSuccessRegisterUser((*result)["result"].toObject()["message"].toString());
    result = nullptr;
}

void ServiceUserManagement::getReceivedMessageRegisterUser(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count()==0)
        emit sigRejectRegisterUser((*result)["result"].toObject()["message"].toString());
    else {
        QString message {};
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectRegisterUser(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}


// [Get User Profile]
void ServiceUserManagement::getUserProfile()
{
    QJsonDocument qJsonDocument;

    QUrl qUrl;
    qUrl.setPath("/profile");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataGetUserProfile(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageGetUserProfile(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "GET");
}

void ServiceUserManagement::getReceivedDataGetUserProfile(QJsonObject *result)
{
    endOffServiceExecution();

    QJsonObject data = (*result)["result"].toObject()["data"].toObject();
    emit sigSuccessGetUserProfile(data["id"].toInt(),
            data["name"].toString(),
            data["family"].toString(),
            QString::number(data["pollsterId"].toInt()),
            data["province"].toString(),
            data["city"].toString(),
            data["region"].toString(),
            data["fundNumber"].toString(),
            data["username"].toString(),
            data["mobile"].toString(),
            data["image"].toString(),
            data["userType"].toString(),
            data["flag"].toInt());

    result = nullptr;
}

void ServiceUserManagement::getReceivedMessageGetUserProfile(QJsonObject *result)
{
    endOffServiceExecution();
    if((*result)["message"].toArray().count()==0) {
        emit sigRejectGetUserProfile((*result)["result"].toObject()["message"].toString());
    } else {
        QString message {};
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectGetUserProfile(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}


//[Edit User Password]
void ServiceUserManagement::editUserPassword(const QString currentPassword, const QString newPassword)
{
    QJsonObject qJsonObject;
    qJsonObject.insert("currentPassword", currentPassword);
    qJsonObject.insert("newPassword", newPassword);
    QJsonDocument qJsonDocument(qJsonObject);

    QUrl qUrl;
    qUrl.setPath("/editPassword");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataEditUserPassword(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageEditUserPassword(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "POST");
}

void ServiceUserManagement::getReceivedDataEditUserPassword(QJsonObject *result)
{
    endOffServiceExecution();

    emit sigSuccessEditUserPassword((*result)["result"].toObject()["message"].toString());
    result = nullptr;
}

void ServiceUserManagement::getReceivedMessageEditUserPassword(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count()==0) {
        emit sigRejectEditUserPassword((*result)["result"].toObject()["message"].toString());
    } else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectEditUserPassword(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}

// [Delete user]
void ServiceUserManagement::deleteUser(const int userId)
{
    QJsonDocument qJsonDocument;


    QUrlQuery querystr;
    querystr.addQueryItem("userId", QString::number(userId));

    QUrl qUrl;
    qUrl.setPath("/user");

    qUrl.setQuery(querystr);

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataDeleteUser(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageDeleteUser(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "DELETE");
}

void ServiceUserManagement::getReceivedDataDeleteUser(QJsonObject *result)
{
    endOffServiceExecution();

    emit sigSuccessDeleteUser((*result)["result"].toObject()["message"].toString());
    result = nullptr;
}

void ServiceUserManagement::getReceivedMessageDeleteUser(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count()==0) {
        emit sigRejectDeleteUser((*result)["result"].toObject()["message"].toString());
    } else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectDeleteUser(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}

// [Verify fund number]
void ServiceUserManagement::requestVerifyFundNumber(const QString& region, const QString& fundNumber, const QString& pollesterId)
{
    QJsonObject qJsonObject;
    qJsonObject.insert("region", region);
    qJsonObject.insert("fundNumber", fundNumber);
    qJsonObject.insert("pollsterId", pollesterId.toInt());

    QJsonDocument qJsonDocument(qJsonObject);

    QUrl qUrl;
    qUrl.setPath("/fundVerify");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataVerifyFundNumber(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageVerifyFundNumber(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "POST");
}

void ServiceUserManagement::getReceivedDataVerifyFundNumber(QJsonObject *result)
{
    endOffServiceExecution();

    m_fundId = (*result)["result"].toObject()["data"].toObject()["fundId"].toInt();
    emit sigSuccessVerifyFundNumber();
    result = nullptr;
}

void ServiceUserManagement::getReceivedMessageVerifyFundNumber(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count() == 0) {
        emit sigRejectVerifyFundNumber((*result)["result"].toObject()["message"].toString());
    } else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectVerifyFundNumber(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}



void ServiceUserManagement::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataRegisterUser(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageRegisterUser(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataGetUserProfile(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageGetUserProfile(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataEditUserPassword(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageEditUserPassword(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataDeleteUser(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageDeleteUser(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataVerifyFundNumber(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageVerifyFundNumber(QJsonObject*)));
}
