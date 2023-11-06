import QtQuick

Rectangle{
    property int mwidth: 40
    property int mheight: 40
    property int icon_size: 18
    property string icon_path: ""
    property string tooltip: "none"

    id:m_rect

    signal clicked

    width: mwidth
    height:mheight
    color: Qt.rgba(255,255,255,0.1)
    radius: mwidth/2

    Image {
        anchors.centerIn: m_rect
        source: m_rect.icon_path
        sourceSize.width: icon_size
        sourceSize.height: icon_size
    }

    state: "out"
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
            ScaleAnimator{
                target: m_rect
                from: 1.1
                to:1.0
                duration: 300
            }
        },
        Transition {
            from: "out"
            to: "in"
            ScaleAnimator{
                target: m_rect
                from: 1.0
                to:1.1
                duration: 300
            }

        }
    ]

    MouseArea{
        id:area
        anchors.fill: m_rect
        hoverEnabled: true
        onClicked: {
            m_rect.clicked()
        }

        onEntered: {
            area.cursorShape = Qt.PointingHandCursor
            m_rect.state="in"
        }

        onExited: {
            area.cursorShape = Qt.ArrowCursor
            m_rect.state="out"
        }
    }
}
