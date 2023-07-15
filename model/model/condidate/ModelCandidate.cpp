#include "ModelCandidate.h"

ModelCandidate::ModelCandidate(QObject *parent) : QAbstractListModel{parent}
{

}

void ModelCandidate::addData(const EntityCandidate &data)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << data;
    endInsertRows();
}

void ModelCandidate::removeData()
{
    beginResetModel();
    m_data.clear();
    endResetModel();
}

int ModelCandidate::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_data.count();
}

QVariant ModelCandidate::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const EntityCandidate &data = m_data[index.row()];

    if (role == myPartyId)
        return data.partyId();
    else if (role == myPartyCode)
        return data.partyCode();
    else if (role == myCandidateId)
        return data.candidateId();
    else if (role == myCandidateCode)
        return data.candidateCode();
    else if (role == myCandidateNameKu)
        return data.candidateNameKu();
    else if (role == myCandidateNameEn)
        return data.candidateNameEn();
    else if (role == myCandidateFamilyKu)
        return data.candidateFamilyKu();
    else if (role == myCandidateFamilyEn)
        return data.candidateFamilyEn();

    return QVariant();
}

QHash<int, QByteArray> ModelCandidate::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[myPartyId]           = "partyId";
    roles[myPartyCode]         = "partyCode";
    roles[myCandidateId]       = "candidateId";
    roles[myCandidateCode]     = "candidateCode";
    roles[myCandidateNameKu]   = "candidateNameKu";
    roles[myCandidateNameEn]   = "candidateNameEn";
    roles[myCandidateFamilyKu] = "candidateFamilyKu";
    roles[myCandidateFamilyEn] = "candidateFamilyEn";

    return roles;
}
