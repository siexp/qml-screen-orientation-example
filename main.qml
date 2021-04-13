import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5

import com.github.siexp 1.0

Window {
    width: Screen.width
    height: Screen.height
    visibility: Window.FullScreen
    visible: true

    title: qsTr("Hello World")

    Rectangle {
        width: Screen.width / 2
        height: Screen.height / 2
        anchors.centerIn: parent

        color: "green"
    }

    Text {
        anchors.centerIn: parent

        font.pointSize: 32
        text: Screen.width + "x" + Screen.height
    }

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 32

        Binding on text {
            when: Screen.width > Screen.height
            value: "Landscape" + ":" + Screen.primaryOrientation
        }
        Binding on text {
            when: Screen.width < Screen.height
            value: "Portrait" + ":" + Screen.primaryOrientation
        }
        Connections{
            target: Screen
            Screen.onPrimaryOrientationChanged:{
                console.log("Primary Orientation Changed")
            }
        }
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        text: "Rotate"
        font.pointSize: 32
        onClicked: {
            Screen.primaryOrientation === Qt.PortraitOrientation ? AndroidInterface.landscape()
                                                                 : AndroidInterface.portrait()
        }
    }
}
