import QtQuick
import Felgo

import "../"
import "../BaseElements"
import "../OptiviaSexVideo"

BaseScene {
    id: iTheBodyCountBackground

    property string pCode: "NULL"
    property int pIndex: parseInt(pCode.substring(1))
    property string pGirlStatus: "JERK"
    mDefaultChoice: mConstants.cRooms["HALL"]

    mFunctionToCall: function() {
        mConstants.pSexSceneVisited[pIndex-1] = true
    }

    mBackGround: iOptiviaSexVideo
    OptiviaSexVideo {
        id: iOptiviaSexVideo
        personStatus: pGirlStatus
        pNotebookIndex: pIndex
        pAssetCode: iTheBodyCountBackground.pCode
    }

}
