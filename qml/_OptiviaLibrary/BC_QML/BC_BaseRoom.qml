import QtQuick
import Felgo

import "../BaseElements"

BaseRoom {
    id: iExploreChoice
    anchors.fill: parent

    pComponentBackgroundVideo: iCSG_BackgroundVideoComponent
    pComponentSexVideo: iCSG_SexVideoComponent

    Component {
        id: iCSG_SexVideoComponent
        BC_SexVideo { }
    }

    Component {
        id: iCSG_BackgroundVideoComponent
        BC_BackgroundVideo { }
    }

    function resetText() {
        if (pPlace === "DOG_ROOM") {
            mConstants.cTextBeforeChoice["C25"] = mTextConstants.cTextSceneC25
            mConstants.cTextBeforeChoice["C28"] = mTextConstants.cTextSceneC28
            mConstants.cTextBeforeChoice["C31"] = mTextConstants.cTextSceneC31
        }
    }
}

