#include "QMLRegister.h"

#include "../util/error/ClassErrorHandling.h"
#include "../util/storage/language/Language.h"
#include "../util/storage/authentication/Token.h"

#include "../model/da/NetworkHandler.h"
#include "../model/api/fund/ServiceFund.h"
#include "../model/api/party/ServiceParty.h"
#include "../model/api/signIn/ServiceSignIn.h"
#include "../model/api/vote/ServiceVoteRegister.h"
#include "../model/api/condidate/ServiceCandidate.h"
#include "../model/api/voteResult/ServiceVoteResult.h"
#include "../model/api/uploadImage/ServiceUploadImage.h"
#include "../model/api/vote/ServiceCheckVotingRegister.h"
#include "../model/api/userManagement/ServiceUserManagement.h"


QMLRegister::QMLRegister(QQmlEngine *engine)
{
    _engine = engine;

    // Utility
    qmlRegisterSingletonType<VOTE::Util::Language>("VOTE.Language", 1, 0, "Language",&VOTE::Util::Language::getInstance);
    qmlRegisterSingletonType<VOTE::Util::Token>("VOTE.Token", 1, 0, "Token",&VOTE::Util::Token::getInstanceToken);

    // DB access
    //qmlRegisterType<DataExist> ("VOTE.DataExist", 1, 0, "DataExist");
    //qmlRegisterSingletonType<PartyTbl>("VOTE.PartyTbl", 1, 0, "PartyTbl",&PartyTbl::getInstanceParty);
    //qmlRegisterSingletonType<CandidateTbl>("VOTE.CandidateTbl", 1, 0, "CandidateTbl",&CandidateTbl::getInstanceCandidate);

    // Api
    qmlRegisterType<ServiceSignIn> ("VOTE.ServiceSignIn", 1, 0, "ServiceSignIn");
    qmlRegisterType<ServiceUploadImage> ("VOTE.ServiceUploadImage", 1, 0, "ServiceUploadImage");
    qmlRegisterType<ServiceUserManagement> ("VOTE.ServiceUserManagement", 1, 0, "ServiceUserManagement");
    qmlRegisterType<ServiceVoteResult> ("VOTE.ServiceVoteResult", 1, 0, "ServiceVoteResult");
    qmlRegisterType<ServiceFund> ("VOTE.ServiceFund", 1, 0, "ServiceFund");
    qmlRegisterType<ServiceParty> ("VOTE.ServiceParty", 1, 0, "ServiceParty");
    qmlRegisterType<ServiceCandidate> ("VOTE.ServiceCandidate", 1, 0, "ServiceCandidate");
    qmlRegisterType<ServiceVoteRegister> ("VOTE.ServiceVoteRegister", 1, 0, "ServiceVoteRegister");
    qmlRegisterType<ServiceCheckVotingRegister> ("VOTE.ServiceCheckVotingRegister", 1, 0, "ServiceCheckVotingRegister");

    // Network
    NetworkHandler networkHandler;
    _engine->rootContext()->setContextProperty("NetworkHandler", &networkHandler);

    // Error handling
    VOTE::Util::ClassErrorHandling* classErrorHandling = new VOTE::Util::ClassErrorHandling();
    _engine->rootContext()->setContextProperty("ErrorHandling", classErrorHandling);
}
