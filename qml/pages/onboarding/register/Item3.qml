import QtQuick
import Felgo

import "../../../helper/textInput"

Item {
    id: item3

    function validateAccountInfo() {
        serviceUserManagement.validateAccountInfo(txtMobile.text, txtUsername.text)
    }

    CustomInputText {
        id: txtMobile
        width: parent.width - dp(32)
        anchors { bottom: txtUsername.top; bottomMargin: dp(24); horizontalCenter: parent.horizontalCenter }
        showClearButton: true
        placeholderText: qsTr("Mobile")
        Keys.onEnterPressed: txtUsername.forceActiveFocus()
        Keys.onReturnPressed: txtUsername.forceActiveFocus()
        inputMethodHints: Qt.ImhPreferNumbers
    }

    CustomInputText {
        id: txtUsername
        width: parent.width - dp(32)
        anchors { bottom: parent.bottom; bottomMargin: dp(32); horizontalCenter: parent.horizontalCenter }
        showClearButton: true
        placeholderText: qsTr("Username")
        Keys.onEnterPressed: buttonNext.clicked()
        Keys.onReturnPressed: buttonNext.clicked()
    }
}
