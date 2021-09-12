#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QQmlComponent>
#include <QString>

#include "fileio.h"
#include "profile.h"
#include <iostream>

int run(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<FileIO>("fileio",1,0,"FileIO");
    qmlRegisterType<Profile>("profile",1,0,"Profile");
    if(FileIO::checkPasscodeFile("profile.txt"))
        engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    else
        engine.load(QUrl(QStringLiteral("qrc:/ProfilePage.qml")));

    return app.exec();
}

int main(int argc, char *argv[])
{
    run(argc,argv);
    return 0;
}
