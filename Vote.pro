# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
QT += svg sql
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.iraq.vote # com.iraq.vote
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 2

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
#PRODUCT_LICENSE_KEY = ""
PRODUCT_LICENSE_KEY = "9AF66458AC6D5E81A3C4C78727E779290B3B5274CBE2BBBB7BD6C0EAEF044FB841A159EFDD3E1F021F79D3396ABC18F62AA859168A91C001106D2C542A56ECDFDAB512FDEBC6614D64AD2E875CE324383B4DB70481CAC4D7CBB4DE20D68E58E10EFA05B799AE7F290E5FB8DFA9E284628407D37F98F74BA2AB71B99C3C704C44AE8E0198DEAA3D2560AF19D71AE9D9F99F742FD1A8B7063A0E690B88AEC3039B631AC3BAE54BDF5B0CDEDF3812B8106727FDA7E9824881AAC10EE435B049DB6FF4A3A3E5A8251F7E0C9AD992F666B508528FFE7BFEF62460713DE31040A7C674A71B12AF3F3E7EADED794C6F4E670E6D5AF73B8D147A35ED95A18CF10C58B7844DB5E8E5EBB19B14733CE86F562C8DBE6A0F6677B413CE6629B1EEB89ADEF5A1DD846AD61ED1D792BB84FFAD04528067"

# qmlFolder.source = qml
# DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here
RESOURCES += qrcQml.qrc \ # uncomment for publishing
             qrcFonts.qrc \
             qrcImage.qrc \
             qrcTranslate.qrc

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    model/api/condidate/ServiceCandidate.cpp \
    model/api/fund/ServiceFund.cpp \
    model/api/party/ServiceParty.cpp \
    model/api/signIn/ServiceSignIn.cpp \
    model/api/uploadImage/ServiceUploadImage.cpp \
    model/api/userManagement/ServiceUserManagement.cpp \
    model/api/vote/ServiceCheckVotingRegister.cpp \
    model/api/vote/ServiceVoteRegister.cpp \
    model/api/voteResult/ServiceVoteResult.cpp \
    model/da/NetworkHandler.cpp \
    model/da/SqliteHandler.cpp \
    model/db/CandidateTbl.cpp \
    model/db/DataExist.cpp \
    model/db/PartyTbl.cpp \
    model/entity/condidate/EntityCandidate.cpp \
    model/entity/party/EntityParty.cpp \
    model/entity/voteResult/EntityVoteCondidateResult.cpp \
    model/entity/voteResult/EntityVotePartyResult.cpp \
    model/model/condidate/ModelCandidate.cpp \
    model/model/party/ModelParty.cpp \
    model/model/voteResult/ModelVoteCondidateResult.cpp \
    model/model/voteResult/ModelVotePartyResult.cpp \
    qmlRegister/QMLRegister.cpp \
    util/error/ClassErrorHandling.cpp \
    util/log/ClassLog.cpp \
    util/public/OpenDirectory.cpp \
    util/storage/authentication/Token.cpp \
    util/storage/language/Language.cpp \
    util/translation/Translate.cpp


android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

win32 {
    RC_FILE += win/app_icon.rc
}

macx {
    ICON = macx/app_icon.icns
}

HEADERS += \
    model/api/condidate/ServiceCandidate.h \
    model/api/fund/ServiceFund.h \
    model/api/party/ServiceParty.h \
    model/api/signIn/ServiceSignIn.h \
    model/api/uploadImage/ServiceUploadImage.h \
    model/api/userManagement/ServiceUserManagement.h \
    model/api/vote/ServiceCheckVotingRegister.h \
    model/api/vote/ServiceVoteRegister.h \
    model/api/voteResult/ServiceVoteResult.h \
    model/da/NetworkHandler.h \
    model/da/SqliteHandler.h \
    model/db/CandidateTbl.h \
    model/db/DataExist.h \
    model/db/PartyTbl.h \
    model/entity/condidate/EntityCandidate.h \
    model/entity/party/EntityParty.h \
    model/entity/voteResult/EntityVoteCondidateResult.h \
    model/entity/voteResult/EntityVotePartyResult.h \
    model/model/condidate/ModelCandidate.h \
    model/model/party/ModelParty.h \
    model/model/voteResult/ModelVoteCondidateResult.h \
    model/model/voteResult/ModelVotePartyResult.h \
    qmlRegister/QMLRegister.h \
    util/error/ClassErrorHandling.h \
    util/log/ClassLog.h \
    util/public/OpenDirectory.h \
    util/storage/authentication/Token.h \
    util/storage/language/Language.h \
    util/translation/Translate.h

#android: include(/Users/imasoud/Library/Android/sdk/android_openssl/openssl.pri)
#android: include(/Users/masoudbahrololoum/Library/Android/sdk/android_openssl/openssl.pri)
