import QtQuick
import Felgo

//! [Style]
import "../style"

AppTextField {
    // showClearButton: true
    height: dp(40)
    font { family: Style.fontProductSansRegular; pixelSize: sp(14); weight: 500 }
    placeholderColor: Style.ptyColorGray50
    borderColor: Style.ptyColorGray50
    borderWidth: dp(1)
    leftPadding: 10
    rightPadding: 10
    radius: dp(8)
    cursorColor: Style.ptyColorGray50
    passwordVisibleButton.color: Style.ptyColorGray60
    horizontalAlignment: AppText.AlignLeft
    font.capitalization: Font.MixedCase
}
