#include "EntityVoteCondidateResult.h"

EntityVoteCondidateResult::EntityVoteCondidateResult(const QString candidateNameEn,
                                                     const QString candidateNameKu,
                                                     const QString candidateFamilyEn,
                                                     const QString candidateFamilyKu,
                                                     const QString candidateCode,
                                                     const int voteCount,
                                                     const float votePercent) :
    m_candidateNameEn(candidateNameEn), m_candidateNameKu(candidateNameKu),
    m_candidateFamilyEn(candidateFamilyEn), m_candidateFamilyKu(candidateFamilyKu),
    m_candidateCode(candidateCode), m_voteCount(voteCount), m_votePercent(votePercent)
{

}

QString EntityVoteCondidateResult::candidateNameEn() const
{
    return m_candidateNameEn;
}

QString EntityVoteCondidateResult::candidateNameKu() const
{
    return m_candidateNameKu;
}

QString EntityVoteCondidateResult::candidateFamilyEn() const
{
    return m_candidateFamilyEn;
}

QString EntityVoteCondidateResult::candidateFamilyKu() const
{
    return m_candidateFamilyKu;
}

QString EntityVoteCondidateResult::candidateCode() const
{
    return m_candidateCode;
}

int EntityVoteCondidateResult::voteCount() const
{
    return m_voteCount;
}

float EntityVoteCondidateResult::votePercent() const
{
    return m_votePercent;
}
