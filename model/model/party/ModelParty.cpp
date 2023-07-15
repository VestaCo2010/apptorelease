#include "ModelParty.h"

ModelParty::ModelParty(QObject *parent) : QAbstractListModel{parent}
{

}

void ModelParty::addData(const EntityParty &data)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << data;
    endInsertRows();
}

void ModelParty::removeData()
{
    beginResetModel();
    m_data.clear();
    endResetModel();
}

int ModelParty::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_data.count();
}

QVariant ModelParty::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const EntityParty &data = m_data[index.row()];

    if (role == myPartyId)
        return data.partyId();
    else if (role == myPartyCode)
        return data.partyCode();
    else if (role == myPartyNameKu)
        return data.partyNameKu();
    else if (role == myPartyNameEn)
        return data.partyNameEn();
    else if (role == myPartyLogo)
        return data.partyLogo();

    return QVariant();
}

QHash<int, QByteArray> ModelParty::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[myPartyId]     = "partyId";
    roles[myPartyCode]   = "partyCode";
    roles[myPartyNameKu] = "partyNameKu";
    roles[myPartyNameEn] = "partyNameEn";
    roles[myPartyLogo]   = "partyLogo";

    return roles;
}
