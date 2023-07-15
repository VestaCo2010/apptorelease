#include "SqliteHandler.h"

QSqlDatabase SqliteHandler::db;

SqliteHandler::SqliteHandler()
{
    qDebug() <<"PRINT PATH :: " << QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);

    if(!db.isValid())
    {
        db = QSqlDatabase::addDatabase("QSQLITE");
        db.setDatabaseName(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/" + "vote_database.db");
    }

    if (!db.isOpen() && !db.open())
    {
        qDebug() << "Error: connection with database failed"<< db.lastError();
    }
}

int SqliteHandler::insert(const QVariantMap &data)
{
    QString queryStr("INSERT INTO :table_name(:columns) VALUES(:values)");
    QStringList keys = data.keys();
    QStringList values;

    foreach(QVariant record, data.values())
    {
        QString temp;

        if(record.isNull())
            temp = "null";
        else if(record.userType() == QMetaType::QString)
            temp = QString("\'%1\'").arg(record.toString());
        else
            temp= record.toString();

        values.append(temp);
    }

    queryStr.replace(":table_name", this->getTableName());
    queryStr.replace(":columns", keys.join(","));
    queryStr.replace(":values", values.join(","));

    QSqlQuery sqlQuery(this->db);
    sqlQuery.prepare(queryStr);

    if(sqlQuery.exec() != true)
    {
        QSqlError error = sqlQuery.lastError();
        qDebug()<< sqlQuery.executedQuery() << error.text();
        return -1;
    }
    else
    {
        return sqlQuery.lastInsertId().toInt();
    }
}

QVariantMap SqliteHandler::update(const int &id, const QVariantMap &data)
{
    QSqlQuery sqlQuery(this->db);
    QString queryStr("UPDATE :table_name SET :data WHERE id = :id");
    queryStr.replace(":table_name",this->getTableName());

    QStringList setQuery;
    foreach(QString key, data.keys()){

        QString temp;

        if(data.value(key).isNull())
            temp = "null";
        else if(data.value(key).userType() == QMetaType::QString)
            temp = QString("\'%1\'").arg(data.value(key).toString());
        else
            temp= data.value(key).toString();

        setQuery.append(key+"="+temp);
    }
    queryStr.replace(":data",setQuery.join(","));

    sqlQuery.prepare(queryStr);
    sqlQuery.bindValue(":id",id);

    if(sqlQuery.exec() != true)
    {
        QSqlError error = sqlQuery.lastError();
        qDebug()<< sqlQuery.executedQuery() << error.text();
        return QVariantMap();
    }
    else {
        return this->getAllById(id);
    }
}

QVariantMap SqliteHandler::updateByRowId(const int &rowId, const QVariantMap &data)
{
    QVariantMap conditionData;
    conditionData[":rowId"] = rowId;

    return updateByCondition("rowid = :rowId",conditionData,data);
}

QVariantMap SqliteHandler::updateByCondition(const QString &condition, const QVariantMap &conditionData, const QVariantMap &updateData)
{
    QString queryStr("UPDATE :table_name SET :data WHERE :condition");
    queryStr.replace(":table_name",this->getTableName());
    queryStr.replace(":condition",condition);

    QStringList setQuery;
    foreach(QString key, updateData.keys())
    {
        QString temp;

        if(updateData.value(key).isNull())
            temp = "null";
        else if(updateData.value(key).userType() == QMetaType::QString)
            temp = QString("\'%1\'").arg(updateData.value(key).toString());
        else
            temp= updateData.value(key).toString();

        setQuery.append(key+"="+temp);
    }
    queryStr.replace(":data",setQuery.join(","));

    QSqlQuery sqlQuery(this->db);
    sqlQuery.prepare(queryStr);

    foreach(QString key, conditionData.keys())
    {
        sqlQuery.bindValue(key,conditionData.value(key));
    }

    if(sqlQuery.exec() != true)
    {
        QSqlError error = sqlQuery.lastError();
        qDebug()<< sqlQuery.executedQuery() << error.text();
        return QVariantMap();
    }
    else {
        QList<QVariantMap> tmp = this->getAllByCondition(condition,conditionData);
        if(tmp.empty() == true)
            return QVariantMap();
        else
            return tmp.first();
    }
}

