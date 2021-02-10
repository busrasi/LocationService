import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.0


ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")


    Button{
        id:buttonLocationSettings
        width: parent.width/2
        height: 40
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
            color: "#61276F"
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
        height: 40
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
            color: "#61276F"
            radius: 5
        }
        onClicked: {
            if(locationService.active == false)
             locationService.gotoAndroidSettings();
        }
    }
}
