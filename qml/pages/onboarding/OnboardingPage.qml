import QtQuick
import QtQuick.Controls
import Felgo

//! [Style]
import "../../helper/style"

//! [Component]
import "../../helper/button"
import "../../helper/modal"

//! [AppPage]
import "../onboarding/signIn"
import "../onboarding/register"

AppPage {
    id: defualtAppPage
    anchors.fill: parent
    backgroundColor: Style.ptyColorWhite
    useSafeArea: true

    signal sigSignInHome()

    //! [Back button icon]
    IconColor {
        visible: stackView.depth !== 1
        anchors { top: parent.top; topMargin: NativeUtils.safeAreaInsets.top + dp(16); left: parent.left; leftMargin: dp(16) }
        source: "qrc:/assets/icon/arrow_left.svg"
        onSigClicked: stackView.pop()
    }

    //! [Language button icon]
    IconColor {
        visible: stackView.depth == 1
        anchors { top: parent.top; topMargin: NativeUtils.safeAreaInsets.top + dp(16); right: parent.right; rightMargin: dp(16) }
        source: "qrc:/assets/icon/language.svg"
        onSigClicked: changeLanguageModal.open()
    }

    //! [Logo image]
    Image {
        anchors { top: parent.top; topMargin: dp(50); horizontalCenter: parent.horizontalCenter }
        sourceSize: Qt.size(164, 279)
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/logo/logo_with_title.svg"
    }

    //! [StackView for change onboarding AppPage]
    StackView {
        id: stackView
        width: parent.width
        height: dp(358)
        anchors { bottom: parent.bottom }
        initialItem: Item {

            Image {
                width: parent.width
                anchors { bottom: recFooter.top }
                sourceSize.width: width
                fillMode: Image.PreserveAspectFit
                source: "qrc:/assets/background/box.svg"
            }

            Rectangle {
                id: recFooter
                width: parent.width
                height: dp(184)
                anchors { bottom: parent.bottom }
                color: Style.ptyColorGray40

                CustomButton {
                    id: buttonLogin
                    width: parent.width - dp(32)
                    text: qsTr("Login")
                    anchors { bottom: buttonRegister.top; bottomMargin: dp(16); horizontalCenter: parent.horizontalCenter }
                    onClicked: stackView.push(comSignInPage)
                }

                CustomButton {
                    id: buttonRegister
                    width: parent.width - dp(32)
                    text: qsTr("Register")
                    anchors { bottom: parent.bottom; bottomMargin: dp(40); horizontalCenter: parent.horizontalCenter }
                    backgroundColor: Style.ptyTransparent
                    textColor: Style.ptyColorOrangeDark
                    borderColor: Style.ptyColorOrangeDark
                    onClicked: stackView.push(comRegisterPage)
                }
            }
        }
    }

    //! [Component AppPage]
    Component { id: comSignInPage;   SignInPage   { onSigSignIn: sigSignInHome() } }
    Component { id: comRegisterPage; RegisterPage { } }

    ChangeLanguageModal {
        id: changeLanguageModal
    }
}
