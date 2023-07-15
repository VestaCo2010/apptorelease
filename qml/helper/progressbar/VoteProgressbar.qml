import QtQuick
import QtQuick.Controls
import Felgo

import "../../helper/style"

ProgressBar {
    id: control

    property int ptyHeight: 4
    from: 0
    to: 100

    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: dp(ptyHeight)
        color: Style.ptyColorGray30
        radius: dp(4)
    }

    contentItem: Item {
        implicitWidth: parent.width
        implicitHeight: dp(ptyHeight)

        Rectangle {
            id: rect
            width: control.visualPosition * parent.width
            height: parent.height
            radius: dp(4)

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: Style.ptyColorPurple100 }
                GradientStop { position: 0.5; color: Style.ptyColorPurple90 }
                GradientStop { position: 1.0; color: Style.ptyColorPurple80 }
            }
        }
    }
}
