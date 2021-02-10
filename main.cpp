#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QtAndroid>
#include <QAndroidIntent>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    if ( activity.isValid() )
    {
         QAndroidJniObject param = QAndroidJniObject::fromString("android.settings.LOCATION_SOURCE_SETTINGS");

         if (param.isValid() )
         {
               QAndroidJniObject intent("android/content/Intent","(Ljava/lang/String;)V", param.object<jstring>());
               activity.callMethod<void>("startActivity","(Landroid/content/Intent;)V", intent.object<jobject>());
         }
     }


    return app.exec();
}
