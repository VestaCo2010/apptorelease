import QtQuick
import Felgo

//! [Style]
import "../../helper/style"
import "../../helper/tabBar"

//! [Component]
import "../../helper/progressbar"

//! [C++ Class]
import VOTE.ServiceVoteResult

AppPage {
    id: resultPage
    useSafeArea: true
    navigationBarHidden: true
    LayoutMirroring.enabled: Lang.isRTL
    LayoutMirroring.childrenInherit: Lang.isRTL
    onAppeared: {
        loading.open()
        serviceVoteResult.requestGetVotePartyResult()
    }

    property int ptyTotalVote  : 0
    property int ptyTotalFund  : 0
    property int ptyFundPercent: 0

    ServiceVoteResult {
        id: serviceVoteResult

        onSigSuccessGetTotalResult: (totalVote, totalFund, countFund, percentFund) => {
                                        ptyTotalVote = totalVote
                                        ptyTotalFund = totalFund
                                        ptyFundPercent = percentFund
                                    }

        onSigRejectGetTotalResult: (message) => {
                                       // toastMessage.state = "Error"
                                       // toastMessage.title = qsTr("Error")
                                       // toastMessage.message = message
                                       // toastMessage.open()
                                   }

        onSigSuccessGetVotePartyResult: {
            serviceVoteResult.requestGetTotalResult()
        }
        onSigRejectGetVotePartyResult: (message) => {
                                           //  toastMessage.state = "Error"
                                           //  toastMessage.title = qsTr("Error")
                                           //  toastMessage.message = message
                                           //  toastMessage.open()
                                       }

        onSigSuccessGetVoteCondidateResult: {
            serviceVoteResult.requestGetTotalResult()
        }
        onSigRejectGetVoteCondidateResult: (message) => {
                                               // toastMessage.state = "Error"
                                               // toastMessage.title = qsTr("Error")
                                               // toastMessage.message = message
                                               // toastMessage.open()
                                           }

        classErrorHandling: ErrorHandling
        onSigHidLoading: loading.close()
    }

    // Header title result
    Rectangle {
        id: recTotalResult
        width: parent.width - dp(32)
        height: dp(76)
        anchors { left: parent.left; leftMargin: dp(16); top: parent.top; topMargin: /*NativeUtils.safeAreaInsets.top*/ + dp(16) }
        color: Style.ptyColorGray20
        radius: dp(8)

        AppText {
            id: txtTitleTotalVote
            text: qsTr("Total vote")
            width: parent.width
            color: Style.ptyColorBlack
            leftPadding: dp(16)
            rightPadding: dp(16)
            horizontalAlignment: AppText.AlignLeft
            anchors { top: parent.top; topMargin: dp(12) }
            font { family: Style.fontProductSansRegular; pixelSize: sp(14); weight: 500 }
        }

        AppText {
            id: txtTotalVote
            text: ptyTotalVote
            width: parent.width
            color: Style.ptyColorBlack
            leftPadding: dp(16)
            rightPadding: dp(16)
            horizontalAlignment: AppText.AlignLeft
            anchors { bottom: parent.bottom; bottomMargin: dp(14) }
            font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(22); weight: 500 }
        }


        AppText {
            id: txtTitleTotalFund
            text: qsTr("Total ballot box")
            width: contentWidth
            color: Style.ptyColorBlack
            horizontalAlignment: AppText.AlignLeft
            anchors { top: parent.top; topMargin: dp(12); left: parent.left; leftMargin: recTotalResult.width / 2 }
            font { family: Style.fontProductSansRegular; pixelSize: sp(14); weight: 500 }
        }

        AppText {
            id: txtTotalFund
            text: ptyTotalFund
            width: contentWidth
            color: Style.ptyColorBlack
            horizontalAlignment: AppText.AlignLeft
            anchors { bottom: parent.bottom; bottomMargin: dp(14); left: parent.left; leftMargin: recTotalResult.width / 2 }
            font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(22); weight: 500 }
        }

        AppText {
            id: txtFundPercent
            text: ptyFundPercent + "% counted"
            height: txtTotalFund.height
            color: Style.ptyColorBlack
            horizontalAlignment: AppText.AlignLeft
            verticalAlignment: AppText.AlignVCenter
            anchors { bottom: txtTotalFund.bottom; left: txtTotalFund.right; leftMargin: dp(12) }
            font { family: Style.fontProductSansRegular; pixelSize: sp(12); weight: 500 }
        }
    }

    // TbBar [ total vote ~ leader board]
    ListModel {
        id: listModel1
        ListElement { buttonName: qsTr("Total votes") }
        ListElement { buttonName: qsTr("Leader board") }
    }

    CustomTabBar {
        id: tabBar
        width: parent.width
        ptyModel: listModel1
        ptyIndexChangeable: true
        anchors { top: recTotalResult.bottom; topMargin: dp(6) }
        onSignalClicked: (indx) => {
                             if(indx === 0) {
                                 serviceVoteResult.requestGetVotePartyResult()

                                 recBackgroundListTotalVote.visible = true
                                 recBackgroundListLeaderBoard.visible = false
                             }
                             else {
                                 serviceVoteResult.requestGetVoteCondidateResult()

                                 recBackgroundListTotalVote.visible = false
                                 recBackgroundListLeaderBoard.visible = true
                             }
                         }
    }


    // Tab total vote
    Rectangle {
        id: recBackgroundListTotalVote
        width: parent.width - dp(32)
        height: dp(80)
        anchors {
            top: tabBar.bottom
            topMargin: dp(16)
            bottom: parent.bottom
            bottomMargin: dp(16)
            left: parent.left
            leftMargin: dp(16)
            right: parent.right
            rightMargin: dp(16)
        }
        color: Style.ptyColorGray20
        radius: dp(8)

        Item {
            height: dp(30)
            anchors {
                top: parent.top
                topMargin: dp(18)
                left: parent.left
                leftMargin: dp(16)
                right: parent.right
                rightMargin: dp(16)
            }

            AppText {
                id: txtTitleCondidateName
                text: qsTr("Party name")
                width: dp(100)
                horizontalAlignment: AppText.AlignLeft
                anchors { left: parent.left }
                font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
                color: Style.ptyColorBlack
            }

            AppText {
                id: txtTitleProgressbar
                text: qsTr("Result")
                anchors {
                    left: txtTitleCondidateName.right
                    leftMargin: dp(5)
                    right: txtTitleVoteCount.left
                    rightMargin: dp(5)
                }
                horizontalAlignment: AppText.AlignLeft
                font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
                color: Style.ptyColorBlack
            }

            AppText {
                id: txtTitleVoteCount
                text: qsTr("Votes")
                width: dp(50)
                horizontalAlignment: AppText.AlignLeft
                anchors { right: parent.right }
                font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
                color: Style.ptyColorBlack
            }
        }

        Rectangle {
            id: recLine
            width: parent.width - dp(24)
            height: dp(1)
            anchors {
                left: parent.left
                leftMargin: dp(12)
                top: parent.top
                topMargin: dp(50)
            }
            color: Style.ptyColorGray40
        }

        AppListView {
            id: listViewTotalVote
            width: parent.width - dp(24)
            backgroundColor: Style.ptyColorGray20
            header: Item { height: dp(10); width: listViewTotalVote.width }
            anchors {
                top: recLine.bottom
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: dp(12)

            PullToRefreshHandler {
                listView: listViewTotalVote
                onRefresh: serviceVoteResult.requestGetVotePartyResult()
            }

            model: serviceVoteResult.modelVotePartyResult
            delegate: Item {
                width: listViewTotalVote.width
                height: dp(15)

                Text {
                    id: txtPartyName
                    text: Lang.isRTL ? partyNameKu : partyNameEn
                    width: dp(100)
                    horizontalAlignment: AppText.AlignLeft
                    anchors { left: parent.left }
                    font { family: Style.fontProductSansRegular; bold: false; pixelSize: sp(12) }
                    color: Style.ptyColorBlack
                    elide: Text.ElideRight
                }

                VoteProgressbar {
                    id: txtProgressbar
                    value: votePercent
                    anchors {
                        left: txtPartyName.right
                        leftMargin: dp(5)
                        right: txtVotePercent.left
                        rightMargin: dp(5)
                        verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    id: txtVotePercent
                    text: "%" + votePercent.toFixed(0)
                    width: dp(35)
                    horizontalAlignment: AppText.AlignLeft
                    anchors { right: txtVoteCount.left; rightMargin: dp(5) }
                    font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(11) }
                    color: Style.ptyColorBlack
                }

                Text {
                    id: txtVoteCount
                    text: voteCount
                    width: dp(60)
                    horizontalAlignment: AppText.AlignLeft
                    anchors { right: parent.right }
                    font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(11) }
                    color: Style.ptyColorBlack
                }
            }
        }
    }

    // Tab leader board
    Rectangle {
        id: recBackgroundListLeaderBoard
        width: parent.width - dp(32)
        height: dp(80)
        anchors {
            top: tabBar.bottom
            topMargin: dp(16)
            bottom: parent.bottom
            bottomMargin: dp(16)
            left: parent.left
            leftMargin: dp(16)
            right: parent.right
            rightMargin: dp(16)
        }
        color: Style.ptyColorGray20
        radius: dp(8)
        visible: false

        Item {
            height: dp(30)
            anchors {
                top: parent.top
                topMargin: dp(18)
                left: parent.left
                leftMargin: dp(16)
                right: parent.right
                rightMargin: dp(16)
            }

            AppText {
                id: txtTitlePartyName
                text: qsTr("Candidate name")
                width: dp(100)
                horizontalAlignment: AppText.AlignLeft
                anchors { left: parent.left }
                font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
                color: Style.ptyColorBlack
            }

            AppText {
                id: txtTitleProgressbarCondidate
                text: qsTr("Result")
                anchors {
                    left: txtTitlePartyName.right
                    leftMargin: dp(5)
                    right: txtTitleCondidateCount.left
                    rightMargin: dp(5)
                }
                horizontalAlignment: AppText.AlignLeft
                font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
                color: Style.ptyColorBlack
            }

            AppText {
                id: txtTitleCondidateCount
                text: qsTr("Votes")
                width: dp(50)
                horizontalAlignment: AppText.AlignLeft
                anchors { right: parent.right }
                font { family: Style.fontProductSansRegular; pixelSize: sp(13) }
                color: Style.ptyColorBlack
            }
        }

        Rectangle {
            id: recLine2
            width: parent.width - dp(24)
            height: dp(1)
            anchors {
                left: parent.left
                leftMargin: dp(12)
                top: parent.top
                topMargin: dp(50)
            }
            color: Style.ptyColorGray40
        }

        AppListView {
            id: listViewCondidateVote
            width: parent.width - dp(24)
            backgroundColor: Style.ptyColorGray20
            header: Item { height: dp(10); width: listViewCondidateVote.width }
            anchors {
                top: recLine2.bottom
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: dp(12)

            PullToRefreshHandler {
                listView: listViewCondidateVote
                onRefresh: serviceVoteResult.requestGetVoteCondidateResult()
            }

            model: serviceVoteResult.modelVoteCondidateResult
            delegate: Item {
                width: listViewCondidateVote.width
                height: dp(15)

                Text {
                    id: txtCondidateName
                    text: Lang.isRTL ? candidateFamilyKu + " " + candidateNameKu : candidateFamilyEn + " " + candidateNameEn
                    width: dp(100)
                    horizontalAlignment: AppText.AlignLeft
                    anchors { left: parent.left }
                    font { family: Style.fontProductSansRegular; bold: false; pixelSize: sp(12) }
                    color: Style.ptyColorBlack
                    elide: Text.ElideRight
                }

                VoteProgressbar {
                    id: txtProgressbar2
                    value: votePercent
                    anchors {
                        left: txtCondidateName.right
                        leftMargin: dp(5)
                        right: txtCondidatePercent.left
                        rightMargin: dp(5)
                        verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    id: txtCondidatePercent
                    text: "%" + votePercent.toFixed(0)
                    width: dp(35)
                    horizontalAlignment: AppText.AlignLeft
                    anchors { right: txtCondidateCount.left; rightMargin: dp(5) }
                    font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(11) }
                    color: Style.ptyColorBlack
                }

                Text {
                    id: txtCondidateCount
                    text: voteCount
                    width: dp(60)
                    horizontalAlignment: AppText.AlignLeft
                    anchors { right: parent.right }
                    font { family: Style.fontProductSansRegular; bold: true; pixelSize: sp(11) }
                    color: Style.ptyColorBlack
                }
            }
        }
    }
}
