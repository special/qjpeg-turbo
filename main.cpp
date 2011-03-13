#include <QImageIOPlugin>
#include <QtPlugin>
#include "qjpeghandler_p.h"

class QJpegTurboPlugin : public QImageIOPlugin
{
public:
    QStringList keys() const
    {
        /* The 'jpeg-turbo' format is supported to allow applications to explicitly use this plugin when
         * qjpeg is also loaded. */
        return QStringList() << QLatin1String("jpeg") << QLatin1String("jpg")
                             << QLatin1String("jpeg-turbo") << QLatin1String("jpeg-ycbcr");
    }

    Capabilities capabilities(QIODevice *device, const QByteArray &format) const
    {
        if (format == "jpeg" || format == "jpg" || format == "jpeg-turbo")
            return Capabilities(CanRead | CanWrite);
        else if (format == "jpeg-ycbcr")
            return Capabilities(CanRead);
        else if (!format.isEmpty())
            return 0;
        else if (!device->isOpen())
            return 0;

        Capabilities cap;
        if (device->isReadable() && QJpegHandler::canRead(device))
            cap |= CanRead;
        if (device->isWritable())
            cap |= CanWrite;
        return cap;
    }

    QImageIOHandler *create(QIODevice *device, const QByteArray &format) const
    {
        QImageIOHandler *handler = new QJpegHandler;
        handler->setDevice(device);
        handler->setFormat(format);
        return handler;
    }
};

Q_EXPORT_STATIC_PLUGIN(QJpegTurboPlugin)
Q_EXPORT_PLUGIN2(qjpeg-turbo, QJpegTurboPlugin)
