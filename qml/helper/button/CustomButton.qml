import QtQuick
import Felgo

//! [Style]
import "../style"

AppButton {
    id: buttonLogin
    // height: dp(40)
    radius: dp(50)
    backgroundColor: Style.ptyColorOrangeDark
    backgroundColorPressed: Qt.darker(backgroundColor,1.03)
    backgroundColorHovered: Style.ptyColorOrangeDark
    textColor: Style.ptyColorWhite
    textColorPressed: textColor
    textFont { family: Style.fontProductSansRegular; pixelSize: sp(16); weight: 500 }
    dropShadow: false
    borderColor: Style.ptyColorOrangeDark
    borderColorPressed: borderColor
    borderColorHovered: borderColor
    borderWidth: dp(2)
    horizontalMargin: 0
    flat: false
}
