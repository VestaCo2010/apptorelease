#pragma once

#include <QUrl>
#include <QFile>
#include <QDebug>
#include <QObject>
#include <QUrlQuery>
#include <QQmlEngine>
#include <QJsonObject>
#include <QJsonDocument>

#include "model/da/NetworkHandler.h"
#include "model/model/condidate/ModelCandidate.h"

class ServiceCandidate : public NetworkHandler
{
    Q_OBJECT

public:

    ServiceCandidate();
    ~ServiceCandidate();

    Q_INVOKABLE void requestCandidate();
    ModelCandidate* modelCandidate() const { return m_modelCandidate; }

private:

    Q_PROPERTY(ModelCandidate* modelCandidate READ modelCandidate WRITE setModelCandidate NOTIFY modelCandidateChanged);
    ModelCandidate *m_modelCandidate;

signals:

    void sigSuccessGetCandidate();
    void sigRejectGetCandidate(QString message);
    void modelCandidateChanged(ModelCandidate* modelCandidate);

public slots:

    void getReceivedDataCandidate(QJsonObject *result);
    void getReceivedMessageCandidate(QJsonObject *result);
    void endOffServiceExecution(QString message = {});
    void setModelCandidate(ModelCandidate *modelCandidate)
    {
        if (m_modelCandidate == modelCandidate)
            return;

        m_modelCandidate = modelCandidate;
        emit modelCandidateChanged(m_modelCandidate);
    }
};

