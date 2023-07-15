pragma Singleton
import QtQuick
import Felgo

//! [C++ Class]
import VOTE.Language

Item {

    // Language Property for now
    property string ptyLanguage: "en" // ["en", "ku"]
    property bool   isRTL      : false

    function getLanguage(){
        Language.getLanguage()
    }

    Connections {
        target: Language
        onSigGetLanguage: (lang) => {
            ptyLanguage = lang
            isRTL = !(lang === "en")
            translate.selectLanguage(lang);
        }
    }
}
