import QtQuick
import Felgo

//! [Style]
import "../../../helper/style"

Item {

    property alias alyTxtTitle: txtTitle.text

    AppText {
        id: txtTitle
        text: qsTr("Do you want to save information?")
        //text: qsTr("Please wait, the system is registering information.")
        width: parent.width
        horizontalAlignment: AppText.AlignLeft
        anchors { left: parent.left }
        font { family: Style.fontProductSansRegular; pixelSize: sp(16) }
        color: Style.ptyColorBlack
        leftPadding: dp(16)
    }

}
