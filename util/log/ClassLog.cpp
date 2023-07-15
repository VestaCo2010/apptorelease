#include "ClassLog.h"
#include "QtCore/qjsondocument.h"

using namespace VOTE::Util;

void VOTE::Util::ClassLog::requestLog(const QString &method, const QString &url, QJsonDocument body)
{
    qDebug() << "";
    qDebug() << "[SEND REQUEST]  :" << getDateTime();
    qDebug() << "[METHOD]        :" << method;
    qDebug() << "[API ADDRESS]   :" << url;

    if(url.contains("uploadVoteImage"))
        qDebug() << "[REQUEST BODY]  : UPLOAD IMAGE";
    else
        qDebug() << "[REQUEST BODY]  :" <<  QJsonDocument(body).toJson(QJsonDocument::Compact).toStdString().c_str();
    qDebug() << "";
}

void VOTE::Util::ClassLog::reciverLog(const QString &url, const int& statusCode, QJsonObject &body)
{
    qDebug() << "";
    qDebug() << "[GET RESPONSE]  :" << getDateTime();
    qDebug() << "[API ADDRESS]   :" << url;
    qDebug() << "[STATUS CODE]   :" << statusCode;
    qDebug() << "[RESULT]        :" << QJsonDocument(body).toJson(QJsonDocument::Compact).toStdString().c_str();;
    qDebug() << "";
}

QString ClassLog::getDateTime()
{
    return QDateTime::currentDateTime().toString("HH:mm:ss:zzz");
}
