import QtQuick 2.15
import QtQuick.Controls 2.15

import "../style"

Rectangle {
    id: root
    width: parent.width
    height: ptyHeight
    color: Style.ptyColorWhite

    signal signalClicked(var indx)

    property int    ptyHeight         : dp(35)

    property int    ptyItemWidth      : parent.width / listView.count
    property int    ptyItemHeight     : ptyHeight

    property alias  ptyModel          : listView.model
    property alias  ptyCurrentIndex   : listView.currentIndex
    property bool   ptyIndexChangeable: true

    property var    ptyList

    ListModel {
        id: list
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: ptyModel
        interactive: false
        orientation: ListView.Horizontal
        delegate: Text {
            width: ptyItemWidth
            height: ptyItemHeight
            text: buttonName
            color: Style.ptyColorBlack
            font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            opacity: listView.currentIndex === index ? 1 : 0.6

            Rectangle { width: parent.width; height: dp(2); anchors.bottom: parent.bottom; color: Style.ptyColorGray50 }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(ptyIndexChangeable)
                        listView.currentIndex = index
                    signalClicked(index)
                }
            }
        }

        focus: true
        highlight: Item {
            z: 2
            Rectangle {
                width: parent.width
                height: dp(2)
                y: parent.height - height
                color: Style.ptyColorPrimary
            }
        }
        highlightFollowsCurrentItem: true
        highlightMoveDuration: dp(100)
        highlightResizeDuration: dp(0)
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: dp(48)
        preferredHighlightEnd: width - dp(48)
    }
}

