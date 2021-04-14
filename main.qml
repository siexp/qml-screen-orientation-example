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

    StackView {
        id: stack
        anchors.fill: parent
    }

    Component {
        id: green
        Rectangle {
            anchors.fill: parent

            color: "green"

            Component.onDestruction: console.log("dtr green")
        }
    }
    Component {
        id: blue
        Rectangle {
            anchors.fill: parent

            color: "blue"

            Component.onDestruction: console.log("dtr blue")
        }
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
        anchors.left: parent.left

        text: "landscape"
        font.pointSize: 32
        onClicked: {
            stack.pop()
            stack.push(green)
            AndroidInterface.landscape()
        }
    }
    Button {
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        text: "portrait"
        font.pointSize: 32
        onClicked: {
            stack.pop()
            stack.push(blue)
            AndroidInterface.portrait()
        }
    }
}
