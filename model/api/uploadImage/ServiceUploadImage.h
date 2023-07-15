#ifndef SERVICEUPLOADIMAGE_H
#define SERVICEUPLOADIMAGE_H

#include <QUrl>
#include <QFile>
#include <QImage>
#include <QBuffer>
#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>

#include "../../da/NetworkHandler.h"

class ServiceUploadImage : public NetworkHandler
{
    Q_OBJECT

public:

    ServiceUploadImage();

    enum class ImageType
    {
        Party = 1,
        Condidate = 2
    };
    Q_ENUM(ImageType)


    // Image convertor
    Q_INVOKABLE QString convertImagetoBase64(QString imagePath, int size);

    // API Service Methods
    Q_INVOKABLE void uploadUserImage(const QString imagePath);
    Q_INVOKABLE void uploadVoteImage(const QString imagePath, ImageType imageType);

signals:

    // Signals of Upload User Image
    void sigSuccessUploadUserImage(int imageId, QString imageUrl);
    void sigRejectUploadUserImage(QString message);

    // Signals of Upload Vote Image
    void sigSuccessUploadPartyVoteImage(int imageId, QString imageUrl);
    void sigSuccessUploadCondidateVoteImage(int imageId, QString imageUrl);
    void sigRejectUploadVoteImage(QString message);

public slots:

    // Slots of Upload User Image
    void getReceivedDataUploadUserImage(QJsonObject *result);
    void getReceivedMessageUploadUserImage(QJsonObject *result);

    // Slots of Upload Vote Image
    void getReceivedDataUploadVoteImage(QJsonObject *result);
    void getReceivedMessageUploadVoteImage(QJsonObject *result);
    // End
    void endOffServiceExecution(QString message = {});

private:

    ImageType m_imageType;
};

#endif // SERVICEUPLOADIMAGE_H
