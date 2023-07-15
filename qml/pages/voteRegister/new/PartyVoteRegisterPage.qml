import QtQuick
import QtQuick.Controls
import Felgo

//! [Style]
import "../../../helper/style"

//! [Component]
import "../../../helper/textInput"
import "../../../helper/scrollbar"

//! [C++ Class]
import VOTE.ServiceParty

Rectangle {
    id: control
    radius: dp(8)
    color: Style.ptyColorGray20
    anchors.fill: parent

    LayoutMirroring.enabled: Lang.isRTL
    LayoutMirroring.childrenInherit: Lang.isRTL

    Component.onCompleted: serviceParty.requestParty()

    property alias alyListView: listView

    ServiceParty {
        id: serviceParty

        classErrorHandling: ErrorHandling
        onSigHidLoading: loading.close()
    }

    Item {
        id: itemHeader
        anchors { top: parent.top; topMargin: dp(12); left: parent.left; leftMargin: dp(16); right: parent.right; rightMargin: dp(16) }

        AppText {
            id: txtTitleLogo
            text: qsTr("Logo")
            width: dp(40)
            horizontalAlignment: AppText.AlignLeft
            anchors { left: parent.left }
            font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
            color: Style.ptyColorBlack
        }

        AppText {
            id: txtTitleParty
            text: qsTr("Party")
            anchors { left: txtTitleLogo.right; right: txtTitleVote.left }
            horizontalAlignment: AppText.AlignLeft
            font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
            color: Style.ptyColorBlack
        }

        AppText {
            id: txtTitleVote
            text: qsTr("Vote")
            width: dp(64)
            horizontalAlignment: AppText.AlignLeft
            anchors { right: parent.right }
            font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
            color: Style.ptyColorBlack
        }
    }

    Rectangle {
        id: recLine
        width: parent.width - dp(24)
        height: dp(1)
        anchors { left: parent.left; leftMargin: dp(12); top: parent.top; topMargin: dp(40) }
        color: Style.ptyColorGray40
    }

    AppListView {
        id: listView
        width: parent.width
        backgroundColor: Style.ptyTransparent
        header: Item { height: dp(12); width: listView.width }
        headerPositioning: ListView.OverlayHeader
        spacing: dp(12)
        anchors { top: recLine.bottom; bottom: control.bottom }
        ScrollBar.vertical: CustomScrollBar {
            id: verticalScrollBar;
            visible: listView.orientation === ListView.Vertical
            policy: listView.contentHeight <= listView.height ? ScrollBar.AsNeeded:ScrollBar.AlwaysOn
        }
        Keys.onPressed: {
            if (event.key === Qt.Key_Return) {
                console.log("Keys.Key_Return")
                if (listView.currentIndex === listView.count - 1) {
                    Qt.inputMethod.hide()
                } else {
                    listView.currentIndex++
                }
            }
        }

        model: serviceParty.modelParty
        delegate: Item {
            id: delegate
            width: listView.width
            height: dp(26)

            RoundedImage {
                id: imgLogo
                width: delegate.height
                height: delegate.height
                radius: dp(12)
                anchors { left: parent.left; leftMargin: dp(16) }
                fillMode: Image.PreserveAspectCrop
                source: partyLogo
            }

            Text {
                id: txtPartyId
                text: partyId
                visible: false
            }

            Text {
                id: txtPartyName
                text: Lang.isRTL ? partyNameKu : partyNameEn
                height: delegate.height
                horizontalAlignment: AppText.AlignLeft
                verticalAlignment: AppText.AlignVCenter
                anchors { left: imgLogo.right; leftMargin: dp(16); right: txtVote.left; rightMargin: dp(16) }
                font { family: Style.fontProductSansRegular; bold: false; pixelSize: sp(13) }
                color: Style.ptyColorBlack
                elide: Text.ElideRight
            }

            CustomInputText {
                id: txtVote
                width: dp(90)
                height: delegate.height
                anchors { right: parent.right; rightMargin: dp(16) }
                font { family: Style.fontProductSansRegular; pixelSize: sp(14); weight: 500 }
                placeholderText: qsTr("vote")
                maximumLength: 8
                inputMethodHints: Qt.ImhPreferNumbers   // Qt.ImhFormattedNumbersOnly
                validator: RegularExpressionValidator { regularExpression: /[0-9]+/ }
                focus: listView.currentIndex === index
            }
        }
    }
}
