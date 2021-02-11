import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.0
import QtPositioning 5.15


ApplicationWindow {
    id:root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    background: Rectangle{
        anchors.fill: parent
        color: "#C3C3D1"
    }
     Loader { id: loader }
    property alias pSrc: src
    onFocusObjectChanged: locationPopup.close()
    PositionSource {
        id: src
        updateInterval: 100
        active: true

        onValidChanged: {
            console.log("BSR: CURRENT VALID",src.valid)
        }
        onActiveChanged: console.log("BSR: CURRENT Active",src.active)

        Component.onCompleted: {
            src.start()
            src.update()
            var supPos  = "Unknown"
            if (src.supportedPositioningMethods == PositionSource.NoPositioningMethods) {
                supPos = "NoPositioningMethods"
                locationPopup.open()
                src.start()
                // locationService.gotoAndroidLocationSettings()
            } else if (src.supportedPositioningMethods == PositionSource.AllPositioningMethods) {
                supPos = "AllPositioningMethods"
                locationPopup.close()
            } else if (src.supportedPositioningMethods == PositionSource.SatellitePositioningMethods) {
                supPos = "SatellitePositioningMethods"
                locationPopup.close()
            } else if (src.supportedPositioningMethods == PositionSource.NonSatellitePositioningMethods) {
                supPos = "NonSatellitePositioningMethods"
                locationPopup.close()
            }

            console.log("Position Source Loaded || Supported: "+supPos+" Valid: "+valid);
        }

        onPositionChanged: {
            var coord = src.position.coordinate;
            console.log("Coordinate:", coord.latitude, coord.longitude);
        }
    }
    Popup{
        id:locationPopup
        width: 300
        height: 300
        anchors.centerIn: parent
        closePolicy: Popup.CloseOnPressOutsideParent

        Button{
            id:buttonLocationSettings1
            width: parent.width-32
            height: 60
            anchors.centerIn: parent
            Text {
                id: buttonText
                text: qsTr("Open Location Settings")
                color: "white"
                font.family: "Comic Sans"
                anchors.centerIn: parent
            }
            background: Rectangle{
                anchors.fill: parent
                color: "#E3C9DB"
                radius: 5
            }
            onClicked: {
                if(locationService.active == false)
                    locationService.gotoAndroidLocationSettings();

            }
            Component.onCompleted: {
                if(pSrc.active === true){
                    locationPopup.close()
                }
                if(pSrc.active === false){
                    locationPopup.open()
                }
            }
        }
        Button{
            id:close
            width: 30
            height: 30
            anchors.top: parent.top
            anchors.right: parent.right
            onClicked: locationPopup.close()
            Text {
                id: closeText
                text: qsTr("X")
                color: "black"
                anchors.centerIn: parent
            }
        }
    }

    Button{
        id:buttonLocationSettings
        width: parent.width/2
        height: 60
        anchors.centerIn: parent
        Text {
            id: buttonText2
            text: qsTr("Open Location Settings")
            color: "white"
            font.family: "Comic Sans"
            anchors.centerIn: parent
        }
        background: Rectangle{
            anchors.fill: parent
            color: "#E3C9DB"
            radius: 5
        }
        onClicked: {
            if(locationService.active == false)
                locationService.gotoAndroidLocationSettings();
        }
    }
    Button{
        id: buttonSettings
        width: parent.width/2
        height: 60
        anchors.top:buttonLocationSettings.bottom
        anchors.topMargin: 16
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            id: buttonText1
            text: qsTr("Open Settings")
            color: "white"
            font.family: "Comic Sans"
            anchors.centerIn: parent
        }
        background: Rectangle{
            anchors.fill: parent
            color: "#E3C9DB"
            radius: 5
        }
        onClicked: {
            if(locationService.active == false)
                locationService.gotoAndroidSettings();
        }
    }
}
