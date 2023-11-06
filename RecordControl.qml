import QtQuick
import Qt5Compat.GraphicalEffects



Item {
    property string icon_path: ""
    property int icon_size: 65
    property int mw: 60
    property int mh: 60
    property bool is_runnig: false
    property double cur_ang: 0

    id:root
    signal clicked
    signal rotationed(bool torget)

    Image {
        id:img
        source: root.icon_path
        sourceSize.width: icon_size
        sourceSize.height: icon_size
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    Rectangle{
        id:circle
        width: root.mw
        height: root.mh
        radius: root.mw/2
        visible: false
    }

    Rectangle{
        id:m_mask
        width: circle.width
        height: circle.height
        border.color: "black"
        border.width: 6
        radius: root.mw/2
        OpacityMask{

            source: img
            maskSource: circle
            anchors.fill: parent
            anchors.margins: 2
        }
    }



    MouseArea{
        id:area
        anchors.fill:m_mask
        hoverEnabled: true
        onClicked: {
            root.clicked()
        }

        onEntered: {
            area.cursorShape = Qt.PointingHandCursor
        }
        onExited: {
            area.cursorShape = Qt.ArrowCursor
        }

    }

    // 不推荐写法 会有警告
    //    onRotationed: {
    //        root.is_runnig=torget
    //        if (root.is_runnig===false){
    //            root.cur_ang=m_mask.rotation
    //        }
    //    }

    Connections{
        target: root
        function onRotationed(torget) {
            root.is_runnig=torget
            if (root.is_runnig===false){
                root.cur_ang=m_mask.rotation
            }
        }
    }

    Timer{
        id:timer
        interval: 50;
        repeat: true;
        onTriggered: {
            cur_ang=cur_ang+1
            if(cur_ang>360){
                cur_ang=0
            }
            m_mask.rotation=cur_ang
        }
        running: root.is_runnig
    }

}
