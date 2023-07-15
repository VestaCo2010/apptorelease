#ifndef ENTITYVOTECONDIDATERESULT_H
#define ENTITYVOTECONDIDATERESULT_H

#include <QObject>

class EntityVoteCondidateResult
{

public:

    explicit EntityVoteCondidateResult(const QString candidateNameEn,
                                       const QString candidateNameKu,
                                       const QString candidateFamilyEn,
                                       const QString candidateFamilyKu,
                                       const QString candidateCode,
                                       const int voteCount,
                                       const float votePercent);

    QString candidateNameEn() const;
    QString candidateNameKu() const;
    QString candidateFamilyEn() const;
    QString candidateFamilyKu() const;
    QString candidateCode() const;
    int voteCount() const;
    float votePercent() const;

private:

    QString m_candidateNameEn;
    QString m_candidateNameKu;
    QString m_candidateFamilyEn;
    QString m_candidateFamilyKu;
    QString m_candidateCode;
    int m_voteCount;
    float m_votePercent;
};

#endif // ENTITYVOTECONDIDATERESULT_H
