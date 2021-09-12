TEMPLATE = app

QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp \
    fileio.cpp \
    profile.cpp \
    crypto.cpp

RESOURCES += qml.qrc

RC_FILE = icon.rc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES +=

HEADERS += \
    fileio.h \
    profile.h \
    crypto.h \
    random.h

INCLUDEPATH += D:/softwares/cryptlibpp/inc

LIBS += -LD:/softwares/cryptlibpp/lib/x64 -lcryptlibpp
