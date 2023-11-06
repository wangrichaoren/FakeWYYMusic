import QtQuick

//
//  一堆bug。。。。
//

Item{
    property string icon_path: ""  // 左图标
    property string text: ""  // 文字
    property int icon_size: 20  // 图标大小 n*n
    property int text_size: 13  // 文字大小
    property string bg_color: "#6CA6CD"  // 背景颜色
    property double opa_value: root.activeFocus?1.0:0.5  // 字体透明度


    id:root
    width: 155
    height: 35
    focus: true
    signal clickBtn()

    Rectangle{
        id:m_rect
        anchors.fill: root
        radius: 7
        color: root.bg_color
        state: "outbtn"
        opacity: root.activeFocus?0.5:0.0
        states: [
            State {
                name: "inbtn"
            },
            State {
                name: "outbtn"
            },State {
                name: "clickbtn"
            }
        ]

        transitions: [
            Transition {
                from: "inbtn"
                to: "outbtn"
                NumberAnimation{
                    target: m_rect
                    property: "opacity"
                    from: 0.2
                    to:0.0
                    duration: 300
                }
            },
            Transition {
                from: "outbtn"
                to: "inbtn"
                NumberAnimation{
                    target: m_rect
                    property: "opacity"
                    from: 0.0
                    to:0.2
                    duration: 300
                }
            }
        ]

        MouseArea{
            id:area
            anchors.fill:m_rect
            hoverEnabled: true
            onClicked: {
                m_rect.state="clickbtn"
                root.clickBtn()
                root.forceActiveFocus()
            }
            onEntered: {
                if (!root.activeFocus){
                    area.cursorShape = Qt.PointingHandCursor
                    m_rect.state="inbtn"
                }
            }
            onExited: {
                if (!root.activeFocus){
                    area.cursorShape = Qt.ArrowCursor
                    m_rect.state="outbtn"
                }

            }
        }
    }

    Row{
        anchors.left: root.left
        anchors.leftMargin: 8
        anchors.verticalCenter: root.verticalCenter
        spacing: 8
        opacity: root.opa_value
        Image {
            id:img
            sourceSize.width: root.icon_size
            sourceSize.height: root.icon_size
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: root.icon_path
        }
        Text {
            anchors.verticalCenter:img.verticalCenter
            font.pixelSize: 13
            text:root.text
            color:"white"
        }
    }
}
