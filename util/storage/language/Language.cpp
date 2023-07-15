#include "Language.h"

using namespace VOTE::Util;

Language* instance = nullptr;
QString Language::currentLanguage = {"en"};

QObject *Language::getInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if(!instance)
        instance = new Language;

    return instance;
}

Language *Language::getInstance()
{
    if(!instance)
        instance = new Language;

    return instance;
}

Language::Language(QObject *parent) : QObject{parent}
{
    m_setting = new QSettings(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation)
                              + "/language_config.ini", QSettings::IniFormat);

    if(m_setting->value("language").toString() == "")
        m_setting->setValue("language","en");
}

Language::~Language()
{
    instance->deleteLater();
    delete m_setting;
}

void Language::setLanguage(QString language)
{
    m_setting->setValue("language", language);
    getLanguage();
}

void Language::getLanguage()
{
    currentLanguage = m_setting->value("language").toString();
    emit sigGetLanguage(currentLanguage);
}