void SqliteHandler::deleteAll()
{
    QString queryStr("DELETE FROM :table_name");
    queryStr.replace(":table_name", this->getTableName());

    QSqlQuery sqlQuery(this->db);
    sqlQuery.prepare(queryStr);

    if(sqlQuery.exec() != true)
    {
        QSqlError error = sqlQuery.lastError();
        qDebug()<< sqlQuery.executedQuery() << error.text();
    }
}

bool SqliteHandler::deleteByRowId(const int rowId)
{
    QVariantMap conditionData;
    conditionData[":rowId"] = rowId;
    return deleteRowsByCondition(QStringLiteral("rowid=:rowId"),conditionData);
}

bool SqliteHandler::deleteRows(const QString &ids)
{
    QVariantMap conditionData;
    conditionData[":id"] = ids;
    return deleteRowsByCondition(QStringLiteral("id IN (:id)"),conditionData);
}

bool SqliteHandler::deleteRowsByCondition(const QString &condition, const QVariantMap &conditionData)
{
    QString queryStr("DELETE FROM :table_name WHERE :condition");
    queryStr.replace(":table_name", this->getTableName());
    queryStr.replace(":condition",condition);

    QSqlQuery sqlQuery(this->db);

    sqlQuery.prepare(queryStr);
    foreach(QString key, conditionData.keys()){
        sqlQuery.bindValue(key,conditionData.value(key));
    }

    if(sqlQuery.exec() != true)
    {
        QSqlError error = sqlQuery.lastError();
        qDebug()<< sqlQuery.executedQuery() << error.text();
        return false;
    }
    else
        return true;
}

QList<QVariantMap> SqliteHandler::getAll()
{
    QSqlQuery sqlQuery(this->db);
    QString queryStr("SELECT rowid,* FROM :table_name");
    queryStr.replace(":table_name",this->getTableName());
    sqlQuery.prepare(queryStr);

    QList <QVariantMap> dataList;
    if(sqlQuery.exec() == true)
    {
        while (sqlQuery.next())
        {
            QSqlRecord record = sqlQuery.record();
            QVariantMap data;
            for(int i= 0; i< record.count();i++)
            {
                data[record.fieldName(i)] = record.value(i);
            }
            dataList.append(data);
        }
    }
    return dataList;
}

QVariantMap SqliteHandler::getAllById(const int &id)
{
    QVariantMap map;
    map[":id"] = id;
    QList list = this->getAllByCondition("id=:id",map);
    return list.first();
}

QVariantMap SqliteHandler::getAllByRowId(const int &rowId)
{
    QVariantMap map;
    map[":rowId"] = rowId;
    QList list = this->getAllByCondition("rowid=:rowId",map);
    return list.first();
}

QList<QVariantMap> SqliteHandler::getByQuery(const QString &query)
{
    QSqlQuery sqlQuery(this->db);

    sqlQuery.prepare(query);

    QList <QVariantMap> dataList;
    if(sqlQuery.exec() == true)
    {
        while (sqlQuery.next())
        {
            QSqlRecord record = sqlQuery.record();
            QVariantMap data;
            for(int i= 0; i< record.count();i++)
            {
                data[record.fieldName(i)] = record.value(i);
            }
            dataList.append(data);
        }
    }
    return dataList;
}

QList<QVariantMap> SqliteHandler::getAllByCondition(const QString &condition, const QVariantMap &data)
{
    QSqlQuery sqlQuery(this->db);
    QString queryStr("SELECT rowid,* FROM :table_name WHERE :condition");
    queryStr.replace(":table_name",this->getTableName());
    queryStr.replace(":condition",condition);

    sqlQuery.prepare(queryStr);
    foreach(QString key, data.keys()){
        sqlQuery.bindValue(key,data.value(key));
    }

    QList <QVariantMap> dataList;
    if(sqlQuery.exec() == true)
    {
        while (sqlQuery.next())
        {
            QSqlRecord record = sqlQuery.record();
            QVariantMap data;
            for(int i= 0; i< record.count();i++)
            {
                data[record.fieldName(i)] = record.value(i);
            }
            dataList.append(data);
        }
    }
    return dataList;
}

const QString &SqliteHandler::getTableName() const
{
    return tableName;
}

void SqliteHandler::setTableName(const QString &newTableName)
{
    tableName = newTableName;
}

void SqliteHandler::createTable()
{
    qFatal("You forgot to override createTable() function in your DbManagement class");
}
