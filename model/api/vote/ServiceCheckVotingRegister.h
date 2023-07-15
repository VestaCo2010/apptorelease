#ifndef SERVICECHECKVOTINGREGISTER_H
#define SERVICECHECKVOTINGREGISTER_H

#include <QUrl>
#include <QObject>
#include <QVariant>
#include <QJsonObject>
#include <QJsonDocument>

#include "../../da/NetworkHandler.h"

class ServiceCheckVotingRegister : public NetworkHandler
{
    Q_OBJECT

public:

    ServiceCheckVotingRegister() = default;
    Q_INVOKABLE void requestCheckPartyVotingRegister();
    Q_INVOKABLE void requestCheckCandidateVotingRegister();

signals:

    void sigWaitingPartyVoteRegister(QString partyState,
                                     QString partyMessage);
    void sigReadyPartyVoteRegister();

    void sigWaitingCandidateVoteRegister(QString condidateState,
                                         QString condidateMessage);
    void sigReadyCandidateVoteRegister();

public slots:

    void getReceivedDataCheckPartyVotingRegister(QJsonObject *result);
    void getReceivedMessageCheckPartyVotingRegister(QJsonObject *result);
    void getReceivedDataCheckCondidateVotingRegister(QJsonObject *result);
    void getReceivedMessageCheckCondidateVotingRegister(QJsonObject *result);
    void endOffServiceExecution(QString message = {});
};

#endif // SERVICECHECKVOTINGREGISTER_H
