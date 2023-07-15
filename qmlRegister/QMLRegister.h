#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QQmlContext>

class QMLRegister : public QObject
{
    Q_OBJECT

public:

    QMLRegister(QQmlEngine *engine);

private:

    QQmlEngine *_engine;
};
