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
#include "model/model/party/ModelParty.h"

class PartyTbl : public NetworkHandler, private SqliteHandler
{
    Q_OBJECT
    Q_DISABLE_COPY(PartyTbl)

    explicit PartyTbl();

public:

    ~PartyTbl();

    static QObject *getInstanceParty(QQmlEngine *engine, QJSEngine *scriptEngine);
    static PartyTbl* getInstanceParty();

    Q_INVOKABLE void requestParty();
    Q_INVOKABLE void addToDb(const int &partyId,
                             const QString &partyCode,
                             const QString &partyNameKu,
                             const QString &partyNameEn,
                             const QString &partyLogo);
    Q_INVOKABLE void getFromDb(const QString &filter);
    Q_INVOKABLE void clearData();

    Q_INVOKABLE QString getPartyNameFromDb(const int &partyId, const bool& isEn);

    ModelParty* modelParty() const { return m_modelParty; }

private:

    Q_PROPERTY(ModelParty* modelParty READ modelParty WRITE setModelParty NOTIFY modelPartyChanged);
    ModelParty *m_modelParty;

    void createTable() override;
    DataExist dataExist;

signals:

    void sigSuccessGetParty();
    void sigRejectGetParty(QString message);
    void modelPartyChanged(ModelParty* modelParty);

public slots:

    void getReceivedDataParty(QJsonObject *result);
    void getReceivedMessageParty(QJsonObject *result);
    void endOffServiceExecution(QString message = {});
    void setModelParty(ModelParty *modelParty)
    {
        if (m_modelParty == modelParty)
            return;

        m_modelParty = modelParty;
        emit modelPartyChanged(m_modelParty);
    }
};

