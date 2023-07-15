#include "Token.h"

using namespace VOTE::Util;

QByteArray Token::accessToken = QByteArray();
QByteArray Token::refreshToken = QByteArray();

Token* instanceToken = nullptr;

QObject *Token::getInstanceToken(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if(!instanceToken)
        instanceToken = new Token;

    return instanceToken;
}

Token *Token::getInstanceToken()
{
    if(!instanceToken)
        instanceToken = new Token;

    return instanceToken;
}

void Token::clearToken()
{
    this->accessToken.clear();

    QSettings settings("token_live.ini", QSettings::IniFormat);

    settings.beginGroup("TOKEN");
    settings.setValue("accessToken", "");
    settings.setValue("refreshToken", "");
    settings.endGroup();

    emit sigShowLoginForm();
}

void Token::checkToken()
{
    QSettings settings("token_live.ini", QSettings::IniFormat);

    settings.beginGroup("TOKEN");
    Token::accessToken  = settings.value("accessToken").toByteArray();
    Token::refreshToken = settings.value("refreshToken").toByteArray();
    settings.endGroup();

    if(!Token::accessToken.isEmpty())
        emit sigShowHomeForm();
    else
        emit sigShowLoginForm();
}

Token::~Token()
{
    //    instanceToken->deleteLater();
}

void Token::setToken(const QString &accessToken, const QString &refreshToken)
{
    Token::accessToken = accessToken.toUtf8();
    Token::refreshToken = refreshToken.toUtf8();

    QSettings settings("token_live.ini", QSettings::IniFormat);

    settings.beginGroup("TOKEN");
    settings.setValue("accessToken", accessToken);
    settings.setValue("refreshToken", refreshToken);
    settings.endGroup();
}
