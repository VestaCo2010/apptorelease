#include "ModelVoteCondidateResult.h"

ModelVoteCondidateResult::ModelVoteCondidateResult(QObject *parent) : QAbstractListModel{parent}
{

}
void ModelVoteCondidateResult::addData(const EntityVoteCondidateResult &data)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << data;
    endInsertRows();
}

void ModelVoteCondidateResult::removeData()
{
    beginResetModel();
    m_data.clear();
    endResetModel();
}

int ModelVoteCondidateResult::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_data.count();
}

QVariant ModelVoteCondidateResult::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const EntityVoteCondidateResult &data = m_data[index.row()];

    if (role == myCandidateNameEn)
        return data.candidateNameEn();
    else if (role == myCandidateNameKu)
        return data.candidateNameKu();
    else if (role == myCandidateFamilyEn)
        return data.candidateFamilyEn();
    else if (role == myCandidateFamilyKu)
        return data.candidateFamilyKu();
    else if (role == myCandidateCode)
        return data.candidateCode();
    else if (role == myVoteCount)
        return data.voteCount();
    else if (role == myVotePercent)
        return data.votePercent();
    return QVariant();
}

QHash<int, QByteArray> ModelVoteCondidateResult::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[myCandidateNameEn]   = "candidateNameEn";
    roles[myCandidateNameKu]   = "candidateNameKu";
    roles[myCandidateFamilyEn] = "candidateFamilyEn";
    roles[myCandidateFamilyKu] = "candidateFamilyKu";
    roles[myCandidateCode]     = "candidateCode";
    roles[myVoteCount]         = "voteCount";
    roles[myVotePercent]       = "votePercent";

    return roles;
}

