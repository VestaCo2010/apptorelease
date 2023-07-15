pragma Singleton
import QtQuick

Item {

    // Load english and persian fonts
    FontLoader { id: productSansBlack;   source: "qrc:/assets/fonts/fonts-en/ProductSans-Black.otf"   }
    FontLoader { id: productSansBold;    source: "qrc:/assets/fonts/fonts-en/ProductSans-Bold.otf"    }
    FontLoader { id: productSansLight;   source: "qrc:/assets/fonts/fonts-en/ProductSans-Light.otf"   }
    FontLoader { id: productSansMedium;  source: "qrc:/assets/fonts/fonts-en/ProductSans-Medium.otf"  }
    FontLoader { id: productSansRegular; source: "qrc:/assets/fonts/fonts-en/ProductSans-Regular.otf" }
    FontLoader { id: productSansThin;    source: "qrc:/assets/fonts/fonts-en/ProductSans-Thin.otf"    }

    // Create object persian fonts
    readonly property font   fontProductSansBlack    : Qt.font({ family: productSansBlack.name   })
    readonly property font   fontProductSansBold     : Qt.font({ family: productSansBold.name    })
    readonly property font   fontProductSansLight    : Qt.font({ family: productSansLight.name   })
    readonly property font   fontProductSansMedium   : Qt.font({ family: productSansMedium.name  })
    readonly property font   fontProductSansRegular  : Qt.font({ family: productSansRegular.name })
    readonly property font   fontProductSansThin     : Qt.font({ family: productSansThin.name    })

    // InitColors
    readonly property color  ptyColorBlack           : "#000000"
    readonly property color  ptyColorWhite           : "#FFFFFF"

    // Gray pallet
    readonly property color  ptyColorGray10          : "#FAFAFA"
    readonly property color  ptyColorGray20          : "#F8F8F8"
    readonly property color  ptyColorGray30          : "#E1E1E1"
    readonly property color  ptyColorGray40          : "#E9E9E9"
    readonly property color  ptyColorGray50          : "#CCCCCC"
    readonly property color  ptyColorGray60          : "#ABABAB"
    readonly property color  ptyColorGray70          : "#999999"
    readonly property color  ptyColorGray80          : "#808080"

    // Red pallet
    readonly property color  ptyColorRedDark         : "#E94D4D"

    // Orange pallet
    readonly property color  ptyColorOrangeDark      : "#FF6D00"

    // ThemeColors
    readonly property color  ptyColorPrimary         : "#FF6D00"
    readonly property color  ptyTransparent          : "transparent"

    // Notification Color
    readonly property color  ptyColorSuccess         : "#0BB74F"
    readonly property color  ptyColorWarning         : "#FF6D00"
    readonly property color  ptyColorError           : "#B70B0B"
    readonly property color  ptyColorInfo            : "#370BB7"
    readonly property color  ptyColorWaiting         : "#F9EF00"

    // Purple pallet
    readonly property color  ptyColorPurple80        : "#BDB7FF"
    readonly property color  ptyColorPurple90        : "#A8A1FF"
    readonly property color  ptyColorPurple100       : "#7E72FF"

    // Radius
    property int             ptyButtonRaduis         : 8
    property int             ptyInputRaduis          : 8
}

