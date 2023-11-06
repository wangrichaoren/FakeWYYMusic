import QtQuick

Rectangle {
    property int icon_size: 16
    property string icon_path: ""
    property string tooltip: "none"

    id:m_rect
    focus: true
    signal clicked

    width: 30
    height:30
    color: Qt.rgba(0,0,0,0)

    anchors.verticalCenter: parent.verticalCenter

    Image {
        anchors.centerIn: parent
        source: m_rect.icon_path
        sourceSize.width: icon_size
        sourceSize.height: icon_size
    }

    MouseArea{
        id:area
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            m_rect.clicked()
        }

        onEntered: {
            area.cursorShape = Qt.PointingHandCursor
        }

        onExited: {
            area.cursorShape = Qt.ArrowCursor
        }
    }
}
