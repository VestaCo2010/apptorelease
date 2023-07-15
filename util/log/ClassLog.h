#pragma once

#include <QDebug>
#include "QDateTime"

namespace VOTE::Util
{

class ClassLog
{

public:

    ClassLog() = default;
    void requestLog(const QString& method, const QString &url, QJsonDocument body);
    void reciverLog(const QString &url, const int &statusCode, QJsonObject &body);
    QString getDateTime();

}; // ClassLog

} // VOTE::Util
