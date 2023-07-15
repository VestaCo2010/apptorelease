import QtQuick
import Felgo

////! [Style]
//import "../../helper/style"

////! [Component]
//import "../../helper/button"
//import "../../helper/header"
//import "../../helper/textInput"
//import "../../helper/listview"

////! [C++ Class]
//import VOTE.PartyTbl

AppPage {
//    id: voteRegisterPage
//    useSafeArea: system.isPlatform(System.IOS)
//    navigationBarHidden: true
//    LayoutMirroring.enabled: Lang.isRTL
//    LayoutMirroring.childrenInherit: Lang.isRTL

//    TitleHeader {
//        id: txtTitle
//        topPadding: dp(40)
//        text: qsTr("Insert candidate code or name")
//    }

//    CustomSearchInput {
//        id: searchBar
//        anchors { top: txtTitle.bottom; topMargin: dp(12); horizontalCenter: parent.horizontalCenter }
//        onTextChanged: PartyTbl.getFromDb(searchBar.text)
//    }

//    AppListView {
//        id: listView
//        width: parent.width - dp(32)
//        backgroundColor: Style.ptyTransparent
//        anchors {
//            top: searchBar.bottom
//            topMargin: dp(16)
//            bottom: buttonEnterVote.top
//            bottomMargin: dp(12)
//            horizontalCenter: parent.horizontalCenter
//        }
//        visible: count
//        spacing: dp(12)
//        model: PartyTbl.modelPartyTbl
//        delegate: Rectangle {
//            width: listView.width
//            height: dp(48)
//            color:  mouseArea.containsPress ? Qt.darker(Style.ptyColorGray10,1.03) : Style.ptyColorGray10
//            radius: dp(8)

//            AppText {
//                text: Lang.isRTL ? partyNameKu : partyNameEn
//                width: parent.width
//                anchors { verticalCenter: parent.verticalCenter }
//                leftPadding:  dp(12)
//                rightPadding: dp(12)
//                horizontalAlignment: Lang.isRTL ? AppText.AlignRight : AppText.AlignLeft
//                font { family: Style.fontProductSansRegular; pixelSize: sp(16); weight: 400 }
//            }

//            MouseArea {
//                id: mouseArea
//                anchors.fill: parent
//                onClicked: navigationStack.push(Qt.resolvedUrl("SelectCandidatePage.qml"),{"ptyPartyId" : partyId})
//            }
//        }
//    }

//    CustomButton {
//        id: buttonEnterVote
//        width: dp(160)
//        height: dp(30)
//        text: qsTr("Enter vote manually")
//        anchors { bottom: parent.bottom; bottomMargin: dp(50); horizontalCenter: parent.horizontalCenter }
//        backgroundColor: Style.ptyTransparent
//        borderColor: Style.ptyTransparent
//        textColor: Style.ptyColorOrangeDark
//        onClicked: navigationStack.push(Qt.resolvedUrl("SelectPartyPage.qml"))
//    }

}
