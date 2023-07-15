import QtQuick
import Felgo

//! [Style]
import "../style"

Rectangle {
    id: control

    property string ptyRegionCode : ""
    property string ptyFoundNumber: ""

    width: parent.width - dp(32)
    height: dp(76)

    radius: dp(8)
    color: Style.ptyColorGray20

    anchors {
        top: parent.top
        topMargin: /*NativeUtils.safeAreaInsets.top*/ + dp(16);
        horizontalCenter: parent.horizontalCenter
    }

    AppText {
        id: txtRegionTitle
        text: qsTr("Center code")
        width: contentWidth
        color: Style.ptyColorBlack
        horizontalAlignment: AppText.AlignLeft
        anchors { top: parent.top; topMargin: dp(12); left: parent.left; leftMargin: dp(16) }
        font { family: Style.fontProductSansRegular; pixelSize: sp(14); weight: 500 }
    }

    AppText {
        id: txtRegionCode
        text: ptyRegionCode
        width: contentWidth
        color: Style.ptyColorBlack
        horizontalAlignment: AppText.AlignLeft
        anchors { bottom: parent.bottom; bottomMargin: dp(14); left: parent.left; leftMargin: dp(16)}
        font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(22); weight: 500 }
    }


    AppText {
        id: txtFundTitle
        text: qsTr("Station code")
        width: contentWidth
        color: Style.ptyColorBlack
        horizontalAlignment: AppText.AlignLeft
        anchors { top: parent.top; topMargin: dp(12); left: parent.left; leftMargin: control.width / 2 }
        font { family: Style.fontProductSansRegular; pixelSize: sp(14); weight: 500 }
    }

    AppText {
        id: txtFundNumber
        text: ptyFoundNumber
        width: contentWidth
        color: Style.ptyColorBlack
        horizontalAlignment: AppText.AlignLeft
        anchors { bottom: parent.bottom; bottomMargin: dp(14); left: parent.left; leftMargin: control.width / 2 }
        font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(22); weight: 500 }
    }
}
