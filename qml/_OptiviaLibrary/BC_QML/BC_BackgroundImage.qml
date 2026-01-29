import QtQuick
import Felgo

import "../BaseElements"
import "../"

BaseScene {
    id: iTheBodyCountBackground

    mBackGround: iBackground
    BaseImage { id: iBackground; pAssetCode: pCode; width: 1920; height: 1080}

    mChoice: iChoice
    BaseExploreChoice { id: iChoice; pPlace: pCode }
}
