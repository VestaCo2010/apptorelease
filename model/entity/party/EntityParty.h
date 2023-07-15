#pragma once

#include <QObject>

class EntityParty
{

public:

    EntityParty(const int partyId,
                const QString partyCode,
                const QString partyNameKu,
                const QString partyNameEn,
                const QString partyLogo);

    int partyId() const;
    QString partyCode() const;
    QString partyNameKu() const;
    QString partyNameEn() const;
    QString partyLogo() const;

private:

    int m_partyId;
    QString m_partyCode;
    QString m_partyNameKu;
    QString m_partyNameEn;
    QString m_partyLogo;
};
