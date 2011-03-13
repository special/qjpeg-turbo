QT       += core gui

TARGET = qjpeg-turbo
TEMPLATE = lib
CONFIG += plugin

DESTDIR = $$[QT_INSTALL_PLUGINS]/imageformats

win32:LIBS += $${_PRO_FILE_PWD_}/libjpeg-turbo/build/turbojpeg-static.lib
INCLUDEPATH += $${_PRO_FILE_PWD_}/libjpeg-turbo/ $${_PRO_FILE_PWD_}/libjpeg-turbo/build/

win32-msvc2008|win32-msvc2010 {
    QMAKE_CXXFLAGS_RELEASE += -Zi
    QMAKE_LFLAGS_RELEASE += /DEBUG /OPT:REF,ICF
}

SOURCES += \
    main.cpp \
    qjpeghandler.cpp

HEADERS += qjpeghandler_p.h

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/local/lib
    }
    INSTALLS += target
}
