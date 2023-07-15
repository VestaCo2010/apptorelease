import QtQuick
import QtQuick.Controls 2.15 as QQC
import Felgo

//! [Style]
import "../style"

//! [Component]
import "../header"
import "../button"
import "../textInput"

QQC.Drawer {
    id: drawer
    width: parent.width
    height: dp(350) + NativeUtils.safeAreaInsets.bottom
    edge: Qt.BottomEdge
    background: Rectangle { radius: dp(16); Rectangle { anchors.bottom: parent.bottom; height: dp(40); width: parent.width } }
    interactive: false
    z: 2

    onClosed : {
        txtCurrentPassword.text = ""
        txtPassword.text = ""
        txtConfirmPassword.text = ""
    }

    function funChangePassword() {
        Qt.inputMethod.hide()
        loading.open()
        serviceUserManagement.validateEditPasswordInfo(txtCurrentPassword.text,txtPassword.text,txtConfirmPassword.text )
    }

    contentItem: Item {

        //! [Close button icon]
        IconColor {
            id: closeIcon
            anchors { top: parent.top; topMargin: dp(16); right: parent.right; rightMargin: dp(12) }
            source: "qrc:/assets/icon/close.svg"
            onSigClicked: drawer.close()
            LayoutMirroring.enabled: false
        }

        TitleHeader {
            id: txtTitle
            text: qsTr("Change password")
            anchors { bottom: closeIcon.bottom; bottomMargin: dp(4) }
        }

        Column {
            id: inputsColumn
            width: parent.width - dp(32)
            anchors { top: txtTitle.bottom; topMargin: dp(40); horizontalCenter: parent.horizontalCenter }
            spacing: dp(24)
            LayoutMirroring.enabled: Lang.isRTL
            LayoutMirroring.childrenInherit: Lang.isRTL

            CustomInputText {
                id: txtCurrentPassword
                width: parent.width
                height: dp(40)
                inputMode: inputModePassword
                placeholderText: qsTr("Current password")
                Keys.onEnterPressed: txtPassword.forceActiveFocus()
                Keys.onReturnPressed: txtPassword.forceActiveFocus()
            }

            CustomInputText {
                id: txtPassword
                width: parent.width
                height: dp(40)
                inputMode: inputModePassword
                placeholderText: qsTr("Password")
                Keys.onEnterPressed: txtConfirmPassword.forceActiveFocus()
                Keys.onReturnPressed: txtConfirmPassword.forceActiveFocus()
            }

            CustomInputText {
                id: txtConfirmPassword
                width: parent.width
                height: dp(40)
                inputMode: inputModePassword
                placeholderText: qsTr("Confirm password")
                Keys.onEnterPressed: funChangePassword()
                Keys.onReturnPressed: funChangePassword()
            }

        }

        CustomButton {
            id: buttonConfirm
            width: parent.width - dp(32)
            text: qsTr("Confirm")
            horizontalMargin: 0
            anchors { top: inputsColumn.bottom; topMargin: dp(32); horizontalCenter: parent.horizontalCenter }
            onClicked: funChangePassword()
        }
    }
}
