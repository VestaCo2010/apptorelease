#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QTranslator>
#include <QGuiApplication>

class Translate : public QObject
{
    Q_OBJECT

public:

    Translate(QQmlEngine *engine);

    Q_INVOKABLE void selectLanguage(QString language);

private:

    QTranslator *_translator;
    QQmlEngine *_engine;

}; // Translate


