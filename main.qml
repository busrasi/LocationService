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

    property var appState: Qt.application.state



    onAppStateChanged:{
        gpsStateChecker()
    }

    background: Rectangle{
        anchors.fill: parent
        color: "#C3C3D1"

    }

    onActiveChanged: {
        console.log("BSR: onActiveChanged", active)
        if( appState === Qt.application.active){
            getStateChecker()
            console.log("BSR: onActiveChanged", active)
        }
    }

    property alias pSrc: src
    property var myError

    // onFocusObjectChanged: locationPopup.close()
    PositionSource {
        id: src
        updateInterval: 100
        active: true

        onSourceErrorChanged:{
            myError = sourceError;
        }
        onActiveChanged: console.log("BSR: CURRENT Active",src.active)

        Component.onCompleted: {
            src.start()
            src.update()
            var supPos  = "Unknown"
            if (src.supportedPositioningMethods == PositionSource.NoPositioningMethods) {
                supPos = "NoPositioningMethods"
            } else if (src.supportedPositioningMethods == PositionSource.AllPositioningMethods) {
                supPos = "AllPositioningMethods"
            } else if (src.supportedPositioningMethods == PositionSource.SatellitePositioningMethods) {
                supPos = "SatellitePositioningMethods"
            } else if (src.supportedPositioningMethods == PositionSource.NonSatellitePositioningMethods) {
                supPos = "NonSatellitePositioningMethods"
            }

            console.log("Position Source Loaded || Supported: "+supPos+" Valid: "+valid);
        }

        onPositionChanged: {
            var coord = src.position.coordinate;
            console.log("Coordinate:", coord.latitude, coord.longitude);
        }
    }

    Connections{
        target: src
        function onValidChanged(){
            console.log("BSR: CURRENT VALID",src.valid)
        }
    }

    function gpsStateChecker() {
        console.log("BSR:: SOURCE ERROR","PositionSource.NoError")
       // src.stop()
       // src.start()
        if(myError === PositionSource.ClosedError ){

            if(src.supportedPositioningMethods === PositionSource.NoPositioningMethods){
                locationPopup.open()
                console.log("BSR:: Closed ERROR","PositionSource.ClosedError")
            }
            else {
                locationPopup.close()
                console.log("BSR:: Closed ERROR active true","PositionSource.ClosedError")
            }
        }

        else if(myError === PositionSource.NoError){
            locationPopup.close()
            console.log("BSR:: No ERROR","PositionSource.NoError")
        }
        else if(myError === PositionSource.AccessError){
            locationPopup.open()
            console.log("BSR:: AccessERROR","PositionSource.AccessError")
        }
        else if(myError === PositionSource.UnknownSourceError){
            //locationPopup.open()
            if(src.supportedPositioningMethods === PositionSource.NoPositioningMethods){
                locationPopup.open()
                console.log("BSR:: UnknownSourceError noposition","PositionSource.UnknownSourceError")
            }
            else {
                locationPopup.close()
                console.log("BSR:: UnknownSourceError","PositionSource.UnknownSourceError")
            }
            console.log("BSR:: UnknownSourceError","PositionSource.UnknownSourceError")
        }
        else if(myError === PositionSource.SocketError){
            locationPopup.open()
            console.log("BSR:: SocketError","PositionSource.SocketError")
        }
        else {
            // locationPopup.close()
            console.log("BSR:: ERROR else")
        }
    }
    Popup{
        id:locationPopup
        width: 300
        height: 300
        anchors.centerIn: parent

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
                locationPopup.close()
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
    Component.onCompleted: {
        locationPopup.close()
    }
}
