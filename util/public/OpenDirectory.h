#pragma once

#include <QDir>
#include <QObject>
#include <QProcess>

namespace VOTE::Util
{

class OpenDirectory : public QObject
{
    Q_OBJECT

public:

    OpenDirectory() = default;
    Q_INVOKABLE void showDirectory(QString address);

}; // OpenDirectory

} // VOTE::Util

