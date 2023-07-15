import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Felgo

import "../../helper/style"

Popup {
    id: toast
    width: (parent.width - dp(24))
    height: dp(64)
    padding: dp(0)
    x: dp(12)
    y: NativeUtils.safeAreaInsets.top + dp(20)
    z: dp(99)
    onOpened: if(visible) timer.running = true
    closePolicy: Popup.NoAutoClose

    property alias state  : recState.state
    property alias title  : txtTitle.text
    property alias message: txtMessage.text

    Timer {
        id: timer
        running: false
        interval: 4000
        onTriggered: toast.close()
    }

    background: Rectangle {
        id: recBackground
        anchors.fill: parent
        color: Style.ptyColorWhite
        radius: dp(6)
        layer.enabled: true
        layer.effect: DropShadow{
            source: recBackground
            horizontalOffset: 0
            verticalOffset:0
            radius: 4
            samples: 7
            color: Style.ptyColorGray50
        }
    }

    contentItem: Item {

        LayoutMirroring.enabled: Lang.isRTL
        LayoutMirroring.childrenInherit: Lang.isRTL

        Rectangle {
            id: recState
            width: dp(10)
            height: parent.height
            color: Style.ptyColorSuccess
            anchors { left: parent.left; verticalCenter: parent.verticalCenter }
            radius: dp(6)

            state: "Success"
            states: [
                State {
                    name: "Success"
                    PropertyChanges {
                        target: recState
                        color: Style.ptyColorSuccess
                    }
                },
                State {
                    name: "Error"
                    PropertyChanges {
                        target: recState
                        color: Style.ptyColorError
                    }
                },
                State {
                    name: "Warning"
                    PropertyChanges {
                        target: recState
                        color: Style.ptyColorWarning
                    }
                },
                State {
                    name: "Info"
                    PropertyChanges {
                        target: recState
                        color: Style.ptyColorInfo
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
            id: txtTitle
            color: Style.ptyColorGray80
            width: parent.width
            leftPadding: dp(20)
            rightPadding: dp(20)
            horizontalAlignment: AppText.AlignLeft
            font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(14) }
            anchors {
                top: parent.top
                topMargin: dp(12)
            }
        }

        Text {
            id: txtMessage
            color: Style.ptyColorGray80
            width: parent.width
            leftPadding: dp(20)
            rightPadding: dp(20)
            horizontalAlignment: AppText.AlignLeft
            font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
            anchors {
                bottom: parent.bottom
                bottomMargin: dp(12)
            }
        }
    }
}
