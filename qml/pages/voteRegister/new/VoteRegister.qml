import QtQuick
import QtQuick.Controls
import Felgo

//! [Style]
import "../../../helper/style"
import "../../../helper/tabBar"

//! [Component]
import "../../../helper/button"
import "../../../helper/header"
import "../../../helper/scrollbar"

//! [C++ Class]
import VOTE.ServiceUploadImage
import VOTE.ServiceVoteRegister
import VOTE.ServiceCheckVotingRegister

AppPage {
    id: voteRegisterPage
    useSafeArea: true // system.isPlatform(System.IOS)
    navigationBarHidden: true
    LayoutMirroring.enabled: Lang.isRTL
    LayoutMirroring.childrenInherit: Lang.isRTL

    //! [Property - Maintenance of data entered by the user]
    property variant arrPartys    : []
    property variant arrCondidates: []

    //! [Property - Determine which image to upload (party or condidate)]
    property int uploadImageType: -1 // VoteRegister.MyEnum.Party
    enum MyEnum {
        Party,
        Condidate
    }

    ServiceCheckVotingRegister {
        id: serviceCheckVotingRegister

        onSigWaitingPartyVoteRegister: (partyState, partyMessage) => {
                                           itemParty.state    = "waiting"
                                           stateParty.state   = partyState
                                           stateParty.message = partyMessage
                                       }
        onSigReadyPartyVoteRegister: {
            itemParty.state = "readyVoteRegister"
        }

        onSigWaitingCandidateVoteRegister: (condidateState, condidateMessage) => {
                                               itemCandidate.state    = "waiting"
                                               stateCondidate.state   = condidateState
                                               stateCondidate.message = condidateMessage
                                           }
        onSigReadyCandidateVoteRegister: {
            itemCandidate.state = "readyVoteRegister"
        }
    }

    ServiceUploadImage {
        id: serviceUploadImage
        onSigSuccessUploadPartyVoteImage: (imageId) => {
                                              itemParty.ptyPartyImageId = imageId
                                              serviceVoteRegister.requestPartyVoteRegister(itemParty.ptyPartyImageId)
                                          }
        onSigSuccessUploadCondidateVoteImage: (imageId) => {
                                                  itemCandidate.ptyCondidateImageId = imageId
                                                  serviceVoteRegister.requestCondidateVoteRegister(itemCandidate.ptyCondidateImageId)
                                              }
        onSigRejectUploadVoteImage: (message) => {
                                        toastMessage.state = "Error"
                                        toastMessage.title = qsTr("Error")
                                        toastMessage.message = message
                                        toastMessage.open()
                                    }

        classErrorHandling: ErrorHandling
        onSigHidLoading: loading.close()
    }

    ServiceVoteRegister {
        id: serviceVoteRegister

        // Party vote register
        onSigSuccessPartyVoteVerify: { itemParty.state = "readyUploadImage" }

        onSigSuccessPartyVoteRegister: {
            itemParty.state = "waiting"
            serviceCheckVotingRegister.requestCheckPartyVotingRegister()
        }
        onSigRejectPartyVoteRegister: {
            toastMessage.state = "Warning"
            toastMessage.title = qsTr("Warning")
            toastMessage.message = qsTr("Please insert all vote count")
            toastMessage.open()
        }

        // Condidate vote register
        onSigSuccessVerifyVoteRegister: { itemCandidate.state = "readyUploadImage" }

        onSigSuccessCondidateVoteRegister: {
            itemCandidate.state = "waiting"
            serviceCheckVotingRegister.requestCheckCandidateVotingRegister()
        }
        onSigRejectCondidateVoteRegister: {
            toastMessage.state = "Warning"
            toastMessage.title = qsTr("Warning")
            toastMessage.message = qsTr("Please insert all vote count")
            toastMessage.open()
        }

        classErrorHandling: ErrorHandling
        onSigHidLoading: loading.close()
    }

    VoteHeader {
        id: voteHeader
        ptyRegionCode: homePage.ptyRegionCode
        ptyFoundNumber: homePage.ptyFoundNumber
        z: 2
    }

    // TbBar [ total vote ~ leader board]
    ListModel {
        id: listModel
        ListElement { buttonName: qsTr("Party vote register") }
        ListElement { buttonName: qsTr("Candidate vote register") }
    }

    CustomTabBar {
        id: tabBar
        width: parent.width
        ptyModel: listModel
        ptyIndexChangeable: true
        anchors { top: voteHeader.bottom; topMargin: dp(6) }
        onPtyCurrentIndexChanged: {
            if(tabBar.ptyCurrentIndex === 0) {
                serviceCheckVotingRegister.requestCheckPartyVotingRegister()
                uploadImageType = VoteRegister.MyEnum.Party

                itemParty.visible = true
                itemCandidate.visible = false
            }
            else {
                serviceCheckVotingRegister.requestCheckCandidateVotingRegister()
                uploadImageType = VoteRegister.MyEnum.Condidate

                itemParty.visible = false
                itemCandidate.visible = true
            }
        }
    }

    Item {
        id: itemParty
        width: parent.width - dp(32)
        anchors { top: tabBar.bottom; topMargin: dp(16); bottom: buttonBack.top; bottomMargin: dp(16); horizontalCenter: parent.horizontalCenter }
        visible: false
        state: ""

        property int ptyPartyImageId: -1

        PartyVoteRegisterPage {
            id: partyVoteRegisterPage
            visible: itemParty.state === "readyVoteRegister"
        }

        UploadImagePartyVotePage {
            id: uploadImagePartyVotePage
            visible: itemParty.state === "readyUploadImage"
        }

        AppFlickable {
            id: flickablePartyVoteState
            width: parent.width - dp(32)
            anchors.fill: parent
            contentHeight: contentHeight
            topMargin: dp(4)
            visible: itemParty.state === "waiting" || itemParty.state === "accepted"

            PullToRefreshHandler {
                listView: flickablePartyVoteState
                onRefresh: {
                    serviceCheckVotingRegister.requestCheckPartyVotingRegister()
                }
            }

            VoteRegisterStatePage {
                id: stateParty
            }
        }
    }


    Item {
        id: itemCandidate
        width: parent.width - dp(32)
        anchors { top: tabBar.bottom; topMargin: dp(16); bottom: buttonBack.top; bottomMargin: dp(16); horizontalCenter: parent.horizontalCenter }
        visible: false
        state: ""

        property int ptyCondidateImageId: -1

        CondidateVoteRegisterPage {
            id: condidateVoteRegisterPage
            visible: itemCandidate.state === "readyVoteRegister"
        }

        UploadImageCondidatePage {
            id: uploadImageCondidatePage
            visible: itemCandidate.state === "readyUploadImage"
        }

        AppFlickable {
            id: flickableCandidateVoteState
            width: parent.width - dp(32)
            anchors.fill: parent
            contentHeight: contentHeight
            topMargin: dp(4)
            visible: itemCandidate.state === "waiting" || itemCandidate.state === "accepted"

            PullToRefreshHandler {
                listView: flickableCandidateVoteState
                onRefresh: {
                    serviceCheckVotingRegister.requestCheckCandidateVotingRegister()
                }
            }

            VoteRegisterStatePage {
                id: stateCondidate
            }
        }
    }

    CustomButton {
        id: buttonBack
        width: parent.width / 2 - dp(24)
        text: qsTr("Back")
        anchors { bottom: parent.bottom; bottomMargin: dp(16); left: parent.left; leftMargin: dp(16) }
        backgroundColor: Style.ptyTransparent
        textColor: Style.ptyColorOrangeDark
        borderColor: Style.ptyColorOrangeDark
        radius: dp(8)
        enabled: !(homePage.ptyRegionCode.length < 1 || homePage.ptyFoundNumber.length < 1)
        onClicked: {
            if(tabBar.ptyCurrentIndex === 0) {
                itemParty.state = "readyVoteRegister"
            }
            else if(tabBar.ptyCurrentIndex === 1){
                itemCandidate.state = "readyVoteRegister"
            }
        }
        visible: buttonNext.visible
    }

    CustomButton {
        id: buttonNext
        width: parent.width / 2 - dp(24)
        radius: dp(8)
        anchors { bottom: parent.bottom; bottomMargin: dp(16); right: parent.right; rightMargin: dp(16) }
        text: if(tabBar.ptyCurrentIndex === 0) {
                  if(itemParty.state === "readyVoteRegister")
                      return qsTr("Next")
                  else
                      return qsTr("Save")
              }
              else if(tabBar.ptyCurrentIndex === 1){
                  if(itemCandidate.state === "readyVoteRegister")
                      return qsTr("Next")
                  else
                      return qsTr("Save")
              }
        visible: {
            if(tabBar.ptyCurrentIndex === 0) {
                return !(itemParty.state === "waiting" || itemParty.state === "accepted")
            } else if(tabBar.ptyCurrentIndex === 1) {
                return !(itemCandidate.state === "waiting" || itemCandidate.state === "accepted")
            }
        }
        onClicked: {
            Qt.inputMethod.hide()

            if(tabBar.ptyCurrentIndex === 0) { // Party section
                if(itemParty.state === "readyVoteRegister") {
                    arrPartys = []
                    for (var i = 0; i < partyVoteRegisterPage.alyListView.count; i++) {
                        arrPartys.push([partyVoteRegisterPage.alyListView.itemAtIndex(i).children[1].text,
                                        partyVoteRegisterPage.alyListView.itemAtIndex(i).children[3].text])
                    }
                    serviceVoteRegister.requestPartyVoteVerify(arrPartys)
                }
                else if(itemParty.state === "readyUploadImage") {
                    loading.open()
                    serviceUploadImage.uploadVoteImage(uploadImagePartyVotePage.alyVoteImagePath, ServiceUploadImage.Party)
                }
            }
            else if(tabBar.ptyCurrentIndex === 1) // Candidate section
            {
                if(itemCandidate.state === "readyVoteRegister") {
                    arrCondidates = []
                    for (var j = 0; j < condidateVoteRegisterPage.alyListView.count; j++) {
                        arrCondidates.push([condidateVoteRegisterPage.alyListView.itemAtIndex(j).children[0].text,
                                            condidateVoteRegisterPage.alyListView.itemAtIndex(j).children[2].text])
                    }
                    serviceVoteRegister.requestCondidateVoteVerify(arrCondidates)
                }
                else if(itemCandidate.state === "readyUploadImage") {
                    loading.open()
                    serviceUploadImage.uploadVoteImage(uploadImageCondidatePage.alyVoteImagePath, ServiceUploadImage.Condidate)
                }
            }
        }
    }
}
