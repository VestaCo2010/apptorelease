#include "Translate.h"

Translate::Translate(QQmlEngine *engine)
{
    _translator = new QTranslator(this);
    _engine = engine;
}

void Translate::selectLanguage(QString language)
{
    if (language == "ku") {
        if (_translator->load(":/translation/kurdish.qm")){
            qApp->installTranslator(_translator);
        }
    }
    if (language == "en") {
        qApp->removeTranslator(_translator);
    }

    _engine->retranslate();
}
