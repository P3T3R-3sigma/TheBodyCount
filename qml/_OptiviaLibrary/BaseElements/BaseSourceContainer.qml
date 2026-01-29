import Felgo
import QtQuick
import QtMultimedia


Item {
    id: baseSourceContainer

    property string pAssetCode: parent.pAssetCode
    property var pListSources: []
    property string pExtractFrom: "qrc:/image_assets.qrc"

    onPAssetCodeChanged: extractNames(pExtractFrom, pAssetCode, function(names){pListSources = names})

    function extractNames(folder, filter, callBack) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", folder);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var qrcContent = xhr.responseText;
                    callBack(shadowExtractNames(qrcContent, filter))
                } else {
                    console.log("Failed to load qrc file:", xhr.status);
                }
            }
        };
        xhr.send();
    }
    function shadowExtractNames(qrcFile, filter) {
        let names = []
        let split0 = qrcFile.split("<file>")
        let split1 = []
        let split2 = []
        for (let i in split0) {
            split1.push(...split0[i].split("</file>"))
        }
        for (let j in split1) {
            if (split1[j].includes(filter)) {
                names.push("qrc:/" + split1[j])
            }
        }
        return names
    }
}
