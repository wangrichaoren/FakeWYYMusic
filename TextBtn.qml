import QtQuick
import QtQuick.Controls

Rectangle{
    property int mw: 130
    property int mh: 40
    property int mrdius: 10
    property string mtxt: "添加本地音乐目录"

    signal clickBtn

    id:root
    width: mw
    height: mh
    radius: mrdius
    color:Qt.rgba(0,0,0,0)
    border.color: Qt.rgba(150,150,150,0.8)

    opacity: 0.5

    state:"out"

    states: [
        State {
            name: "in"
        },
        State {
            name: "out"
        }
    ]

    transitions: [
        Transition {
            from: "in"
            to: "out"
            NumberAnimation{
                target: root
                properties: "opacity"
                from: 1.0
                to:0.5
                duration: 300
            }
        },
        Transition {
            from: "out"
            to: "in"
            NumberAnimation{
                target: root
                properties: "opacity"
                from: 0.5
                to:1.0
                duration: 300
            }
        }

    ]

    Text {
        text: root.mtxt
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 12
    }

    MouseArea{
        id:area
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            root.clickBtn()
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
