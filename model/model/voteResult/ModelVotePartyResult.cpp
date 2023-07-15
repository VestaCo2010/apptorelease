#include "ModelVotePartyResult.h"

ModelVotePartyResult::ModelVotePartyResult(QObject *parent) : QAbstractListModel{parent}
{

}
void ModelVotePartyResult::addData(const EntityVotePartyResult &data)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << data;
    endInsertRows();
}

void ModelVotePartyResult::removeData()
{
    beginResetModel();
    m_data.clear();
    endResetModel();
}

int ModelVotePartyResult::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_data.count();
}

QVariant ModelVotePartyResult::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const EntityVotePartyResult &data = m_data[index.row()];

    if (role == myPartyId)
        return data.partyId();
    else if (role == myPartyNameEn)
        return data.partyNameEn();
    else if (role == myPartyNameKu)
        return data.partyNameKu();
    else if (role == myPartyCode)
        return data.partyCode();
    else if (role == myPartyLogo)
        return data.partyLogo();
    else if (role == myVoteCount)
        return data.voteCount();
    else if (role == myVotePercent)
        return data.votePercent();
    return QVariant();
}

QHash<int, QByteArray> ModelVotePartyResult::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[myPartyId]      = "partyId";
    roles[myPartyNameEn]  = "partyNameEn";
    roles[myPartyNameKu]  = "partyNameKu";
    roles[myPartyCode]    = "partyCode";
    roles[myPartyLogo]    = "partyLogo";
    roles[myVoteCount]    = "voteCount";
    roles[myVotePercent]  = "votePercent";

    return roles;
}

