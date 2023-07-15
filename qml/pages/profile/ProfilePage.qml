import QtQuick
import QtQuick.Controls
import Felgo

//! [Style]
import "../../helper/style"

//! [Component]
import "../../helper/modal"
import "../../helper/button"
import "../../helper/textInput"
import "../../helper/scrollbar"

//! [C++ Class]
import VOTE.Token
import VOTE.ServiceUserManagement

AppPage {
    id: profilePage
    useSafeArea: true
    navigationBarHidden: true
    LayoutMirroring.enabled: Lang.isRTL
    LayoutMirroring.childrenInherit: Lang.isRTL
    onAppeared: {
        loading.open()
        serviceUserManagement.getUserProfile()
    }

    property int    ptyUserId: 0
    property string ptyNavigationMessage: ""
    // component for the profile info items
    component ProfileInfoItem : Row {
        width: parent.width - dp(44)
        height: dp(40)
        spacing: dp(8)
        anchors.horizontalCenter: parent.horizontalCenter

        property alias title: titleInfoTxt.text
        property alias valueTxt: valueInfoTxt.text

        AppText {
            id: titleInfoTxt
            width: parent.width / 2
            horizontalAlignment: AppText.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font { family: Style.fontProductSansRegular; pixelSize: sp(14); weight: 500 }
        }

        AppText {
            id: valueInfoTxt
            width: parent.width / 2
            horizontalAlignment: AppText.AlignRight
            anchors.verticalCenter: parent.verticalCenter
            color: Style.ptyColorGray80
            font { family: Style.fontProductSansRegular; pixelSize: sp(14); weight: 500 }
        }
    }

    // component for line between the profile info items
    component Divider : Rectangle {
        width: parent.width - dp(12)
        height: dp(1)
        anchors.horizontalCenter: parent.horizontalCenter
        color: Style.ptyColorGray40
    }

    ChangePasswordModal {
        id: changePasswordModal
    }

    ServiceUserManagement {
        id: serviceUserManagement

        onSigSuccessGetUserProfile: (userId, name, family, pollsterId, province, city,
                                     region, fundNumber, username, mobile, image, userType, userHasDelete) => {
                                        ptyUserId                = userId
                                        profileImage.source      = Qt.resolvedUrl(image) //*/  Qt.resolvedUrl("https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_4x3.jpg")
                                        txtName.valueTxt         = name
                                        txtFamily.valueTxt       = family
                                        txtPollsterId.valueTxt   = pollsterId
                                        txtProvince.valueTxt     = province
                                        txtCity.valueTxt         = city
                                        txtRegion.valueTxt       = region
                                        txtFundNumber.valueTxt   = fundNumber
                                        txtUsername.valueTxt     = username
                                        txtMobile.valueTxt       = mobile  // "https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_4x3.jpg"
                                        txtUserType.valueTxt     = userType
                                        buttonDeleteUser.visible = userHasDelete
                                    }
        onSigSuccessEditUserPassword: (message) => {
                                          toastMessage.state = "Success"
                                          toastMessage.title = qsTr("Success")
                                          toastMessage.message = message
                                          toastMessage.open()
                                          changePasswordModal.close()
                                      }
        onSigRejectEditUserPassword: (message) => {
                                         toastMessage.state = "Error"
                                         toastMessage.title = qsTr("Error")
                                         toastMessage.message = message
                                         toastMessage.open()
                                     }

        onSigSuccessDeleteUser: (message) => {
                                    toastMessage.state = "Success"
                                    toastMessage.title = qsTr("Success")
                                    toastMessage.message = message
                                    toastMessage.open()
                                    Token.clearToken()
                                }
        onSigRejectDeleteUser: (message) => {
                                   toastMessage.state = "Error"
                                   toastMessage.title = qsTr("Error")
                                   toastMessage.message = message
                                   toastMessage.open()
                               }

        onSigRejectValidateInfo: (message) => {
                                     toastMessage.state = "Warning"
                                     toastMessage.title = qsTr("Warning")
                                     toastMessage.message = message
                                     toastMessage.open()
                                 }
        classErrorHandling: ErrorHandling
        onSigHidLoading: loading.close()
    }

    Connections {
        target: nativeUtils
        onAlertDialogFinished: (accepted) => {
                                   if(accepted && ptyNavigationMessage === "Logout") {
                                       Token.clearToken()
                                   }
                                   if(accepted && ptyNavigationMessage === "Delete-account")
                                   serviceUserManagement.deleteUser(ptyUserId)
                               }
    }

    //! [Image open gallery]
    RoundedImage {
        id: profileImage
        width: dp(100)
        height: dp(100)
        radius: dp(50)
        backgroundColor: Style.ptyTransparent
        border { width: dp(1); color: Style.ptyColorOrangeDark }
        anchors { top: parent.top; topMargin: /*NativeUtils.safeAreaInsets.top*/  dp(12); horizontalCenter: parent.horizontalCenter }
        fillMode: Image.PreserveAspectCrop
        visible: profileImage.img.status === Image.Ready
    }

    RoundedImage {
        id: profileImageDefault
        width: dp(100)
        height: dp(100)
        radius: dp(50)
        backgroundColor: Style.ptyTransparent
        border { width: dp(1); color: Style.ptyColorOrangeDark }
        anchors { top: parent.top; topMargin: /*NativeUtils.safeAreaInsets.top*/  dp(12); horizontalCenter: parent.horizontalCenter }
        source: "qrc:/assets/icon/gallery/gallery.svg"
        fillMode: Image.PreserveAspectCrop
        visible: profileImage.img.status !== Image.Ready
    }

    Flickable {
        id: flickable
        width: parent.width
        anchors { top: profileImage.bottom; topMargin: dp(12); bottom: buttonLogOut.top; bottomMargin: dp(12) }
        contentHeight: personalityFrame.height + infoFrame.height + buttonChangePassword.height + buttonDeleteUser.height + dp(60)
        interactive: height < contentHeight
        clip: true

        ScrollBar.vertical: CustomScrollBar {
            policy: flickable.contentHeight <= flickable.height ? ScrollBar.AsNeeded : ScrollBar.AlwaysOn
        }

        PullToRefreshHandler {
            listView: flickable
            onRefresh: serviceUserManagement.getUserProfile()
        }

        Rectangle {
            id: personalityFrame
            width: parent.width - dp(32)
            height: dp(122)
            radius: dp(8)
            anchors { horizontalCenter: parent.horizontalCenter; }
            color: Style.ptyColorGray20

            Column {
                anchors.fill: parent
                spacing: 0

                ProfileInfoItem {
                    id: txtName
                    title: qsTr("Name")
                }

                Divider { }

                ProfileInfoItem {
                    id: txtFamily
                    title: qsTr("Family")
                }

                Divider { }

                ProfileInfoItem {
                    id: txtPollsterId
                    title: qsTr("Supervisor code")
                }
            }
        }

        Rectangle {
            id: infoFrame
            width: parent.width - dp(32)
            height: dp(285)
            radius: dp(8)
            anchors { top: personalityFrame.bottom; topMargin: dp(16); horizontalCenter: parent.horizontalCenter; }
            color: Style.ptyColorGray20

            Column {
                anchors.fill: parent
                spacing: 0

                ProfileInfoItem {
                    id: txtProvince
                    title: qsTr("Province")
                }

                Divider{}
                ProfileInfoItem {
                    id: txtCity
                    title: qsTr("City")
                }

                Divider{}
                ProfileInfoItem {
                    id: txtRegion
                    title: qsTr("Center code")
                }

                Divider{}
                ProfileInfoItem {
                    id: txtFundNumber
                    title: qsTr("Station code")
                }

                Divider{}
                ProfileInfoItem {
                    id: txtMobile
                    title: qsTr("Mobile")
                }

                Divider{}
                ProfileInfoItem {
                    id: txtUsername
                    title: qsTr("Username")
                }

                Divider{}
                ProfileInfoItem {
                    id: txtUserType
                    title: qsTr("User type")
                }
            }
        }

        CustomButton {
            id: buttonChangePassword
            width: parent.width - dp(36)
            text: qsTr("Change password")
            anchors { top: infoFrame.bottom; topMargin: dp(16); horizontalCenter: parent.horizontalCenter }
            backgroundColor: Style.ptyTransparent
            textColor: Style.ptyColorOrangeDark
            borderColor: Style.ptyColorOrangeDark
            onClicked: changePasswordModal.open()
        }

        CustomButton {
            id: buttonDeleteUser
            width: parent.width - dp(36)
            height: visible ? buttonChangePassword.height : 0
            text: qsTr("Delete account")
            anchors { top: buttonChangePassword.bottom; topMargin: dp(8); horizontalCenter: parent.horizontalCenter }
            backgroundColor: Style.ptyTransparent
            textColor: Style.ptyColorRedDark
            borderColor: Style.ptyColorRedDark
            onClicked: {
                ptyNavigationMessage = "Delete-account"
                nativeUtils.displayAlertDialog(qsTr("Delete account"),
                                               qsTr("Do you want to delete your account ?"), qsTr("Yes"),
                                               qsTr("No"))
            }
        }
    }

    Rectangle {
        id: buttonLogOut
        width: parent.width - dp(36)
        height: dp(40)
        radius: dp(8)
        color: mouseArea.containsPress ? Qt.darker(Style.ptyColorGray20,1.03) : Style.ptyColorGray20
        anchors { bottom: parent.bottom; bottomMargin: dp(24); horizontalCenter: parent.horizontalCenter }

        AppText {
            text: qsTr("Logout")
            width: parent.width
            color: Style.ptyColorRedDark
            leftPadding: dp(10)
            rightPadding: dp(10)
            horizontalAlignment: AppText.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font { family: Style.fontProductSansRegular; pixelSize: sp(16); weight: 500 }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {

                ptyNavigationMessage = "Logout"
                nativeUtils.displayAlertDialog(qsTr("Logout"),
                                               qsTr("Do you want to logout ?"), qsTr("Yes"),
                                               qsTr("No"))
            }
        }
    }
}
