#pragma once

#include <QDir>
#include <QDebug>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QSqlDatabase>
#include <QStandardPaths>

class SqliteHandler
{

private:

    QString tableName;

public:

    SqliteHandler();

    static QSqlDatabase db;

    int insert(const QVariantMap &data);
    QVariantMap update(const int &id, const QVariantMap &data);
    QVariantMap updateByRowId(const int &rowId, const QVariantMap &data);
    QVariantMap updateByCondition(const QString &condition, const QVariantMap &conditionData, const QVariantMap &updateData);

    void deleteAll();
    bool deleteByRowId(const int rowId);
    bool deleteRows(const QString &ids);
    bool deleteRowsByCondition(const QString &condition, const QVariantMap &conditionData);

    QVariantMap getAllById(const int &id);
    QVariantMap getAllByRowId(const int &rowId);
    QList<QVariantMap> getAll();
    QList<QVariantMap> getByQuery(const QString &query);
    QList<QVariantMap> getAllByCondition(const QString &condition,const QVariantMap &data);

    const QString &getTableName() const;
    void setTableName(const QString &newTableName);

    virtual void createTable();

};
