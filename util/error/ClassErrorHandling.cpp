#include "ClassErrorHandling.h"

using namespace VOTE::Util;

void ClassErrorHandling::showError(QString err)
{
    emit sigShowError(err);
}

void ClassErrorHandling::showLoginPage()
{
    emit sigShowLoginPage();
}
