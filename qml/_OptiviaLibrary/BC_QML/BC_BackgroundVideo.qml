import QtQuick
import Felgo

import "../BaseElements"
import "../Choice"

BaseScene {
    id: iTheBodyCountBackground

    mDefaultChoice: mConstants.cRooms["HALL"]
    property int pMillisBeforeEnd: 600
    property var pCorrectChoices: [mListChoices[0]]

    mBackGround: iBackground
    BaseVideo {
        id: iBackground
        pAssetCode: pCode
        pMillisecBeforeEnd: pMillisBeforeEnd
    }
    mChoice: mListChoices.length === 0 ? null :iChoice
    BC_Choice { id: iChoice; mCorrectChoice: pCorrectChoices }
}
