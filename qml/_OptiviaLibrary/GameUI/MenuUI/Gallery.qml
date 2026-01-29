import Felgo
import QtQuick


Item {
    id: iGallery

    anchors.fill: parent
    anchors.horizontalCenter: parent.horizontalCenter

    visible: false

    GalleryImage {
        id: galleryS01
        pAssetCode: "UI71"
        pGirlStatus: mConstants.meridaStatus
        pVideoToStart: mConstants.cScenes["S01"]
        pGirlName: qsTr("Merida")
        pUnlocked: mConstants.pSexSceneVisited[0]

        x: 533
        y: 277
    }
    GalleryImage {
        id: galleryS02
        pAssetCode: "UI72"
        pGirlStatus: mConstants.meridaStatus
        pVideoToStart: mConstants.cScenes["S02"]
        pGirlName: qsTr("Merida")
        pUnlocked: mConstants.pSexSceneVisited[1]

        x: 1069
        y: 277
    }
    GalleryImage {
        id: galleryS03
        pAssetCode: "UI73"
        pGirlStatus: "SNIPER"
        pVideoToStart: mConstants.cScenes["S03"]
        pGirlName: qsTr("Leya")
        pUnlocked: mConstants.pSexSceneVisited[2]

        x: 801
        y: 540
    }
    GalleryImage {
        id: galleryS04
        pAssetCode: "UI74"
        pGirlStatus: mConstants.amberStatus
        pVideoToStart: mConstants.cScenes["S04"]
        pGirlName: qsTr("Amber")
        pUnlocked: mConstants.pSexSceneVisited[3]

        x: 334
        y: 540
    }
    GalleryImage {
        id: galleryS05
        pAssetCode: "UI75"
        pGirlStatus: mConstants.lollypopStatus
        pVideoToStart: mConstants.cScenes["S05"]
        pGirlName: qsTr("Lollypop")
        pUnlocked: mConstants.pSexSceneVisited[4]

        x: 533
        y: 802
    }
    GalleryImage {
        id: galleryS06
        pAssetCode: "UI76"
        pGirlStatus: mConstants.lollypopStatus
        pVideoToStart: mConstants.cScenes["S06"]
        pGirlName: qsTr("Lollypop")
        pUnlocked: mConstants.pSexSceneVisited[5]

        x: 1069
        y: 802
    }
    GalleryImage {
        id: galleryS07
        pAssetCode: "UI77"
        pGirlStatus: mConstants.milenaStatus
        pVideoToStart: mConstants.cScenes["S07"]
        pGirlName: qsTr("Milena")
        pUnlocked: mConstants.pSexSceneVisited[6]

        x: 1267
        y: 540
    }
}
