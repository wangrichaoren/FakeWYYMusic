import QtQuick

Rectangle {
    property int icon_size: 18
    property string icon_path: ""
    property string tooltip: "none"

    id:root
    focus: true
    //    width: 30
    //    height:30
    signal clicked

    Rectangle{
        id:m_rect
//        anchors.fill: root
        width: 30
        height:30
        color: Qt.rgba(0,0,0,0)


        Image {
            anchors.centerIn: m_rect
            source: root.icon_path
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
                NumberAnimation{
                    target: m_rect
                    property: "opacity"
                    from: 1.0
                    to:0.3
                    duration: 300
                }

            },
            Transition {
                from: "out"
                to: "in"
                NumberAnimation{
                    target: m_rect
                    property: "opacity"
                    from: 0.3
                    to:1.0
                    duration: 300
                }

            }
        ]

        MouseArea{
            id:area
            anchors.fill: m_rect
            hoverEnabled: true
            onClicked: {
                root.clicked()
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
}
