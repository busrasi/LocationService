#include "location_service_controller.h"

LocationService::LocationService(QObject* parent)
    : QObject(parent)
{}

LocationService::~LocationService()
{}

void LocationService::gotoAndroidLocationSettings()
{
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
}

void LocationService::gotoAndroidSettings()
{
    const QAndroidJniObject ACTION_SETTINGS = QAndroidJniObject::getStaticObjectField("android/provider/Settings",
                                                                                      "ACTION_SETTINGS",
                                                                                      "Ljava/lang/String;");
    if (ACTION_SETTINGS.isValid()) {
        const QAndroidIntent intent(ACTION_SETTINGS.toString());
        QtAndroid::startActivity(intent.handle(), 10101);
    }

}

bool LocationService::active() const
{
    return m_active;
}

void LocationService::setActive(bool active)
{
    if (m_active == active)
        return;

    m_active = active;
    emit activeChanged(m_active);
}

