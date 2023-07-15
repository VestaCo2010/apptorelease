import QtQuick
import Felgo

//! [Style]
import "../style"

//! [Component]
import "../button"

AppTextField {
    showClearButton: true
    width: parent.width - dp(32)
    height: dp(48)
    font { family: Style.fontProductSansRegular; pixelSize: sp(14); weight: 400 }
    placeholderText: qsTr("Search candidate")
    placeholderColor: Style.ptyColorGray80
    cursorColor: Style.ptyColorGray80
    borderColor: Style.ptyColorGray30
    borderWidth: dp(1)
    leftPadding: Lang.isRTL ? dp(16) : dp(42)
    rightPadding: Lang.isRTL ? dp(42) : dp(16)
    radius: dp(8)
    horizontalAlignment: AppText.AlignLeft
    font.capitalization: Font.MixedCase
    Keys.onEnterPressed: { Qt.inputMethod.hide(); focus = false }
    Keys.onReturnPressed: { Qt.inputMethod.hide(); focus = false }

    IconColor {
        id: icon
        source: "qrc:/assets/icon/search.svg"
        ptySize: dp(20)
        anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: dp(12) }
    }
}
