import QtQuick
import Felgo

import "../style"

AppListView {
    signal sigClicked(var itemId, var itemName, var itemType)

    backgroundColor: Style.ptyTransparent
    spacing: dp(12)

//    delegate: Rectangle {
//        width: parent.width
//        height: dp(48)
//        color:  mouseArea.containsPress ? Qt.darker(Style.ptyColorGray10,1.03) : Style.ptyColorGray10
//        radius: dp(8)

//        AppText {
//            text: qsTr(name)
//            width: parent.width
//            anchors { verticalCenter: parent.verticalCenter }
//            leftPadding:  dp(12)
//            rightPadding: dp(12)
//            horizontalAlignment: AppText.AlignLeft
//            font { family: Style.fontProductSansRegular; pixelSize: sp(16); weight: 400 }
//        }

//        MouseArea {
//            id: mouseArea
//            anchors.fill: parent
//            onClicked: sigClicked(itemId, name, type)
//        }
//    }
}
