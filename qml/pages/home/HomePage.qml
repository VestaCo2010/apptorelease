import QtQuick
import Felgo

//! [Style]
import "../../helper/style"

//! [Component]
import "../../helper/button"
import "../../helper/keyboardLayer"

//! [Page]
import "../result"
import "../profile"
import "../voteRegister"
import "../voteRegister/new"

//! [C++ Class]
import VOTE.ServiceFund

AppPage {
    id: homePage
    useSafeArea: true
    LayoutMirroring.enabled: Lang.isRTL
    LayoutMirroring.childrenInherit: Lang.isRTL

    Component.onCompleted: {
        serviceFund.requestGetFund()
        navigation.currentIndex = app.userType == "pollster" ? 0 : 1
    }

    //! [Property - SHow in header vore register page]
    property string ptyRegionCode : ""
    property string ptyFoundNumber: ""

    ServiceFund {
        id: serviceFund
        onSigSuccessFundNumber: (regionCode, fundNumber) => {
                                    ptyRegionCode = regionCode
                                    ptyFoundNumber = fundNumber
                                }
        onSigRejectFundNumber: (message) => {
                                   toastMessage.state = "Warning"
                                   toastMessage.title = qsTr("Warning")
                                   toastMessage.message = message
                                   toastMessage.open()
                               }
        classErrorHandling: ErrorHandling
        onSigHidLoading: loading.close()
    }

    Navigation {
        id: navigation

        navigationMode: navigationModeTabs

        // Create item navigation component
        component NavigationIcon : Item {
            id: itm
            anchors.fill: parent

            property alias  title: titleTxt.text
            property string sourceOff: ""
            property string sourceSelected: ""

            IconColor {
                id: icon
                source: itm.parent.selected ? sourceSelected : sourceOff
                anchors { horizontalCenter: parent.horizontalCenter }

                AppText {
                    id: titleTxt
                    anchors { horizontalCenter: parent.horizontalCenter; top: icon.top; topMargin: dp(30) }
                    font { family: Style.fontProductSansRegular; pixelSize: sp(11); weight: 500 }
                    color: itm.parent.selected ? Style.ptyColorOrangeDark : Style.ptyColorGray70
                }
            }
        }

        // Vote register
        NavigationItem {
            id: voteRegister
            iconComponent: NavigationIcon {
                sourceSelected: "qrc:/assets/icon/footer/vote-register-filled.svg"
                sourceOff: "qrc:/assets/icon/footer/vote-register-regular.svg"
                title: qsTr("Vote register")
            }

            NavigationStack {
                id: navigationStack
                navigationBarShadow: true
                // SelectCandidatePage { }

                VoteRegister { }
            }
            enabled: app.userType == "pollster"
        }

        // Result
        NavigationItem {
            id: voteResult
            iconComponent: NavigationIcon {
                sourceSelected: "qrc:/assets/icon/footer/chart-filled.svg"
                sourceOff: "qrc:/assets/icon/footer/chart.svg"
                title: qsTr("Vote result")
            }

            NavigationStack {
                navigationBarShadow: true

                ResultPage { }
            }
        }

        // Profile
        NavigationItem {
            id: effectsItem
            iconComponent: NavigationIcon {
                sourceSelected: "qrc:/assets/icon/footer/profile-filled.svg"
                sourceOff: "qrc:/assets/icon/footer/profile.svg"
                title: qsTr("Profile")
            }

            NavigationStack {
                navigationBarShadow: true

                ProfilePage { }
            }
        }
    }
}



