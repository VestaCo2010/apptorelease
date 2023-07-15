import QtQuick
import QtQuick.Controls

import "../style"

Item {
    id: root
    width: ptySize + dp(10)
    height: width

    signal sigClicked

    property color ptyColor: Style.ptyColorBlack
    property int   ptySize : dp(24)
    property alias source  : image.source

    Image {
        id: image
        width: ptySize
        height: ptySize
        sourceSize: Qt.size(ptySize, ptySize)
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: sigClicked()
    }
}
