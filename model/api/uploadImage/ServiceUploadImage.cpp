#include "ServiceUploadImage.h"

ServiceUploadImage::ServiceUploadImage()
{
    connect(this, SIGNAL(sigTimeOut(QString)), this, SLOT(endOffServiceExecution(QString)));
}

QString ServiceUploadImage::convertImagetoBase64(QString imagePath, int size)
{
    QString path(imagePath);
    QUrl url(path);
    path = url.toLocalFile();

    QFile imageFile(path);

    if(imageFile.exists())
        qDebug() <<" imageFile exists " ;

    QImage img(path);

#ifdef Q_OS_IOS
    int angle = 90; //how much you want to rotate in degree
    img = img.transformed(QTransform().rotate(angle));
    qDebug() << "platform is iphone";
#endif
    QImage img2 = img.scaled(size, size, Qt::KeepAspectRatio);
    QBuffer buffer;

    img2.save(&buffer, "PNG");

    // QByteArray image = img2.readAll();
    QString imgBase64 = QString::fromLatin1(buffer.data().toBase64());

    return imgBase64;
}

// [Upload User Image]
void ServiceUploadImage::uploadUserImage(const QString imagePath)
{
    QString imageData = convertImagetoBase64(imagePath, 100);

    QJsonObject qJsonObject;
    qJsonObject.insert("avatar", imageData);
    QJsonDocument qJsonDocument(qJsonObject);

    QUrl qUrl;
    qUrl.setPath("/uploadUserImage");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataUploadUserImage(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageUploadUserImage(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, false, "POST");
}

void ServiceUploadImage::getReceivedDataUploadUserImage(QJsonObject *result)
{
    endOffServiceExecution();

    emit sigSuccessUploadUserImage((*result)["result"].toObject()["data"].toObject()["imageId"].toInt(),
            (*result)["result"].toObject()["data"].toObject()["imageUrl"].toString());

    result = nullptr;
}

void ServiceUploadImage::getReceivedMessageUploadUserImage(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count()==0)
        emit sigRejectUploadUserImage((*result)["result"].toObject()["message"].toString());
    else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectUploadUserImage(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}


// [Upload Vote Image]
void ServiceUploadImage::uploadVoteImage(const QString imagePath, ImageType imageType)
{    
    m_imageType = imageType;

    QString imageData = convertImagetoBase64(imagePath, 1200);

    QJsonObject qJsonObject;
    qJsonObject.insert("avatar", imageData);
    QJsonDocument qJsonDocument(qJsonObject);

    QUrl qUrl;
    qUrl.setPath("/uploadVoteImage");

    connect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataUploadVoteImage(QJsonObject*)));
    connect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageUploadVoteImage(QJsonObject*)));
    sendRequest(qJsonDocument, qUrl, true, "POST");
}

void ServiceUploadImage::getReceivedDataUploadVoteImage(QJsonObject *result)
{
    endOffServiceExecution();

    if(m_imageType == ImageType::Party) {
        emit sigSuccessUploadPartyVoteImage((*result)["result"].toObject()["data"].toObject()["imageId"].toInt(),
                (*result)["result"].toObject()["data"].toObject()["imageUrl"].toString());
    }
    else if(m_imageType == ImageType::Condidate) {
        emit sigSuccessUploadCondidateVoteImage((*result)["result"].toObject()["data"].toObject()["imageId"].toInt(),
                (*result)["result"].toObject()["data"].toObject()["imageUrl"].toString());
    }

    result = nullptr;
}

void ServiceUploadImage::getReceivedMessageUploadVoteImage(QJsonObject *result)
{
    endOffServiceExecution();

    if((*result)["message"].toArray().count()==0)
        emit sigRejectUploadVoteImage((*result)["result"].toObject()["message"].toString());
    else {
        QString message = "";
        foreach (const QJsonValue& value, (*result)["message"].toArray()) {
            message += value.toString() + "\n" ;
        }
        emit sigRejectUploadVoteImage(message.left(message.lastIndexOf("\n")));
    }
    result = nullptr;
}


void ServiceUploadImage::endOffServiceExecution(QString message)
{
    Q_UNUSED(message);

    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataUploadUserImage(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageUploadUserImage(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedData(QJsonObject*)), this, SLOT(getReceivedDataUploadVoteImage(QJsonObject*)));
    disconnect(this, SIGNAL(sigGetReceivedMessage(QJsonObject*)), this, SLOT(getReceivedMessageUploadVoteImage(QJsonObject*)));
}
