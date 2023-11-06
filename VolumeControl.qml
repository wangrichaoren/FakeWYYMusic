import QtQuick
import QtQuick.Controls

Item {
    id:root

    property double volume_value: volume_slider.value
    //    property string icon_path: ""
    property int icon_size: 25
    property bool btnState: true
    property double last_value: 0.5
    width: rowcom.width
    height: rowcom.height

    Row{
        id:rowcom
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter

        Rectangle{
            id:btn
            width: volume_slider.height
            height: volume_slider.height
            color:"transparent"
            opacity:0.5
            Image {
                anchors.centerIn: parent
                source: btnState===true?"window_vol_on.svg":"window_vol_off.svg"
                sourceSize.width: root.icon_size
                sourceSize.height: root.icon_size
            }

            MouseArea{
                id:area
                anchors.fill: btn
                hoverEnabled: true
                onClicked: {
                    btnState=!btnState
                    if (btnState===false){
                        root.last_value=volume_slider.value
                        volume_slider.value=0.0
                    }else{
                        volume_slider.value=root.last_value
                    }
                }

                onEntered: {
                    area.cursorShape = Qt.PointingHandCursor
                    btn.opacity=1.0
                }

                onExited: {
                    area.cursorShape = Qt.ArrowCursor
                    btn.opacity=0.3
                }
            }
        }


        Slider {
            id: volume_slider
            anchors.verticalCenter: btn.verticalCenter
            value: 0.5
            from:0.0
            to:1.0

            background:
                Rectangle {
                x: volume_slider.leftPadding
                y: volume_slider.topPadding + volume_slider.availableHeight / 2 - height / 2
                implicitWidth: 60
                implicitHeight: 4
                width: volume_slider.availableWidth
                height: implicitHeight
                radius: 2
                color: "#8B8989"

                Rectangle {
                    width: volume_slider.visualPosition * parent.width
                    height: parent.height
                    color:"#FFFAFA"
                    radius: 2
                }
            }

            handle: Rectangle {
                id:slide_handle
                x: volume_slider.leftPadding + volume_slider.visualPosition * (volume_slider.availableWidth - width)
                y: volume_slider.topPadding + volume_slider.availableHeight / 2 - height / 2
                implicitWidth: 12
                implicitHeight: 12
                radius: 6
                color: volume_slider.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }

        }
    }
}
