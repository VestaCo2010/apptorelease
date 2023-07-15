#pragma once

#include <QUrl>
#include <QFile>
#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QJsonObject>
#include <QJsonDocument>

#include "model/da/NetworkHandler.h"
#include "model/model/party/ModelParty.h"

class ServiceParty : public NetworkHandler
{
    Q_OBJECT

public:

    ServiceParty();
    ~ServiceParty();

    Q_INVOKABLE void requestParty();
    ModelParty* modelParty() const { return m_modelParty; }

private:

    Q_PROPERTY(ModelParty* modelParty READ modelParty WRITE setModelParty NOTIFY modelPartyChanged);
    ModelParty *m_modelParty;

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

