#pragma once

#include <QUrl>
#include <QFile>
#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QJsonObject>
#include <QJsonDocument>

#include "model/db/DataExist.h"
#include "model/da/SqliteHandler.h"
#include "model/da/NetworkHandler.h"
#include "model/model/condidate/ModelCandidate.h"

class CandidateTbl : public NetworkHandler, private SqliteHandler
{
    Q_OBJECT
    Q_DISABLE_COPY(CandidateTbl)

    explicit CandidateTbl();

public:

    ~CandidateTbl();

    static QObject *getInstanceCandidate(QQmlEngine *engine, QJSEngine *scriptEngine);
    static CandidateTbl* getInstanceCandidate();

    Q_INVOKABLE void requestCandidate();
    Q_INVOKABLE void addToDb(const int &partyId, const QString &partyCode,
                             const int &candidateId, const QString &candidateCode,
                             const QString &candidateNameKu,
                             const QString &candidateNameEn,
                             const QString &candidateFamilyKu,
                             const QString &candidateFamilyEn);
    Q_INVOKABLE void getFromDb(const QString &filter);
    Q_INVOKABLE void clearData();

    ModelCandidate* modelCandidate() const { return m_modelCandidate; }

private:

    Q_PROPERTY(ModelCandidate* modelCandidate READ modelCandidate WRITE setModelCandidate NOTIFY modelCandidateChanged);
    ModelCandidate *m_modelCandidate;

    void createTable() override;
    DataExist dataExist;

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

