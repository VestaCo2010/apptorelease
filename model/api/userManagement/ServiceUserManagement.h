#ifndef SERVICEUSERMANAGEMENT_H
#define SERVICEUSERMANAGEMENT_H

#include <QUrl>
#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>

#include "../../da/NetworkHandler.h"

//#include "QtCore/qstring.h"
//#include "QtCore/qtmetamacros.h"

class ServiceUserManagement : public NetworkHandler
{
    Q_OBJECT

public:

    ServiceUserManagement();

    // Validaition Methods
    Q_INVOKABLE void validatePersonalityInfo(const QString name, const QString family);
    Q_INVOKABLE void validateLocationInfo(const QString region, const QString fundNumber, const QString pollesterId);
    Q_INVOKABLE void validateAccountInfo(const QString mobile, const QString username);
    Q_INVOKABLE void validatePasswordInfo(const QString password, const QString confirmPassword);
    Q_INVOKABLE void validateImageInfo(const QString image);
    Q_INVOKABLE void validateEditPasswordInfo(const QString currentPassword, const QString newPassword, const QString confirmPassword);

    // API Service Methods
    Q_INVOKABLE void registerUser(const int imageId);
    Q_INVOKABLE void getUserProfile();
    Q_INVOKABLE void editUserPassword(const QString currentPassword, const QString newPassword);
    Q_INVOKABLE void deleteUser(const int userId);
    Q_INVOKABLE void requestVerifyFundNumber(const QString &region, const QString &fundNumber, const QString& pollesterId);

private:

    QString m_name;
    QString m_family;
    QString m_province;
    QString m_city;

    QString m_region;
    QString m_fundNumber;
    QString m_pollesterId;

    int m_fundId;

    QString m_mobile;
    QString m_username;
    QString m_password;

signals:

    // validation Signals
    void sigSuccessValidateInfo();
    void sigRejectValidateInfo(QString message);

    // Signals of Register User
    void sigSuccessRegisterUser(QString message);
    void sigRejectRegisterUser(QString message);

    // Signals of Get User Profiles
    void sigSuccessGetUserProfile(int userId, QString name, QString family, QString pollsterId,
                                  QString province, QString city, QString region,
                                  QString fundNumber, QString username, QString mobile,
                                  QString image, QString userType, int userHasDelete);
    void sigRejectGetUserProfile(QString message);

    // Signals of Edit User Password
    void sigSuccessEditUserPassword(QString message);
    void sigRejectEditUserPassword(QString message);

    // Signals of Delete User
    void sigSuccessDeleteUser(QString message);
    void sigRejectDeleteUser(QString message);

    // Signals of fund number
    void sigSuccessVerifyFundNumber();
    void sigRejectVerifyFundNumber(QString message);

public slots:

    // Slots of Register Users
    void getReceivedDataRegisterUser(QJsonObject *result);
    void getReceivedMessageRegisterUser(QJsonObject *result);

    // Slots of Get User Profiles
    void getReceivedDataGetUserProfile(QJsonObject *result);
    void getReceivedMessageGetUserProfile(QJsonObject *result);

    // Slots of Edit User Password
    void getReceivedDataEditUserPassword(QJsonObject *result);
    void getReceivedMessageEditUserPassword(QJsonObject *result);

    // Slots of Delete User
    void getReceivedDataDeleteUser(QJsonObject *result);
    void getReceivedMessageDeleteUser(QJsonObject *result);

    // Slots of verify fund number
    void getReceivedDataVerifyFundNumber(QJsonObject *result);
    void getReceivedMessageVerifyFundNumber(QJsonObject *result);

    // End
    void endOffServiceExecution(QString message = {});

};

#endif // SERVICEUSERMANAGEMENT_H
