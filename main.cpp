#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QtAndroid>
#include <QAndroidIntent>
#include <QQmlContext>

#include "location_service_controller.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    //qmlRegisterType<LocationService>("LocationService", 1, 0, "LocationService");



    QQmlApplicationEngine engine;
     QQmlContext* context = engine.rootContext();
     LocationService myLocation;
     context->setContextProperty("locationService",&myLocation);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    engine.load(url);


    return app.exec();
}
