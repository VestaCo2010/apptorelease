import Felgo
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Popup {
    id: popup
    width: loader.width
    height: loader.height
    padding: 0

    FastBlur {
        id: fastBlur
        height: popup.height
        width:  popup.width
        radius: 30
        source: ShaderEffectSource {
            sourceItem: loader
            sourceRect: Qt.rect(0, 0, loader.width, loader.height)
        }
    }

    Rectangle { anchors.fill: fastBlur; color: "black"; opacity: 0.4}

    //! [Logo image]
    Image {
        id: img
        width: dp(130)
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/logo/logo.svg"
        anchors.centerIn: parent
    }

    SequentialAnimation {
        id: animation
        loops: Animation.Infinite
        running: true
            NumberAnimation { target: img;  property: "scale"; duration: 800; to: 1.2; easing.type: Easing.InOutQuad }
            NumberAnimation { target: img;  property: "scale"; duration: 700; to: 1;   easing.type: Easing.InOutQuad  }
    }
}
