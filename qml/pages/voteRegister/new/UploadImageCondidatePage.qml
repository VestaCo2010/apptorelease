import QtQuick
import Felgo

//! [Style]
import "../../../helper/style"

Item {

    anchors.fill: parent

    property alias alyVoteImagePath: voteImage.source

    Connections {
        target: nativeUtils
        onImagePickerFinished: (accepted, path) =>  {
                                   if(accepted && voteRegisterPage.uploadImageType === VoteRegister.MyEnum.Condidate) {
                                       voteImage.source = path
                                   }
                               }
        onCameraPickerFinished: (accepted, path) =>  {
                                    if(accepted && voteRegisterPage.uploadImageType === VoteRegister.MyEnum.Condidate) {
                                        voteImage.source = path
                                    }
                                }
    }

    AppText {
        id: txtTitle
        text: qsTr("Please upload the image of the Candidate’s vote.")
        width: parent.width
        horizontalAlignment: AppText.AlignLeft
        anchors { left: parent.left }
        font { family: Style.fontProductSansRegular; pixelSize: sp(16) }
        color: Style.ptyColorBlack
        leftPadding: dp(16)
    }

    RoundedImage {
        id: voteImage
        width: parent.width
        height: dp(328)
        radius: dp(8)
        img.autoTransform: true
        fillMode: Image.PreserveAspectCrop
        img.sourceSize: Qt.size(voteImage.width, voteImage.height)
        source: ""
        anchors {
            top: txtTitle.bottom
            topMargin: dp(16)
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        Image {
            id: name
            source: "qrc:/assets/icon/open_gallery.svg"
            visible: voteImage.source == ""
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(100, 100)
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(system.platform !== System.Mac)
                    nativeUtils.displayCameraPicker(qsTr("Vote image"))
                else
                    nativeUtils.displayImagePicker(qsTr("Vote image"))
            }
        }
    }
}
