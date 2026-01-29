import QtQuick
import Felgo

import "../BaseElements"

BaseGame {
    id: iExploreChoice
    anchors.fill: parent

    pRoomComponent: iCSG_RoomComponent
    pExploreComponent: iCSG_ImageComponent

    Component {
        id: iCSG_RoomComponent
        BC_BaseRoom { }
    }
    Component {
        id: iCSG_ImageComponent
        BC_BackgroundImage { }
    }

    function changeHall11() {
        mConstants.cTextBeforeChoice["C11"] = mTextConstants.cTextSceneC11r
    }
    function changeHall12() {
        mConstants.cTextBeforeChoice["C12"] = mTextConstants.cTextSceneC12r
    }
    function setLaughText() {
        mConstants.cTextBeforeChoice["C25"] = mTextConstants.cTextSceneC25l
        mConstants.cTextBeforeChoice["C28"] = mTextConstants.cTextSceneC28l
        mConstants.cTextBeforeChoice["C31"] = mTextConstants.cTextSceneC31r
    }
    function changeHall32() {
        mConstants.cTextBeforeChoice["C32"] = mTextConstants.cTextSceneC32r
    }
}

