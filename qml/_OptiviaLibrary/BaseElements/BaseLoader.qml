import Felgo
import QtQuick
import QtMultimedia

import "BaseLoader.js" as LoaderJS

Item {
    id: baseLoader

    property string pAssetCode
    property var pLoadAsset: parent
    property var pListSources: []
    property string pExtractFrom: "qrc:/image_assets.qrc"
    property int pLoadNum: 0
    property int pExtractNum: 0

    Component.onCompleted: {
        if (pExtractFrom === "qrc:/video_assets.qrc") {
            return
        } else {
            pAssetCode = parent.pAssetCode
        }
    }

    onPListSourcesChanged: {
        if (pListSources.length === 0) {
            return
        }

        pLoadNum++
        // console.log("HERE 5: ", pListSources)
        if (pListSources.length === 1) {
            pLoadAsset.source = "qrc:/" + pListSources[0]
        } else {
            setSource("Static")
        }
    }

    onPAssetCodeChanged: { extractNames(pExtractFrom, pAssetCode, function(names){pListSources = names;})}


    function extractNames(folder, filter, callBack) {
        pExtractNum++
        var xhr = new XMLHttpRequest();
        xhr.open("GET", folder);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var qrcContent = xhr.responseText;
                    callBack(LoaderJS.shadowExtractNames(qrcContent, filter))
                } else {
                    console.log("Failed to load qrc file:", xhr.status);
                }
            }
        };
        xhr.send();
    }

    function setSource(lStatus = "") {
        if (!pAssetCode) {
            pAssetCode = parent.pAssetCode
        } else if (lStatus === "") {
            return
        }

        for (let i in pListSources) {
            if (pListSources[i].toString().includes(lStatus)) {
                pLoadAsset.source = "qrc:/" + pListSources[i]
                return
            }
            if (pListSources[i].toString().includes(lStatus.toUpperCase())) {
                pLoadAsset.source = "qrc:/" + pListSources[i]
                return
            }
        }
        pLoadAsset.source = ""
        return
    }
}
