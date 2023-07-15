import QtQuick
import QtQuick.Layouts
import Felgo

//! [Style]
import "../../../helper/style"

//! [Component]
import "../../../helper/button"
import "../../../helper/textInput"
import "../../../helper"

//! [C++ Class]
import VOTE.ServiceSignIn

AppPage {
    id: loginAppPage
    title: "Login"
    backgroundColor: Style.ptyTransparent
    LayoutMirroring.enabled: Lang.isRTL
    LayoutMirroring.childrenInherit: Lang.isRTL
    useSafeArea: true

    signal sigSignIn

    function funLogin() {
        Qt.inputMethod.hide()
        loading.open()
        serviceSignIn.signIn(txtUsername.text, txtPassword.text)
    }

    ServiceSignIn {
        id: serviceSignIn

        onSigSuccess: (userType) => {
                          app.userType = userType
                          sigSignIn()
                      }
        onSigReject: (message) => {
                         toastMessage.state = "Error"
                         toastMessage.title = qsTr("Error")
                         toastMessage.message = message.length < 1 ? "INTERNAL SERVER ERROR" : message
                         toastMessage.open()
                     }
        classErrorHandling: ErrorHandling
        onSigHidLoading: loading.close()
    }

    AppText {
        id: txtTitle
        text: qsTr("Login")
        width: parent.width
        leftPadding: dp(16)
        rightPadding: dp(16)
        topPadding: dp(40)
        horizontalAlignment: AppText.AlignLeft
        font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(32); weight: 700 }
    }

    CustomInputText {
        id: txtUsername
        width: parent.width - dp(32)
        anchors { top: txtTitle.bottom; topMargin: dp(32); horizontalCenter: parent.horizontalCenter }
        showClearButton: true
        placeholderText: qsTr("Username")
        Keys.onEnterPressed: txtPassword.forceActiveFocus()
        Keys.onReturnPressed: txtPassword.forceActiveFocus()
        text: ""
    }

    CustomInputText {
        id: txtPassword
        width: parent.width - dp(32)
        anchors { top: txtUsername.bottom; topMargin: dp(20); horizontalCenter: parent.horizontalCenter }
        placeholderText: qsTr("Password")
        inputMode: inputModePassword
        Keys.onEnterPressed: funLogin()
        Keys.onReturnPressed: funLogin()
        text: ""
    }

    CustomButton {
        id: buttonLogin
        width: parent.width - dp(32)
        anchors { bottom: parent.bottom; bottomMargin: dp(40); horizontalCenter: parent.horizontalCenter }
        text: qsTr("Login")
        onClicked: {
            loading.open()
            serviceSignIn.signIn(txtUsername.text, txtPassword.text)
        }
    }
}
