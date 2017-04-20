#include <QApplication>
#include <QQmlApplicationEngine>
#include <QVariant>
#include "datamethods.h"
#include "dataobject.h"
#include <qqmlcontext.h>
#include <QDebug>
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    DataMethods methodsStopWatch("stopwatchResults.txt");
    DataMethods methodsCountDown("countdownResults.txt");
    //load stored results from .txt files to listViews of stopWatch and countDown sections
    methodsStopWatch.loadData();
    methodsCountDown.loadData();

    QQmlContext *ctxt = engine.rootContext();
    //give access to saved models in .txt to stopWatch and countDown sections in QML ( used upon new sesion of program)
    ctxt->setContextProperty("myStopWatchModel",QVariant::fromValue(&methodsStopWatch));
    ctxt->setContextProperty("myCountDownModel",QVariant::fromValue(&methodsCountDown));

    //give option to manipulate ( add results and save/clear) .txt file with methods inside DataMethods
    ctxt->setContextProperty("saveStopWatchModel",QVariant::fromValue(&methodsStopWatch));
    ctxt->setContextProperty("saveCountDownModel",QVariant::fromValue(&methodsCountDown));

    engine.load(QUrl(QStringLiteral("qrc:/mainSW.qml")));
    return app.exec();
}
