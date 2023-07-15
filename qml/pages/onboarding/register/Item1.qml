import QtQuick
import Felgo

import "../../../helper/textInput"

Item {
    id: item1

    function validatePersonalityInfo() {
        serviceUserManagement.validatePersonalityInfo(txtName.text, txtFamily.text)
    }

    CustomInputText {
        id: txtName
        width: parent.width - dp(32)
        anchors { bottom: txtFamily.top; bottomMargin: dp(24); horizontalCenter: parent.horizontalCenter }
        showClearButton: true
        placeholderText: qsTr("Name")
        Keys.onEnterPressed: txtFamily.forceActiveFocus()
        Keys.onReturnPressed: txtFamily.forceActiveFocus()
    }

    CustomInputText {
        id: txtFamily
        width: parent.width - dp(32)
        anchors { bottom: parent.bottom; bottomMargin: dp(32); horizontalCenter: parent.horizontalCenter }
        showClearButton: true
        placeholderText: qsTr("LastName")
        Keys.onEnterPressed: buttonNext.clicked()
        Keys.onReturnPressed: buttonNext.clicked()
    }
}
