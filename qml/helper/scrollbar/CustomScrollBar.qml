import QtQuick 2.15
import QtQuick.Controls 2.15

import "../style"

ScrollBar {
    id: root

    minimumSize: orientation == Qt.Horizontal ? height / width : width / height
    padding: 2
    visible: root.policy !== ScrollBar.AlwaysOff

    contentItem: Rectangle {
        antialiasing: true
        color: Style.ptyColorGray80
        implicitHeight: dp(4)
        implicitWidth: dp(4)
        opacity: 0
        radius: dp(4)

        border {
            color: Style.ptyColorGray80
            width: dp(1)
        }

        state: ""
        states: State {
            name: "active"
            when: root.policy === ScrollBar.AlwaysOn || (root.active && root.size < 1.0)
            PropertyChanges { target: root.contentItem; opacity: 1 }
        }

        transitions: Transition {
            from: "active"
            NumberAnimation { target: root.contentItem; duration: 200; property: "opacity"; to: 0.0 }
        }
    }
}
