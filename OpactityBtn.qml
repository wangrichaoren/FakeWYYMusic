import QtQuick

Rectangle {
    property string icon_path: ""
    property int icon_size: 25
    signal click

    id:root
    width: img.width
    height: img.height
    color: Qt.rgba(0,0,0,0)
    opacity: 0.5
    Image {
        id:img
        anchors.centerIn: parent
        source: root.icon_path
        sourceSize.width: root.icon_size
        sourceSize.height: root.icon_size
    }

    MouseArea{
        id:area
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            root.click()
        }

        onEntered: {
            area.cursorShape = Qt.PointingHandCursor
            root.opacity=1.0
        }

        onExited: {
            area.cursorShape = Qt.ArrowCursor
            root.opacity=0.5
        }
    }
}
