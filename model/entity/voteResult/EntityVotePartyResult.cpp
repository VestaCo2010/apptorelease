#include "EntityVotePartyResult.h"


EntityVotePartyResult::EntityVotePartyResult(const int partyId, const QString partyNameEn, const QString partyNameKu, const QString partyCode,
                                             const QString partyLogo, const int voteCount, const float votePercent)
    : m_partyId(partyId), m_partyNameEn(partyNameEn), m_partyNameKu(partyNameKu), m_partyCode(partyCode), m_partyLogo(partyLogo), m_voteCount(voteCount), m_votePercent(votePercent)
{

}

int EntityVotePartyResult::partyId() const
{
    return m_partyId;
}

QString EntityVotePartyResult::partyNameEn() const
{
    return m_partyNameEn;
}

QString EntityVotePartyResult::partyNameKu() const
{
    return m_partyNameKu;
}

QString EntityVotePartyResult::partyCode() const
{
    return m_partyCode;
}

QString EntityVotePartyResult::partyLogo() const
{
    return m_partyLogo;
}

int EntityVotePartyResult::voteCount() const
{
    return m_voteCount;
}

float EntityVotePartyResult::votePercent() const
{
    return m_votePercent;
}
