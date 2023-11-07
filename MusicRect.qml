import QtQuick
import QtQuick.Controls

Rectangle{
    property string music_path: ""
    property int midx: 0
    signal dbclicked()
    id:root
    height: 50
    focus: true
    border.color:Qt.rgba(150,150,150,0.1)
    radius: 8
    color: Qt.rgba(0,0,0,0)


    state:"out"

    states: [
        State {
            name: "out"
        },
        State {
            name: "in"
        }
    ]

    transitions: [
        Transition {
            from: "out"
            to: "in"
            ParallelAnimation{
                NumberAnimation{
                    target: a1
                    property: "opacity"
                    from: 0.5
                    to:0.9
                    duration: 300
                }
                NumberAnimation{
                    target: a2
                    property: "opacity"
                    from: 0.5
                    to:0.9
                    duration: 300
                }
                PropertyAnimation{
                    target: root
                    property: "border.color"
                    from: Qt.rgba(150,150,150,0.1)
                    to:Qt.rgba(150,150,150,0.9)
                    duration: 300
                }
                NumberAnimation{
                    target: playicon
                    property: "opacity"
                    from: 0.0
                    to:0.9
                    duration: 300
                }

            }
        },
        Transition {
            from: "in"
            to: "out"
            ParallelAnimation{
                NumberAnimation{
                    target: a1
                    property: "opacity"
                    from: 0.9
                    to:0.5
                    duration: 300
                }
                NumberAnimation{
                    target: a2
                    property: "opacity"
                    from: 0.9
                    to:0.5
                    duration: 300
                }
                PropertyAnimation{
                    target: root
                    property: "border.color"
                    from: Qt.rgba(150,150,150,0.9)
                    to:Qt.rgba(150,150,150,0.1)
                    duration: 300
                }
                NumberAnimation{
                    target: playicon
                    property: "opacity"
                    from: 0.9
                    to:0.0
                    duration: 300
                }

            }
        }

    ]


    Row{
        anchors.verticalCenter: parent.verticalCenter
        spacing: 30

        Text {
            id:a1
            leftPadding: 30
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pixelSize: 20
            text: root.midx
            opacity: 0.5
        }

        Rectangle{
            id:playicon
            width: root.height
            height: root.height
            color: Qt.rgba(0,0,0,0)
            opacity: 0.0
            Image {
                anchors.centerIn: parent
                source: "window_icons/window_play.svg"
                sourceSize.width: 20
                sourceSize.height: 20
            }
        }

        Text {
            id:a2
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pixelSize: 15
            text: root.music_path
            opacity: 0.5
        }
    }

    MouseArea{
        id:area
        anchors.fill:root
        hoverEnabled: true

        onDoubleClicked: {
            root.dbclicked()
        }

        onEntered: {
            area.cursorShape = Qt.PointingHandCursor
            root.state="in"
        }
        onExited: {
            area.cursorShape = Qt.ArrowCursor
            root.state="out"
        }
    }

}
