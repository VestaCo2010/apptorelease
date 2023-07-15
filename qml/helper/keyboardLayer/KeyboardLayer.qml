import QtQuick
import Felgo

//! [Style]
import "../../helper/style"

Rectangle {
    width: parent.width
    height: dp(45)
    color: "#F1F1F2"
    anchors { bottom: parent.bottom; bottomMargin: Qt.inputMethod.keyboardRectangle.height }
    visible: app.keyboardVisible &&  !Qt.inputMethod.animating && Qt.platform.os === "ios"
    z : 120

    AppText {
        id: txtDone
        text: qsTr("Done")
        height: parent.height
        width: contentWidth
        color: "#0374FF"
        horizontalAlignment: AppText.AlignRight
        anchors { verticalCenter: parent.verticalCenter; right: parent.right; rightMargin: dp(20) }
        font { family: Style.fontProductSansRegular; pixelSize: sp(16); weight: 600 }
        bottomPadding: dp(3)

        MouseArea {
            anchors.fill: parent
            onClicked: Qt.inputMethod.hide();
        }
    }
}
