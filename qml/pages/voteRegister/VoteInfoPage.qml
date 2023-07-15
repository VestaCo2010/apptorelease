import QtQuick
import Felgo

////! [Style]
//import "../../helper/style"

////! [Component]
//import "../../helper/button"
//import "../../helper/header"
//import "../../helper/listview"

////! [C++ Class]
//import VOTE.PartyTbl
//import VOTE.ServiceVote
//import VOTE.ServiceUploadImage

AppPage {
//    useSafeArea: system.isPlatform(System.IOS)
//    navigationBarHidden: true
//    LayoutMirroring.enabled: Lang.isRTL
//    LayoutMirroring.childrenInherit: Lang.isRTL
//    onAppeared: {
//        txtPartyName.text = PartyTbl.getPartyNameFromDb(ptyPartyId, Lang.ptyLanguage == "en")
//        ptyImagePath = ""
//    }

//    property string  ptyPartyId             : ""
//    property string  ptyCandidateId         : ""
//    property string  ptyCandidateNameFamily : ""
//    property string  ptyImagePath           : ""

//    ServiceVote {
//        id: serviceVote
//        onSigSuccessValidateInfo: serviceUploadImage.uploadVoteImage(ptyImagePath)
//        onSigRejectValidateInfo: (message) => {
//                                     toastMessage.state = "Warning"
//                                     toastMessage.title = qsTr("Warning")
//                                     toastMessage.message = message
//                                     toastMessage.open()
//                                 }
//        onSigSuccessRegisterVote: (message) => {
//                                      toastMessage.state = "Success"
//                                      toastMessage.title = qsTr("Success")
//                                      toastMessage.message = message
//                                      toastMessage.open()
//                                      navigationStack.popAllExceptFirst()
//                                  }
//        onSigRejectRegisterVote: (message) => {
//                                     toastMessage.state = "Error"
//                                     toastMessage.title = qsTr("Error")
//                                     toastMessage.message = message
//                                     toastMessage.open()
//                                 }
//        onSigHidLoading: loading.close()
//    }

//    ServiceUploadImage {
//        id: serviceUploadImage
//        onSigSuccessUploadVoteImage: (imageId, imageUrl) => {
//                                         serviceVote.registerVote(imageId)
//                                     }
//        onSigRejectUploadVoteImage: (message) => {
//                                        toastMessage.state = "Error"
//                                        toastMessage.title = qsTr("Error")
//                                        toastMessage.message = message
//                                        toastMessage.open()
//                                    }
//        classErrorHandling: ErrorHandling
//        onSigHidLoading: loading.close()
//    }

//    Connections {
//        target: nativeUtils
//        // onCameraPickerFinished:
//        // onImagePickerFinished:
//        onCameraPickerFinished: (accepted, path) =>  {
//                                    if(accepted) {
//                                        ptyImagePath = path
//                                        voteImage.source = path
//                                    }
//                                }
//    }

//    //! [Back button icon]
//    BackIconHeader {
//        id: backIcon
//    }

//    TitleHeader {
//        id: txtTitle
//        text: qsTr("Info")
//        anchors { top: backIcon.bottom; topMargin: dp(12) }
//    }

//    Rectangle {
//        id: freamInfo
//        width: parent.width - dp(32)
//        height: (txtCandidateName.text !== "") ? dp(72) : dp(40)
//        color: Style.ptyColorGray10
//        border.color: Style.ptyColorGray30
//        radius: dp(8)

//        anchors {
//            top: txtTitle.bottom
//            topMargin: dp(12)
//            horizontalCenter: parent.horizontalCenter
//        }

//        AppText {
//            id: txtCandidateName
//            text: ptyCandidateNameFamily
//            width: parent.width
//            height: dp(20)
//            anchors { top: parent.top; topMargin: dp(10) }
//            leftPadding: dp(12)
//            rightPadding: dp(12)
//            horizontalAlignment: AppText.AlignLeft
//            font { family: Style.fontProductSansRegular; pixelSize: sp(16); weight: 400 }
//        }

//        AppText {
//            id: txtPartyName
//            width: parent.width
//            height: dp(20)
//            anchors { bottom: parent.bottom; bottomMargin: dp(10) }
//            leftPadding:  dp(12)
//            rightPadding: dp(12)
//            horizontalAlignment: AppText.AlignLeft
//            font { family: Style.fontProductSansRegular; pixelSize: sp(16); weight: 400 }
//        }
//    }

//    RoundedImage {
//        id: voteImage
//        width: parent.width - dp(32)
//        height: dp(230)
//        radius: dp(8)
//        fillMode: Image.PreserveAspectCrop
//        img.sourceSize.width: voteImage.width
//        anchors { top: freamInfo.bottom; topMargin: dp(60); horizontalCenter: parent.horizontalCenter }
//        source: "qrc:/assets/icon/no_image.svg"
//    }

//    CustomButton {
//        id: takePhotoButton
//        width: parent.width - dp(32)
//        text: ptyCandidateId ? (ptyImagePath ? qsTr("Save") : qsTr("Take a photo")) : qsTr("Save")
//        anchors { bottom: parent.bottom; bottomMargin: dp(24); horizontalCenter: parent.horizontalCenter }
//        onClicked: {
//            if(ptyCandidateId) {
//                if(ptyImagePath) {
//                    loading.open()
//                    serviceVote.validateInfo(ptyPartyId,ptyCandidateId,ptyImagePath)
//                }
//                else {
//                    nativeUtils.displayCameraPicker(qsTr("Vote image"))
//                    //  nativeUtils.displayImagePicker(qsTr("Vote image"))
//                }
//            }
//            else {
//                // a request for jst party
//                serviceVote.registerVoteParty(ptyPartyId)
//            }
//        }
//    }
}
