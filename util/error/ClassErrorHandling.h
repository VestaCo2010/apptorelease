#pragma once

#include <QObject>

namespace VOTE::Util
{

class ClassErrorHandling : public QObject
{
    Q_OBJECT

public:

    ClassErrorHandling() = default;
    void showError(QString err);
    void showLoginPage();

signals:

    void sigShowError(QString err);
    void sigShowLoginPage();

}; // ClassErrorHandling

} // VOTE::Util

