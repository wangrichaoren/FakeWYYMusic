#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include "FileScanner.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon("../fake_wangyiyun_ui/wyyyy.svg"));
    qmlRegisterType<FileScanner>("FileScanner",1,0,"FileScanner");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/fake_wangyiyun_ui/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
