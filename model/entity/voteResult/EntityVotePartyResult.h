#ifndef ENTITYVOTEPARTYRESULT_H
#define ENTITYVOTEPARTYRESULT_H

#include <QObject>

class EntityVotePartyResult
{

public:

    explicit EntityVotePartyResult(const int partyId,
                                   const QString partyNameEn,
                                   const QString partyNameKu,
                                   const QString partyCode,
                                   const QString partyLogo,
                                   const int voteCount,
                                   const float votePercent);

    int partyId() const;
    QString partyNameEn() const;
    QString partyNameKu() const;
    QString partyCode() const;
    QString partyLogo() const;
    int voteCount() const;
    float votePercent() const;

private:

    int m_partyId;
    QString m_partyNameEn;
    QString m_partyNameKu;
    QString m_partyCode;
    QString m_partyLogo;
    int m_voteCount;
    float m_votePercent;
};

#endif // ENTITYVOTEPARTYRESULT_H
