#pragma once

#include <QObject>

class AndroidInterface : public QObject
{
    Q_OBJECT
public:
    enum class Orientations
    {
        // https://developer.android.com/reference/android/content/pm/ActivityInfo#SCREEN_ORIENTATION_PORTRAIT
        SCREEN_ORIENTATION_PORTRAIT = 0x00000001,
        // https://developer.android.com/reference/android/content/pm/ActivityInfo#SCREEN_ORIENTATION_SENSOR_LANDSCAPE
        SCREEN_ORIENTATION_SENSOR_LANDSCAPE = 0x00000006,
        // https://developer.android.com/reference/android/content/pm/ActivityInfo#SCREEN_ORIENTATION_UNSPECIFIED
        SCREEN_ORIENTATION_UNSPECIFIED = 0xf
    };

public:
    explicit AndroidInterface(QObject* parent = nullptr);

    Q_INVOKABLE void portrait();
    Q_INVOKABLE void landscape();

private:
    void setScreenOrientation(Orientations orientation);
};
