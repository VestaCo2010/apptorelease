#pragma once

#include <QDebug>
#include <QObject>
#include <QSettings>
#include <QQmlEngine>
#include <QStandardPaths>

namespace VOTE::Util
{

class Language : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(Language)

public:

    explicit Language(QObject *parent = nullptr);
    ~Language();

    static QObject *getInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static Language* getInstance();

    static QString currentLanguage;

    Q_INVOKABLE void setLanguage(QString language);
    Q_INVOKABLE void getLanguage();

signals:

    void sigGetLanguage(QString lang);

private:

    QSettings* m_setting;

}; // Language

} // VOTE::Util
