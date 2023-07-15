import QtQuick
import Felgo

////! [Style]
//import "../../helper/style"

////! [Component]
//import "../../helper/header"
//import "../../helper/textInput"
//import "../../helper/listview"

////! [C++ Class]
//import VOTE.DataExist
//import VOTE.PartyTbl

AppPage {
//    useSafeArea: system.isPlatform(System.IOS)
//    navigationBarHidden: true
//    LayoutMirroring.enabled: Lang.isRTL
//    LayoutMirroring.childrenInherit: Lang.isRTL
//    onAppeared: {
//        dataExist.checkPartyTbl()
//    }

//    DataExist {
//        id: dataExist

//        onSigExistPartyTbl: {
//            PartyTbl.getFromDb("")
//        }
//        onSigNotExistPartyTbl: {
//            PartyTbl.requestParty()
//        }
//    }

//    Connections {
//        target: PartyTbl
//        onSigSuccessGetParty: { }
//        onSigRejectGetParty: (message) =>  {
//                                 toastMessage.state = "Warning"
//                                 toastMessage.title = qsTr("Warning")
//                                 toastMessage.message = message
//                                 toastMessage.open()
//                             }

//        onSigHidLoading:{
//            loading.close()
//        }
//    }

//    //! [Back button icon]
//    BackIconHeader {
//        id: backIcon
//    }

//    CustomSearchInput {
//        id: searchBar
//        anchors { top: backIcon.bottom; topMargin: dp(12); horizontalCenter: parent.horizontalCenter }
//        onTextChanged: PartyTbl.getFromDb(searchBar.text)
//    }

//    TitleHeader {
//        id: txtTitle
//        text: qsTr("Select the party")
//        anchors { top: searchBar.bottom; topMargin: dp(12) }
//    }

//    AppListView {
//        id: listView
//        width: parent.width - dp(32)
//        backgroundColor: Style.ptyColorWhite
//        anchors {
//            top: txtTitle.bottom
//            topMargin: dp(12)
//            bottom: parent.bottom
//            bottomMargin: dp(12)
//            horizontalCenter: parent.horizontalCenter
//        }
//        spacing: dp(8)
//        model: PartyTbl.modelPartyTbl
//        delegate: Rectangle {
//            width: listView.width
//            height: dp(48)
//            color:  mouseArea.containsPress ? Qt.darker(Style.ptyColorGray20, 1.03) : Style.ptyColorGray20
//            radius: dp(8)

//            AppText {
//                id: appText
//                text: Lang.isRTL ? partyNameKu : partyNameEn
//                width: parent.width
//                anchors { verticalCenter: parent.verticalCenter }
//                leftPadding:  dp(12)
//                rightPadding: dp(12)
//                horizontalAlignment: AppText.AlignLeft
//                font { family: Style.fontProductSansRegular; pixelSize: sp(16); weight: 400 }
//            }

//            MouseArea {
//                id: mouseArea
//                anchors.fill: parent
//                onClicked: navigationStack.push(Qt.resolvedUrl("VoteInfoPage.qml"),
//                                                {
//                                                    "ptyPartyId": partyId,
//                                                    "ptyCandidateId": "",
//                                                    "ptyCandidateNameFamily": "",
//                                                    "ptyImagePath": ""
//                                                })
//            }
//        }
//    }
}
