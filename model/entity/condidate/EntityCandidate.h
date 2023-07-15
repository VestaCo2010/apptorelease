#pragma once

#include <QObject>

class EntityCandidate
{

public:

    EntityCandidate(const int partyId,
                    const QString partyCode,
                    const int candidateId,
                    const QString candidateCode,
                    const QString candidateNameKu,
                    const QString candidateNameEn,
                    const QString candidateFamilyKu,
                    const QString candidateFamilyEn);

    int partyId() const;
    QString partyCode() const;
    int candidateId() const;
    QString candidateCode() const;
    QString candidateNameKu() const;
    QString candidateNameEn() const;
    QString candidateFamilyKu() const;
    QString candidateFamilyEn() const;

private:

    int m_partyId;
    QString m_partyCode;
    int m_candidateId;
    QString m_candidateCode;
    QString m_candidateNameKu;
    QString m_candidateNameEn;
    QString m_candidateFamilyKu;
    QString m_candidateFamilyEn;
};
