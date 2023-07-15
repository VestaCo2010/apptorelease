#include "EntityParty.h"


EntityParty::EntityParty(const int partyId, const QString partyCode, const QString partyNameKu, const QString partyNameEn, const QString partyLogo)
    : m_partyId(partyId), m_partyCode(partyCode), m_partyNameKu(partyNameKu), m_partyNameEn(partyNameEn), m_partyLogo(partyLogo)
{

}

int EntityParty::partyId() const
{
    return m_partyId;
}

QString EntityParty::partyCode() const
{
    return m_partyCode;
}

QString EntityParty::partyNameKu() const
{
    return m_partyNameKu;
}

QString EntityParty::partyNameEn() const
{
    return m_partyNameEn;
}

QString EntityParty::partyLogo() const
{
    return m_partyLogo;
}
