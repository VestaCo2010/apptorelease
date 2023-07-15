import QtQuick
import QtQuick.Controls 2.15 as QQC
import Felgo

//! [Style]
import "../style"

//! [Component]
import "../header"
import "../button"
import "../textInput"

//! [C++ Class]
import VOTE.Language

QQC.Drawer {
    id: drawer
    width: parent.width
    height: dp(276) + NativeUtils.safeAreaInsets.bottom

    edge: Qt.BottomEdge
    background: Rectangle { radius: dp(16); Rectangle { anchors.bottom: parent.bottom; height: dp(40); width: parent.width } }
    interactive: false
    onOpened: ptySelectedLangValue = Lang.ptyLanguage
    z: 2

    property string ptySelectedLangValue: Lang.ptyLanguage

    component LanguageItem: Rectangle {
        width: parent.width
        height: dp(40)
        color: (ptySelectedLangValue === langValue) ? Style.ptyColorGray30 : Style.ptyColorWhite
        radius: dp(8)

        property string title    : ""
        property string langValue: ""

        AppText {
            text: qsTr(title)
            anchors.centerIn: parent
            color: (ptySelectedLangValue === langValue) ? Style.ptyColorBlack : Style.ptyColorGray80
            font { family: Style.fontProductSansRegular; pixelSize: sp(16); weight: 500 }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: ptySelectedLangValue = langValue
        }
    }

    contentItem: Item {

        //! [Close button icon]
        IconColor {
            id: closeIcon
            anchors { top: parent.top; topMargin: dp(16); right: parent.right; rightMargin: dp(12) }
            source: "qrc:/assets/icon/close.svg"
            onSigClicked: drawer.close()
            LayoutMirroring.enabled: false
        }

        TitleHeader {
            id: txtTitle
            text: qsTr("Choose the language")
            anchors { bottom: closeIcon.bottom; bottomMargin: dp(4) }
        }

        Column {
            id: inputsColumn
            width: parent.width - dp(32)
            anchors { top: txtTitle.bottom; topMargin: dp(40); horizontalCenter: parent.horizontalCenter }
            spacing: dp(4)

            LanguageItem {
                title: "English"
                langValue: "en"
            }

            LanguageItem {
                title: "Kurdish"
                langValue: "ku"
            }
        }

        CustomButton {
            id: buttonConfirm
            width: parent.width - dp(32)
            text: qsTr("Confirm")
            horizontalMargin: 0
            anchors { top: inputsColumn.bottom; topMargin: dp(32); horizontalCenter: parent.horizontalCenter }
            onClicked: { Language.setLanguage(ptySelectedLangValue); drawer.close() }
        }
    }
}
