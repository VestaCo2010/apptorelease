#ifndef DATAEXIST_H
#define DATAEXIST_H

#include <QObject>
#include <QSettings>
#include <QStandardPaths>

class DataExist : public QObject
{
    Q_OBJECT

public:

    DataExist();

    Q_INVOKABLE void checkPartyTbl();
    Q_INVOKABLE void checkCandidateTbl();
    Q_INVOKABLE void clearDate();

    void syncPartyTbl();
    void syncCandidateTbl();

private:

    QSettings* m_setting;

signals:

    void sigExistPartyTbl();
    void sigNotExistPartyTbl();
    void sigExistCandidateTbl();
    void sigNotExistCandidateTbl();
};

#endif // DATAEXIST_H
