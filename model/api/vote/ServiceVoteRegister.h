#ifndef SERVICEVOTEREGISTER_H
#define SERVICEVOTEREGISTER_H

#include <QUrl>
#include <QObject>
#include <QVariant>
#include <QJsonObject>
#include <QJsonDocument>

#include "../../da/NetworkHandler.h"

class ServiceVoteRegister : public NetworkHandler
{
    Q_OBJECT

public:

    ServiceVoteRegister();
    Q_INVOKABLE void requestPartyVoteVerify(const QVariantList& array);
    Q_INVOKABLE void requestPartyVoteRegister(const QString& imageId);

    Q_INVOKABLE void requestCondidateVoteVerify(const QVariantList& array);
    Q_INVOKABLE void requestCondidateVoteRegister(const QString& imageId);

signals:

    // Party signals
    void sigSuccessPartyVoteVerify();
    void sigSuccessPartyVoteRegister();
    void sigRejectPartyVoteRegister();

    // Condidate signals
    void sigSuccessVerifyVoteRegister();
    void sigSuccessCondidateVoteRegister();
    void sigRejectCondidateVoteRegister();

public slots:

    // Party slots
    void getReceivedDataPartyVoteRegister(QJsonObject *result);
    void getReceivedMessagePartyVoteRegister(QJsonObject *result);

    // Condidate slots
    void getReceivedDataCondidateVoteRegister(QJsonObject *result);
    void getReceivedMessageCondidateVoteRegister(QJsonObject *result);

    void endOffServiceExecution(QString message = {});

private:

    QJsonArray m_qJsonArrayParty;
    QJsonArray m_qJsonArrayCondidate;
};

#endif // SERVICEVOTEREGISTER_H
