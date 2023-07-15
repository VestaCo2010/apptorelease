#ifndef MODELVOTECONDIDATERESULT_H
#define MODELVOTECONDIDATERESULT_H

#include <QObject>
#include <QAbstractListModel>
#include "../../entity/voteResult/EntityVoteCondidateResult.h"

class ModelVoteCondidateResult : public QAbstractListModel
{
    Q_OBJECT

public:

    enum itemRoles {
        myCandidateNameEn,
        myCandidateNameKu,
        myCandidateFamilyEn,
        myCandidateFamilyKu,
        myCandidateCode,
        myVoteCount,
        myVotePercent
    };

public:

    ModelVoteCondidateResult(QObject *parent = nullptr);
    void addData(const EntityVoteCondidateResult &data);
    void removeData();
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:

    QHash<int, QByteArray> roleNames() const;

private:

    QList<EntityVoteCondidateResult> m_data;

};

#endif // MODELVOTECONDIDATERESULT_H
