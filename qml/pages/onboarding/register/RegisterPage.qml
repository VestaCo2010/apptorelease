import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Felgo

//! [Style]
import "../../../helper/style"

//! [Component]
import "../../../helper/button"
import "../../../helper/textInput"

//! [C++ Class]
import VOTE.ServiceUserManagement
import VOTE.ServiceUploadImage

AppPage {
    id: registerPage
    title: "Register"
    backgroundColor: Style.ptyTransparent
    LayoutMirroring.enabled: Lang.isRTL
    LayoutMirroring.childrenInherit: Lang.isRTL
    useSafeArea: true

    ServiceUserManagement {
        id: serviceUserManagement

        onSigSuccessVerifyFundNumber: {
            if(swipeView.currentIndex < 4)
                swipeView.incrementCurrentIndex()
            else if(item5.ptyImageSelected && swipeView.currentIndex == 4)
                serviceUploadImage.uploadUserImage(item5.ptyImageSelectedPath)
        }
        onSigRejectVerifyFundNumber: (message) => {
                                         toastMessage.state = "Warning"
                                         toastMessage.title = qsTr("Warning")
                                         toastMessage.message = message
                                         toastMessage.open()
                                     }
        onSigSuccessValidateInfo: () => {
                                      if(swipeView.currentIndex < 4)
                                      swipeView.incrementCurrentIndex()
                                      else if(item5.ptyImageSelected && swipeView.currentIndex == 4)
                                      serviceUploadImage.uploadUserImage(item5.ptyImageSelectedPath)
                                  }
        onSigRejectValidateInfo: (message) =>  {
                                     toastMessage.state = "Warning"
                                     toastMessage.title = qsTr("Warning")
                                     toastMessage.message = message
                                     toastMessage.open()
                                 }
        onSigSuccessRegisterUser: (message) => {
                                      toastMessage.state = "Success"
                                      toastMessage.title = qsTr("Success")
                                      toastMessage.message = message
                                      toastMessage.open()
                                      stackView.pop()
                                  }
        onSigRejectRegisterUser: (message) => {
                                     toastMessage.state = "Error"
                                     toastMessage.title = qsTr("Error")
                                     toastMessage.message = message
                                     toastMessage.open()
                                 }
        classErrorHandling: ErrorHandling
        onSigHidLoading: loading.close()
    }

    ServiceUploadImage {
        id: serviceUploadImage

        property int ptyImageId: -1
        onSigSuccessUploadUserImage: (imageId, imageUrl) => {
                                         ptyImageId = imageId
                                         serviceUserManagement.registerUser(imageId)
                                     }
        onSigRejectUploadUserImage: (message) => {
                                        toastMessage.text = message
                                        toastMessage.open()
                                    }
        classErrorHandling: ErrorHandling
        onSigHidLoading: loading.close()
    }

    AppText {
        id: txtTitle
        text: qsTr("Register")
        width: parent.width
        leftPadding: dp(16)
        rightPadding: dp(16)
        topPadding: dp(40)
        horizontalAlignment: AppText.AlignLeft
        font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(32); weight: 700 }
    }

    SwipeView {
        id: swipeView
        width: parent.width
        interactive: false
        anchors { top: txtTitle.bottom; bottom: buttonBack.top }

        Item1 {
            id: item1
        }

        Item2 {
            id: item2
        }

        Item3 {
            id: item3
        }

        Item4 {
            id: item4
        }

        Item5 {
            id: item5
        }
    }

    CustomButton {
        id: buttonBack
        width: parent.width / 2 - dp(24)
        text: qsTr("Back")
        anchors { bottom: parent.bottom; bottomMargin: dp(40); left: parent.left; leftMargin: dp(16) }
        backgroundColor: Style.ptyTransparent
        textColor: Style.ptyColorOrangeDark
        borderColor: Style.ptyColorOrangeDark
        radius: dp(8)
        onClicked: {
            if(swipeView.currentIndex === 0)
                stackView.pop()
            else
                swipeView.decrementCurrentIndex()
        }
    }

    CustomButton {
        id: buttonNext
        width: parent.width / 2 - dp(24)
        text: (item5.ptyImageSelected && swipeView.currentIndex == 4) ? qsTr("Register") : qsTr("Next")
        radius: dp(8)
        anchors { bottom: parent.bottom; bottomMargin: dp(40); right: parent.right; rightMargin: dp(16) }
        onClicked: {
            Qt.inputMethod.hide()
            if(swipeView.currentIndex === 0)
                item1.validatePersonalityInfo()
            else if (swipeView.currentIndex === 1)
                item2.validateLocationInfo()
            else if (swipeView.currentIndex === 2)
                item3.validateAccountInfo()
            else if (swipeView.currentIndex === 3)
                item4.validatePasswordInfo()
            else if (swipeView.currentIndex === 4 ) {
                if(item5.ptyImageSelected) {
                    if(serviceUploadImage.ptyImageId === -1){
                        loading.open()
                        item5.validateImage()
                    }
                    else {
                        loading.open()
                        serviceUserManagement.registerUser(serviceUploadImage.ptyImageId)
                    }
                }
                else {
                    nativeUtils.displayAlertSheet(qsTr("Select"), [qsTr("Camera"), qsTr("Gallery")], true)
                }
            }
        }
    }
}
