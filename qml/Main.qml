import QtQuick
import Felgo

//! [Style]
import "../qml/helper/style"

//! [Component]
import "../qml/helper/message"
import "../qml/helper/loading"
import "../qml/helper/keyboardLayer"

import "../qml/pages/home"
import "../qml/pages/onboarding"

//! [C++ Class]
import VOTE.Language
import VOTE.Token

App {
    id: app
    Component.onCompleted: {
        Lang.getLanguage()
    }

    property string userType : "" // Pollster ~ Guest

    Connections {
        target: Token
        onSigShowHomeForm: {
            loader.sourceComponent = comHomePage
        }
        onSigShowLoginForm: {
            loader.sourceComponent = comOnboardingPage
        }
    }

    onKeyboardHeightChanged: {
        console.log("keyboardHeight                    " , app.keyboardHeight)
        console.log("NativeUtils.safeAreaInsets.top    " , NativeUtils.safeAreaInsets.top)
        console.log("NativeUtils.safeAreaInsets.bottom " , NativeUtils.safeAreaInsets.bottom)
        console.log("app.height                        " , app.height)
        console.log("app.screenHeight                  " , app.screenHeight)
    }

    onInitTheme: {
        Theme.colors.tintColor = Style.ptyColorGray20
        Theme.navigationTabBar.backgroundColor = Style.ptyColorGray20
        Theme.navigationTabBar.dividerColor = Style.ptyColorGray20
        Theme.navigationTabBar.height = dp(50)
        Theme.navigationTabBar.iconSize = dp(50)
        // Theme.colors.statusBarStyle = Theme.colors.statusBarStyleWhite
        Theme.colors.statusBarStyle = Theme.colors.statusBarStyleBlack
    }

    //! [Create connection for error handling]
    Connections {
        target: ErrorHandling
        onSigShowError: (err) => {
                            toastMessage.state = "Error"
                            toastMessage.title = qsTr("Error")
                            toastMessage.message = err
                            toastMessage.open()
                        }
    }

    //! [Toast message]
    ToastMessage {
        id: toastMessage
    }

    //! [Loading component]
    Loading {
        id: loading
    }

    //! [Main loader - Select signel page between OnboardingPage & HomePage]
    Loader {
        id: loader
        anchors.fill: parent
        sourceComponent: comOnboardingPage
    }

    Rectangle {
        width: parent.width
        height: NativeUtils.safeAreaInsets.top
        color: Style.ptyColorGray50
        anchors.top: parent.top
        z:2
    }

    Component { id: comHomePage;       HomePage       { } }
    Component { id: comOnboardingPage; OnboardingPage { onSigSignInHome: loader.sourceComponent = comHomePage } }

//    KeyboardLayer {
//        id: keyboardLayer
//        z: 99
//    }
}
