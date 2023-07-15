#pragma once

#include <QObject>
#include <QSettings>
#include <QStandardPaths>
#include <QQmlEngine>

namespace VOTE::Util
{

class Token : public QObject
{
    Q_OBJECT

public:

    Token() = default;
    ~Token();

    static QObject *getInstanceToken(QQmlEngine *engine, QJSEngine *scriptEngine);
    static Token* getInstanceToken();

    static QByteArray accessToken;
    static QByteArray refreshToken;
    static void setToken(const QString &accessToken, const QString &refreshToken);

    Q_INVOKABLE void clearToken();
    Q_INVOKABLE void checkToken();


signals:

    void sigShowHomeForm();
    void sigShowLoginForm();

}; // Token

} // VOTE::Util

