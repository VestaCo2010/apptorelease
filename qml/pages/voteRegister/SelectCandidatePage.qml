import QtQuick
import Felgo

////! [Style]
//import "../../helper/style"

////! [Component]
//import "../../helper/button"
//import "../../helper/header"
//import "../../helper/listview"
//import "../../helper/textInput"

////! [C++ Class]
//import VOTE.DataExist
//import VOTE.CandidateTbl

AppPage {
//    useSafeArea: system.isPlatform(System.IOS)
//    navigationBarHidden: true
//    LayoutMirroring.enabled: Lang.isRTL
//    LayoutMirroring.childrenInherit: Lang.isRTL

//    onAppeared: {
//        loading.open()
//        dataExist.checkCandidateTbl()
//    }

//    DataExist {
//        id: dataExist

//        onSigExistCandidateTbl: {
//            loading.close()
//            CandidateTbl.getFromDb("")
//        }
//        onSigNotExistCandidateTbl: {
//            CandidateTbl.requestCandidate()
//        }
//    }

//    Connections {
//        target: CandidateTbl
//        onSigSuccessGetCandidate: { }
//        onSigRejectGetCandidate: (message) => {
//                                     toastMessage.state = "Warning"
//                                     toastMessage.title = qsTr("Warning")
//                                     toastMessage.message = message
//                                     toastMessage.open()
//                                 }
//        onSigHidLoading: {
//            loading.close()
//        }
//    }

//    TitleHeader {
//        id: txtTitle
//        topPadding: dp(40)
//        text: qsTr("Insert candidate code or name")
//    }

//    CustomSearchInput {
//        id: searchBar
//        anchors { top: txtTitle.bottom; topMargin: dp(12); horizontalCenter: parent.horizontalCenter }
//        onTextChanged: CandidateTbl.getFromDb(searchBar.text)
//    }

//    AppListView {
//        id: listView
//        width: parent.width - dp(32)
//        backgroundColor: Style.ptyColorWhite
//        anchors {
//            top: searchBar.bottom
//            topMargin: dp(16)
//            bottom: buttonEnterVote.top
//            bottomMargin: dp(12)
//            horizontalCenter: parent.horizontalCenter
//        }
//        visible: count
//        spacing: dp(8)
//        model: CandidateTbl.modelCandidateTbl
//        delegate: Rectangle {
//            width: listView.width
//            height: dp(48)
//            color: mouseArea.containsPress ? Qt.darker(Style.ptyColorGray20, 1.03) : Style.ptyColorGray20
//            radius: dp(8)

//            AppText {
//                id: appText
//                text: Lang.isRTL ? candidateNameKu + " " + candidateFamilyKu  : candidateNameEn + " " + candidateFamilyEn
//                width: parent.width
//                anchors { verticalCenter: parent.verticalCenter }
//                leftPadding: dp(12)
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
//                                                    "ptyCandidateId": candidateId,
//                                                    "ptyCandidateNameFamily": appText.text,
//                                                    "ptyImagePath": ""
//                                                })
//            }
//        }
//    }

//    CustomButton {
//        id: buttonEnterVote
//        width: dp(160)
//        height: dp(30)
//        text: qsTr("Enter vote manually")
//        anchors { bottom: parent.bottom; bottomMargin: dp(15); horizontalCenter: parent.horizontalCenter }
//        backgroundColor: Style.ptyTransparent
//        borderColor: Style.ptyTransparent
//        textColor: Style.ptyColorOrangeDark
//        onClicked: navigationStack.push(Qt.resolvedUrl("SelectPartyPage.qml"))
//    }
}
