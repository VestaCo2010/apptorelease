import QtQuick
import Felgo

import "../button"
import "../style"

//! [ button icon]
IconColor {
    id: backIcon
    anchors { top: parent.top; topMargin: dp(16); left: parent.left; leftMargin: dp(16) }
    source: "qrc:/assets/icon/arrow_left.svg"
    onSigClicked: navigationStack.pop()
    LayoutMirroring.enabled: false
}
