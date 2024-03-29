#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QScreen>

#include <AndroidInterface.h>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    qmlRegisterSingletonType<AndroidInterface>("com.github.siexp", 1, 0, "AndroidInterface",
      [](QQmlEngine*, QJSEngine*) -> QObject*
      {
        auto singleton = new AndroidInterface();
        return singleton;
      }
    );

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
