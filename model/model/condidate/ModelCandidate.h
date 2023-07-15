#pragma once

#include <QObject>
#include <QAbstractListModel>

#include "../../entity/condidate/EntityCandidate.h"

class ModelCandidate : public QAbstractListModel
{
    Q_OBJECT

public:

    enum itemRoles {
        myPartyId,
        myPartyCode,
        myCandidateId,
        myCandidateCode,
        myCandidateNameKu,
        myCandidateNameEn,
        myCandidateFamilyKu,
        myCandidateFamilyEn
    };

    ModelCandidate(QObject *parent = nullptr);
    void addData(const EntityCandidate &data);
    void removeData();
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:

    QHash<int, QByteArray> roleNames() const;

private:

    QList<EntityCandidate> m_data;

};

