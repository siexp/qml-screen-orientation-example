#include "AndroidInterface.h"

#include <QAndroidJniObject>
#include <QtAndroid>

AndroidInterface::AndroidInterface(QObject* parent) : QObject{ parent }
{
}

void AndroidInterface::portrait()
{
    setScreenOrientation(Orientations::SCREEN_ORIENTATION_PORTRAIT);
}

void AndroidInterface::landscape()
{
    setScreenOrientation(Orientations::SCREEN_ORIENTATION_SENSOR_LANDSCAPE);
}

void AndroidInterface::setScreenOrientation(Orientations orientation)
{
    QAndroidJniObject activity = QtAndroid::androidActivity();

    if(!activity.isValid())
    {
        return;
    }

    activity.callMethod<void>("setRequestedOrientation", "(I)V", orientation);
}