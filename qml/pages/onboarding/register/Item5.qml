import QtQuick
import Felgo

//! [Style]
import "../../../helper/style"

//! [Component]
import "../../../helper/textInput"

Item {
    id: item5

    property bool   ptyImageSelected    : false
    property string ptyImageSelectedPath: ""

    function validateImage() {
        serviceUserManagement.validateImageInfo(ptyImageSelected ? userImage.source : "")
    }

    // Load Image (Gallery)
    Connections {
        target: nativeUtils
        onImagePickerFinished: (accepted, path) => {
                                   if(accepted) {
                                       serviceUploadImage.ptyImageId = -1
                                       ptyImageSelected = true
                                       ptyImageSelectedPath = path
                                       userImage.source = path
                                   }
                               }

        onCameraPickerFinished: (accepted, path) => {
                                    if(accepted) {
                                        serviceUploadImage.ptyImageId = -1
                                        ptyImageSelected = true
                                        ptyImageSelectedPath = path
                                        userImage.source = path
                                    }
                                }

        onAlertSheetFinished: (index) => {
                                  if(index === 0)
                                  nativeUtils.displayCameraPicker(qsTr("Profile image"))
                                  else
                                  nativeUtils.displayImagePicker(qsTr("Profile image"))
                              }
    }

    //! [Image open gallery]
    RoundedImage {
        id: userImage
        anchors.centerIn: parent
        width: dp(114)
        height: dp(114)
        radius: dp(60)
        img.autoTransform: true
        backgroundColor: Style.ptyTransparent
        border { width: dp(1); color: Style.ptyColorOrangeDark }
        source: "qrc:/assets/icon/gallery/gallery.svg"
        fillMode: Image.PreserveAspectCrop
        LayoutMirroring.enabled: Lang.isRTL
        img.sourceSize: Qt.size(114,114)

        MouseArea {
            anchors.fill: parent
            z: 90
            onClicked: nativeUtils.displayAlertSheet(qsTr("Select"), [qsTr("Camera"), qsTr("Gallery")], true)
        }
    }

    Rectangle {
        width: dp(30)
        height: dp(30)
        radius: dp(15)
        border.width: dp(2)
        visible: !ptyImageSelected
        border.color: Style.ptyColorWhite
        color: Style.ptyColorOrangeDark
        anchors { bottom: userImage.bottom; right: userImage.right; margins: dp(3) }

        AppIcon {
            iconType: IconType.plus
            color: Style.ptyColorWhite
            anchors.centerIn: parent
            size: dp(16)
        }
    }
}
