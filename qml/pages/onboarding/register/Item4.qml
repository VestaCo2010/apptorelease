import QtQuick
import Felgo

import "../../../helper/textInput"

Item {
    id: item4

    function validatePasswordInfo() {
        serviceUserManagement.validatePasswordInfo(txtPassword.text,txtConfirmPassword.text)
    }

    CustomInputText {
        id: txtPassword
        width: parent.width - dp(32)
        anchors { bottom: txtConfirmPassword.top; bottomMargin: dp(24); horizontalCenter: parent.horizontalCenter }
        inputMode: inputModePassword
        placeholderText: qsTr("Password")
        Keys.onEnterPressed: txtConfirmPassword.forceActiveFocus()
        Keys.onReturnPressed: txtConfirmPassword.forceActiveFocus()
    }

    CustomInputText {
        id: txtConfirmPassword
        width: parent.width - dp(32)
        anchors { bottom: parent.bottom; bottomMargin: dp(32); horizontalCenter: parent.horizontalCenter }
        inputMode: inputModePassword
        placeholderText: qsTr("Confirm password")
        Keys.onEnterPressed: buttonNext.clicked()
        Keys.onReturnPressed: buttonNext.clicked()
    }
}
