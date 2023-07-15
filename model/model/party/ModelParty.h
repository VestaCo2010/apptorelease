#pragma once

#include <QObject>
#include <QAbstractListModel>

#include "../../entity/party/EntityParty.h"

class ModelParty : public QAbstractListModel
{
    Q_OBJECT

public:

    enum itemRoles {
        myPartyId,
        myPartyCode,
        myPartyNameKu,
        myPartyNameEn,
        myPartyLogo
    };

    ModelParty(QObject *parent = nullptr);
    void addData(const EntityParty &data);
    void removeData();
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:

    QHash<int, QByteArray> roleNames() const;

private:

    QList<EntityParty> m_data;

};

