import QtQuick
import Felgo


Item {
    id: iExploreChoice
    anchors.fill: parent

    property int pListRooms
    property int pListImageRooms
    property var pRoomComponent
    property var pExploreComponent

    z: 2

    Repeater {
        model: pListRooms
        Loader {
            id: sceneLoader
            anchors.fill: parent

            sourceComponent: pRoomComponent

            Binding {
                target: sceneLoader.item
                property: "pPlace"
                value: Object.keys(mConstants.cRoomChoices)[index]
                when: sceneLoader.item !== null
            }

            Component.onCompleted: mConstants.cRooms[sceneLoader.item.pPlace] = sceneLoader.item
        }
    }

    Repeater {
        model: pListImageRooms
        Loader {
            id: sceneExploreLoader
            anchors.fill: parent

            sourceComponent: pExploreComponent

            Binding {
                target: sceneExploreLoader.item
                property: "pCode"
                value: Object.keys(mConstants.cExplorationChoices)[index]
                when: sceneExploreLoader.item !== null
            }

            Component.onCompleted: mConstants.cRooms[sceneExploreLoader.item.pCode] = sceneExploreLoader.item
        }
    }
    Component.onCompleted: {
        Qt.callLater( function() {
            pListImageRooms = Object.keys(mConstants.cExplorationChoices).length
            pListRooms = Object.keys(mConstants.cRoomChoices).length
        })
    }

    function getScene(lSceneCode) {
        if (lSceneCode === "HALL") {
            return mConstants.cRooms["HALL"]
        }
        return mConstants.cScenes[lSceneCode]
    }
}

