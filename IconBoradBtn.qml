import QtQuick

Rectangle{
    property int mwidth: 27
    property int mheight: 35
    property int icon_size: 15
    property string icon_path: ""
    property string tooltip: "none"

    id:m_rect

    signal clicked

    width: mwidth
    height:mheight
    color: Qt.rgba(0,0,0,0)
    radius: 8
    border.color: "white"
    border.width: 1


    Image {
        anchors.centerIn: m_rect
        source: m_rect.icon_path
        sourceSize.width: icon_size
        sourceSize.height: icon_size
    }

    state: "out"
    opacity: 0.3
    states: [
        State {
            name: "in"
            PropertyChanges {
                target: m_rect
            }
        },
        State {
            name: "out"
            PropertyChanges {
                target: m_rect
            }
        }
    ]
    transitions: [
        Transition {
            from: "in"
            to: "out"
            ParallelAnimation{
                NumberAnimation{
                    target: m_rect
                    property: "opacity"
                    from: 1.0
                    to:0.3
                    duration: 300
                }
                ColorAnimation {
                    target: m_rect
                    property: "color"
                    from: Qt.rgba(200,200,200,0.1)
                    to: Qt.rgba(0,0,0,0)
                    duration: 300
                }
            }
        },
        Transition {
            from: "out"
            to: "in"
            ParallelAnimation{
                NumberAnimation{
                    target: m_rect
                    property: "opacity"
                    from: 0.3
                    to:1.0
                    duration: 300
                }
                ColorAnimation {
                    target: m_rect
                    property: "color"
                    from: Qt.rgba(0,0,0,0)
                    to: Qt.rgba(200,200,200,0.1)
                    duration: 300
                }
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
