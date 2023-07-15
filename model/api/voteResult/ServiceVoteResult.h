#ifndef SERVICEVOTERESULT_H
#define SERVICEVOTERESULT_H

#include <QUrl>
#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>

#include "../../da/NetworkHandler.h"
#include "../../model/voteResult/ModelVotePartyResult.h"
#include "../../model/voteResult/ModelVoteCondidateResult.h"

class ServiceVoteResult : public NetworkHandler
{
    Q_OBJECT

public:

    ServiceVoteResult();
    ~ServiceVoteResult();

    Q_INVOKABLE void requestGetTotalResult();
    Q_INVOKABLE void requestGetVotePartyResult();
    Q_INVOKABLE void requestGetVoteCondidateResult();

    ModelVotePartyResult* modelVotePartyResult() const { return m_modelVotePartyResult; }
    ModelVoteCondidateResult* modelVoteCondidateResult() const { return m_modelVoteCondidateResult; }

private:

    Q_PROPERTY(ModelVotePartyResult* modelVotePartyResult READ modelVotePartyResult WRITE setModelVotePartyResult NOTIFY modelVotePartyResultChanged);
    Q_PROPERTY(ModelVoteCondidateResult* modelVoteCondidateResult READ modelVoteCondidateResult WRITE setModelVoteCondidateResult NOTIFY modelVoteCondidateResultChanged);

    ModelVotePartyResult * m_modelVotePartyResult;
    ModelVoteCondidateResult * m_modelVoteCondidateResult;

signals:

    void sigSuccessGetTotalResult(int totalVote,
                                  int totalFund,
                                  int countFund,
                                  int percentFund);
    void sigRejectGetTotalResult(QString message);

    void sigSuccessGetVotePartyResult();
    void sigRejectGetVotePartyResult(QString message);

    void sigSuccessGetVoteCondidateResult();
    void sigRejectGetVoteCondidateResult(QString message);

    void modelVotePartyResultChanged(ModelVotePartyResult* modelVotePartyResult);
    void modelVoteCondidateResultChanged(ModelVoteCondidateResult* modelVoteCondidateResult);

public slots:

    void getReceivedDataGetTotalResult(QJsonObject *result);
    void getReceivedMessageGetTotalResult(QJsonObject *result);

    void getReceivedDataGetVotePartyResult(QJsonObject *result);
    void getReceivedMessageGetVotePartyResult(QJsonObject *result);

    void getReceivedDataGetVoteCondidateResult(QJsonObject *result);
    void getReceivedMessageGetVoteCondidateResult(QJsonObject *result);

    void endOffServiceExecution(QString message = {});

    void setModelVotePartyResult(ModelVotePartyResult* modelVotePartyResult)
    {
        if (m_modelVotePartyResult == modelVotePartyResult)
            return;

        m_modelVotePartyResult = modelVotePartyResult;
        emit modelVotePartyResultChanged(m_modelVotePartyResult);
    }
    void setModelVoteCondidateResult(ModelVoteCondidateResult* modelVoteCondidateResult)
    {
        if (m_modelVoteCondidateResult == modelVoteCondidateResult)
            return;

        m_modelVoteCondidateResult = modelVoteCondidateResult;
        emit modelVoteCondidateResultChanged(m_modelVoteCondidateResult);
    }
};

#endif // SERVICEVOTERESULT_H
