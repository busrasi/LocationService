#ifndef LOCATION_SERVICE_CONTROLLER_H
#define LOCATION_SERVICE_CONTROLLER_H

#include <QtAndroidExtras>
#include <QObject>


class LocationService :public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool active READ active WRITE setActive NOTIFY activeChanged)
    bool m_active;

public:
    LocationService(QObject* parent = nullptr);
    ~LocationService();
    Q_INVOKABLE void gotoAndroidLocationSettings();
    Q_INVOKABLE void gotoAndroidSettings();
    bool active() const;
public slots:
    void setActive(bool active);
signals:
    void activeChanged(bool active);

};

#endif // LOCATION_SERVICE_CONTROLLER_H

