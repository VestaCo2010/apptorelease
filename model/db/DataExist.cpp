#include "DataExist.h"


DataExist::DataExist()
{
#ifdef Q_OS_ANDROID
    m_setting = new QSettings(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) +"/existDataTbl.ini", QSettings::IniFormat);
#else
    m_setting = new QSettings("existDataTbl.ini", QSettings::IniFormat);
#endif
}

void DataExist::checkPartyTbl()
{
    m_setting->beginGroup("partyTbl");
    QString val = m_setting->value("state").toByteArray();
    m_setting->endGroup();

    if(val == "OK")
        emit sigExistPartyTbl();
    else
        emit sigNotExistPartyTbl();
}

void DataExist::checkCandidateTbl()
{
    m_setting->beginGroup("candidateTbl");
    QString val = m_setting->value("state").toByteArray();
    m_setting->endGroup();

    if(val == "OK")
        emit sigExistCandidateTbl();
    else
        emit sigNotExistCandidateTbl();
}

void DataExist::clearDate()
{
    m_setting->beginGroup("partyTbl");
    m_setting->setValue("state", "");
    m_setting->endGroup();

    m_setting->beginGroup("candidateTbl");
    m_setting->setValue("state", "");
    m_setting->endGroup();
}

void DataExist::syncPartyTbl()
{
    m_setting->beginGroup("partyTbl");
    m_setting->setValue("state", "OK");
    m_setting->endGroup();
}

void DataExist::syncCandidateTbl()
{
    m_setting->beginGroup("candidateTbl");
    m_setting->setValue("state", "OK");
    m_setting->endGroup();
}
