import QtQuick
import Felgo
import QtMultimedia
import QtQuick.Window
import Qt5Compat.GraphicalEffects

import "../BaseElements"

Item {
    id: iOptiviaSexVideoThumbnail

    property var pListThumbnailSources: []

    BaseImage {
        id: thumbnail
        pAssetCode: "thumbnail" + pCode
    }

    function setThumbnaiImage(pos) {
        if (pos !== -1) {
            thumbnail.setSource((Math.floor(pos/5000)+1).toString())
        } else {
            thumbnail.setSource("NULL")
        }
    }
}
