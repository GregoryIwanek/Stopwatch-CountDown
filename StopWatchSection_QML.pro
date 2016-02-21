TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    dataobject.cpp \
    datamethods.cpp \
    appsettings.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    AppxManifest.xml

HEADERS += \
    dataobject.h \
    datamethods.h \
    appsettings.h

