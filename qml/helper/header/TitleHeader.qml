import QtQuick
import Felgo

import "../style"

AppText {
    id: txtTitle
    text: qsTr(title)
    width: parent.width
    leftPadding: dp(16)
    rightPadding: dp(16)
    horizontalAlignment: AppText.AlignLeft
    font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(16); weight: 700 }
}

