#include "EntityCandidate.h"


EntityCandidate::EntityCandidate(const int partyId, const QString partyCode,
                                 const int candidateId, const QString candidateCode,
                                 const QString candidateNameKu, const QString candidateNameEn,
                                 const QString candidateFamilyKu, const QString candidateFamilyEn) :
    m_partyId(partyId), m_partyCode(partyCode), m_candidateId(candidateId), m_candidateCode(candidateCode),
    m_candidateNameKu(candidateNameKu), m_candidateNameEn(candidateNameEn),
    m_candidateFamilyKu(candidateFamilyKu), m_candidateFamilyEn(candidateFamilyEn)
{

}

int EntityCandidate::partyId() const
{
    return m_partyId;
}

QString EntityCandidate::partyCode() const
{
    return m_partyCode;
}

int EntityCandidate::candidateId() const
{
    return m_candidateId;
}

QString EntityCandidate::candidateCode() const
{
    return m_candidateCode;
}

QString EntityCandidate::candidateNameKu() const
{
    return m_candidateNameKu;
}

QString EntityCandidate::candidateNameEn() const
{
    return m_candidateNameEn;
}

QString EntityCandidate::candidateFamilyKu() const
{
    return m_candidateFamilyKu;
}

QString EntityCandidate::candidateFamilyEn() const
{
    return m_candidateFamilyEn;
}
