#ifndef MODELVOTEPARTYRESULT_H
#define MODELVOTEPARTYRESULT_H

#include <QObject>
#include <QAbstractListModel>
#include "../../entity/voteResult/EntityVotePartyResult.h"

class ModelVotePartyResult : public QAbstractListModel
{
    Q_OBJECT

public:

    enum itemRoles {
        myPartyId,
        myPartyNameEn,
        myPartyNameKu,
        myPartyCode,
        myPartyLogo,
        myVoteCount,
        myVotePercent,
    };

public:

    ModelVotePartyResult(QObject *parent = nullptr);
    void addData(const EntityVotePartyResult &data);
    void removeData();
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:

    QHash<int, QByteArray> roleNames() const;

private:

    QList<EntityVotePartyResult> m_data;

};

#endif // MODELVOTEPARTYRESULT_H
