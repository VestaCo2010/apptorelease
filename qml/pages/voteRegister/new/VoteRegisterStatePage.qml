import QtQuick
import Qt5Compat.GraphicalEffects
import Felgo

//! [Style]
import "../../../helper/style"

Rectangle {
    id: control

    width: parent.width - dp(2)
    height: dp(64)
    radius: dp(6)

    LayoutMirroring.enabled: Lang.isRTL
    LayoutMirroring.childrenInherit: Lang.isRTL

    layer.enabled: true
    layer.effect: DropShadow{
        source: control
        horizontalOffset: 0
        verticalOffset:0
        radius: 4
        samples: 7
        color: Style.ptyColorGray50
    }

    property alias state  : recState.state
    property alias message: txtMessage.text

    Rectangle {
        id: recState
        width: dp(10)
        height: parent.height
        color: Style.ptyColorSuccess
        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
        radius: dp(6)

        state: "accepted"
        states: [
            State {
                name: "accepted"
                PropertyChanges {
                    target: recState
                    color: Style.ptyColorSuccess
                }
            },
            State {
                name: "waiting"
                PropertyChanges {
                    target: recState
                    color: Style.ptyColorWaiting
                }
            }
        ]
    }

    Rectangle {
        width: dp(10)
        height: parent.height
        anchors { left: parent.left; leftMargin: dp(5); verticalCenter: parent.verticalCenter }
    }

    Text {
        id: txtMessage
        color: Style.ptyColorBlack
        width: control.width
        height: dp(50)
        leftPadding: dp(20)
        rightPadding: dp(20)
        horizontalAlignment: AppText.AlignLeft
        wrapMode: Text.WordWrap
        font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
        anchors { top: parent.top; topMargin: dp(12); bottom: parent.bottom; bottomMargin: dp(12) }
    }
}
