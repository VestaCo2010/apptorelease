import QtQuick
import Felgo

import "../../../helper/textInput"

Item {
    id: item2

    function validateLocationInfo() {
        serviceUserManagement.validateLocationInfo(txtRegion.text, txtFundNumber.text, txtPollesterId.text)
    }

    CustomInputText {
        id: txtPollesterId
        width: parent.width - dp(32)
        anchors { bottom: txtRegion.top; bottomMargin: dp(24); left: parent.left; leftMargin: dp(16)  }
        showClearButton: true
        placeholderText: qsTr("Supervisor code")
        Keys.onEnterPressed: txtFundNumber.forceActiveFocus()
        Keys.onReturnPressed: txtFundNumber.forceActiveFocus()
        inputMethodHints: Qt.ImhPreferNumbers
    }

    CustomInputText {
        id: txtRegion
        width: (parent.width - dp(48)) / 2
        anchors { bottom: parent.bottom; bottomMargin: dp(32); left: parent.left; leftMargin: dp(16) }
        showClearButton: true
        placeholderText: qsTr("Center code")
        Keys.onEnterPressed: txtFundNumber.forceActiveFocus()
        Keys.onReturnPressed: txtFundNumber.forceActiveFocus()
        inputMethodHints: Qt.ImhPreferNumbers
    }

    CustomInputText {
        id: txtFundNumber
        width: (parent.width - dp(48)) / 2
        anchors { bottom: parent.bottom; bottomMargin: dp(32); right: parent.right; rightMargin: dp(16) }
        showClearButton: true
        placeholderText: qsTr("Station code")
        Keys.onEnterPressed: buttonNext.clicked()
        Keys.onReturnPressed: buttonNext.clicked()
        inputMethodHints: Qt.ImhPreferNumbers
    }
}
