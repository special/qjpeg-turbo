TARGET = qjpeg-turbo
TEMPLATE = lib
CONFIG += plugin
QT += core gui

target.path = $$[QT_INSTALL_PLUGINS]/imageformats
INSTALLS += target

CONFIG(auto_install_plugin):DESTDIR = $$[QT_INSTALL_PLUGINS]/imageformats

# libjpeg-turbo; use the LIBJPEGTURBO_PATH variable if available, or default to trying
# libjpeg-turbo{,-arch}
isEmpty($$LIBJPEGTURBO_PATH) {
    LIBJPEGTURBO_PATH = $${_PRO_FILE_PWD_}/libjpeg-turbo

    !exists($$LIBJPEGTURBO_PATH) {
        # Detect architecture where not available
        win32-msvc* {
            COMPILERVERSION = $$system(ml64.exe 2> nul)
            !isEmpty(COMPILERVERSION) { CONFIG += x86_64 }
            else { CONFIG += x86 }
        }

        CONFIG(x86) { LIBJPEGTURBO_PATH = "$${LIBJPEGTURBO_PATH}-x86" }
        else:CONFIG(x86_64) { LIBJPEGTURBO_PATH = "$${LIBJPEGTURBO_PATH}-x86_64" }

        !exists($$LIBJPEGTURBO_PATH):error("No libjpeg-turbo build found. Build in " \
                                           "./libjpeg-turbo/ or set LIBJPEGTURBO_PATH")
    }
}

INCLUDEPATH += $$LIBJPEGTURBO_PATH

win32 {
    LIBS += $${LIBJPEGTURBO_PATH}/build/turbojpeg-static.lib
    INCLUDEPATH += $${LIBJPEGTURBO_PATH}/build/
} else {
    LIBS += $${LIBJPEGTURBO_PATH}/.libs/libturbojpeg.a
}

SOURCES += \
    main.cpp \
    qjpeghandler.cpp

HEADERS += qjpeghandler_p.h
