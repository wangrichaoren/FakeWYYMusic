import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtMultimedia
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.platform
import FileScanner 1.0
import Qt.labs.settings

Window  {
    property int bw: 3
    property int minwidth: 1056
    property int minheight: 747
    property bool is_play: false
    property double ratio: 1.0

    signal curViewIndex(int idx)

    Settings{
        id:m_setting
        fileName: "./setting.ini"
        property string local_music_path: ""
    }

    FileScanner{
        id:file_scanner
    }

    id:windowapp
    width: minwidth
    height: minheight
    visible: true
    title: qsTr("网易云音乐")

    minimumWidth: minwidth
    minimumHeight: minheight

    // 无边框模式
    flags:Qt.FramelessWindowHint | Qt.WindowSystemMenuHint
          | Qt.WindowMinimizeButtonHint| Qt.Window;

    // 快捷键
    Shortcut{
        sequence: "Space"
        onActivated: {
            wind_play.clicked()
        }
    }

    onWidthChanged: {
        windowapp.ratio=windowapp.width/windowapp.minwidth
    }

    // 顶部移动控件 h:30 w:window.width
    Rectangle{
        id:move_space
        height: 30
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        MouseArea{
            anchors.fill: move_space
        }
    }

    // 背景
    Rectangle{
        property string bgsource: "bg_imgs/background1.jpg"
        id:background
        anchors.centerIn: parent
        anchors.fill: parent
        Image {
            id: backgroudimg
            anchors.fill: parent
            source: background.bgsource
            fillMode: Image.PreserveAspectCrop
        }
    }

    // 左侧边栏 透明度降低
    Rectangle{
        id:left_side
        width: 200   //203
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: player_ctl.top
        opacity:0.2
    }

    // 右侧黑色透明度
    Rectangle{
        id:right_side
        anchors.left: left_side.right
        anchors.top: parent.top
        anchors.bottom: player_ctl.top
        anchors.right: parent.right
        color:"#000000"
        opacity:0.1
    }

    // 左侧边栏 顶部标题
    Rectangle{
        id:lefttop_title
        anchors.top: move_space.bottom
        width: title.width
        height: title.height
        color:Qt.rgba(0,0,0,0)
        anchors.horizontalCenter:  left_side.horizontalCenter
        Row{
            id:title
            spacing: 10
            Image {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                sourceSize.width: 28
                sourceSize.height: 28
                source: "window_icons/wyyyycircle.svg"
                antialiasing: true
                fillMode: Image.PreserveAspectFit
            }
            Text {
                id:t1
                text: qsTr("网易云音乐")
                antialiasing: true
                font.pixelSize: 19
                font.bold: true
                color:"#F8F8FF"
            }
            Rectangle{
                anchors.bottom: t1.bottom
                anchors.bottomMargin: 2
                width: 30
                height: 15
                border.color: "#D3D3D3"
                color: Qt.rgba(0,0,0,0)
                radius: 4
                Text {
                    anchors.centerIn: parent
                    font.pixelSize: 11
                    color: "#D3D3D3"
                    text: qsTr("Fake")
                }
            }
        }
        MouseArea{
            id:area1
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                mainView.push(wwtj_view)
                left_view.currentIndex=0
            }


            onEntered: {
                area1.cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                area1.cursorShape = Qt.ArrowCursor
            }
        }
    }

    // 左侧边栏 listview
    Rectangle{
        id:opts
        anchors.top: lefttop_title.bottom
        anchors.topMargin: 20
        anchors.left: lefttop_title.left
        anchors.right: lefttop_title.right
        anchors.bottom: player_ctl.top
        anchors.bottomMargin: 30
        color: Qt.rgba(0,0,0,0)

        // btn list view
        ListView{
            anchors.fill: opts
            id:left_view
            model: left_model
            delegate: left_delegate
            spacing: 5
            focus: true
            highlight: Rectangle{color: Qt.rgba(0,0,0,0.0)}
        }

        ListModel{
            id:left_model

            // 第一部分选项按钮
            ListElement{
                m_icon_path:"window_icons/face_wwtj.svg"
                m_text:"为我推荐"
            }
            ListElement{
                m_icon_path:"window_icons/face_yyyjx.svg"
                m_text:"云音乐精选"
            }
            ListElement{
                m_icon_path:"window_icons/face_bk.svg"
                m_text:"博客"
            }
            ListElement{
                m_icon_path:"window_icons/face_srmy.svg"
                m_text:"私人漫游"
            }
            ListElement{
                m_icon_path:"window_icons/face_sq.svg"
                m_text:"社区"
            }
            // 分割线1
            ListElement{
                m_icon_path:""
                m_text:"-"
            }
            // 第二部分选项按钮
            ListElement{
                m_icon_path:"window_icons/face_wxhdyy.svg"
                m_text:"我喜欢的音乐"
            }
            ListElement{
                m_icon_path:"window_icons/face_zjbf.svg"
                m_text:"最近播放"
            }
            ListElement{
                m_icon_path:"window_icons/face_wdbk.svg"
                m_text:"我的博客"
            }
            ListElement{
                m_icon_path:"window_icons/face_wdsc.svg"
                m_text:"我的收藏"
            }
            ListElement{
                m_icon_path:"window_icons/face_xzsl.svg"
                m_text:"下载数量"
            }
            ListElement{
                m_icon_path:"window_icons/face_bdyy.svg"
                m_text:"本地音乐"
            }
            ListElement{
                m_icon_path:"window_icons/face_wdyyyp.svg"
                m_text:"我的音乐云盘"
            }
            // 分割线2
            ListElement{
                m_icon_path:""
                m_text:"-"
            }

            // todo 下拉1-----创建的歌单(7)


            // todo 下拉2-----收藏的歌单(19)


        }

        Component{
            id:left_delegate
            Loader{
                sourceComponent: {
                    if (m_text==="-"){
                        // 分割线
                        return spl
                    }else{
                        // view btn
                        return vbtn
                    }

                }

                Component{
                    id: spl
                    Item{
                        width: 155
                        height: 20
                        focus: false
                        Rectangle{
                            height: 1
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.right: parent.right
                            color:"#D3D3D3"
                            opacity: 0.3
                        }
                    }
                }

                Component{
                    id: vbtn
                    ViewBtn{
                        icon_path: m_icon_path
                        text:m_text
                        onClickBtn: {
                            left_view.currentIndex=index
                            windowapp.curViewIndex(left_view.currentIndex)
                        }
                    }

                }

            }

        }

    }

    // 底部 音乐播放栏
    Rectangle{
        id:player_ctl
        anchors.left: parent.left
        anchors.right:parent.right
        anchors.bottom: parent.bottom
        height: 80
        color: Qt.rgba(0,0,0,0.4)
        opacity: 1.0
        // 播放栏上分割条
        Rectangle{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 0.7
            color: "white"
            opacity: 0.3
        }

        // 唱片控件
        RecordControl{
            id:record_ctl
            anchors.left: player_ctl.left
            anchors.leftMargin: 30
            anchors.top: player_ctl.top
            anchors.topMargin: 10
            icon_path: "jay.png"
            onClicked: {
                icon_path="jay2.png"
            }
        }

        // 心动模式 按钮
        NormalBtn{
            icon_path: "window_icons/window_xdms.svg"
            icon_size: 30
            anchors.right: playbtns.left
            anchors.rightMargin: 50
            anchors.top: player_ctl.top
            anchors.topMargin: 15
            onClicked: {
                msg_popup.msg="心动模式功能\n未实现"
                msg_popup.open()
            }
        }

        // 歌词 按钮
        NormalBtn{
            icon_path: "window_icons/window_c.svg"
            icon_size: 22
            anchors.left: playbtns.right
            anchors.leftMargin: 18
            anchors.top: player_ctl.top
            anchors.topMargin: 16
            onClicked: {
                msg_popup.msg="歌词功能\n未实现"
                msg_popup.open()
            }
        }

        // 播放按钮
        Row{
            id:playbtns
            anchors.horizontalCenter: player_ctl.horizontalCenter
            anchors.top:player_ctl.top
            anchors.topMargin: 10
            spacing: 20

            ImageNoEffBtn{
                id:wind_left
                icon_path: "window_icons/window_left.svg"
                onClicked: {
                    msg_popup.msg="上一首功能\n未实现"
                    msg_popup.open()
                }
            }

            CircleBtn{
                id:wind_play

                icon_path: windowapp.is_play?"window_icons/window_pause.svg":"window_icons/window_play.svg"

                onClicked: {
                    windowapp.is_play=!windowapp.is_play
                    windowapp.is_play===true?playMusic.play():playMusic.pause()
                    record_ctl.rotationed(windowapp.is_play)
                }
            }

            ImageNoEffBtn{
                id:wind_right
                icon_path: "window_icons/window_right.svg"
                onClicked: {
                    msg_popup.msg="下一首功能\n未实现"
                    msg_popup.open()
                }
            }

            MediaPlayer {
                id: playMusic
                source: "jda-zjl.mp3"
                audioOutput: AudioOutput {volume: volume_slider.volume_value}
                onMediaStatusChanged: {
                    if (playMusic.mediaStatus===MediaPlayer.EndOfMedia){
                        console.log("播放完成...暂停")
                        wind_play.clicked()
                    }
                }

            }
        }

        // 播放进度滑动条
        Slider {
            property bool moveing: false
            signal click_slide
            id: process_slider
            width: 312*windowapp.ratio
            height: bg.height
            opacity: 0.8
            anchors.horizontalCenter: playbtns.horizontalCenter
            anchors.top: playbtns.bottom
            anchors.topMargin: 12
            value: moveing===false?playMusic.position/playMusic.duration:process_slider.position
            from:0.0
            to:1.0

            background:
                Rectangle {
                id:bg
                x: process_slider.leftPadding
                y: process_slider.topPadding + process_slider.availableHeight / 2 - height / 2
                implicitWidth: 312*windowapp.ratio
                implicitHeight: 4
                width: process_slider.availableWidth
                height: implicitHeight
                radius: 2
                color: "#8B8989"
                Rectangle {
                    width: process_slider.visualPosition * parent.width
                    height: parent.height
                    color:"#53868B"
                    radius: 2
                }
            }
            handle: Rectangle {
                id:slide_handle
                x: process_slider.leftPadding + process_slider.visualPosition * (process_slider.availableWidth - width)
                y: process_slider.topPadding + process_slider.availableHeight / 2 - height / 2
                implicitWidth: 14
                implicitHeight: 14
                radius: 7
                color: process_slider.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }
            onMoved: {
                process_slider.moveing=true
                playMusic.position=process_slider.position*playMusic.duration
                process_slider.moveing=false
            }
        }


        // 唱片左侧
        Column{
            spacing: 5
            anchors.left: player_ctl.left
            anchors.leftMargin: 100
            anchors.top: player_ctl.top
            anchors.topMargin: 18

            Row{
                spacing: 5
                Rectangle{
                    id:viptext
                    anchors.leftMargin: 10
                    width: 18
                    height: 13
                    border.color: "green"
                    border.width: 1
                    color: Qt.rgba(0,0,0,0)
                    radius: 3
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 9
                        color: "green"
                        text: qsTr("VIP")
                    }
                }

                Rectangle{
                    anchors.verticalCenter: viptext.verticalCenter
                    width: 130
                    height: 20
                    color: Qt.rgba(0,0,0,0)
                    Text {
                        id:music_name
                        anchors.left: parent.left
                        anchors.verticalCenter:parent.verticalCenter
                        font.pixelSize: 16
                        color: "white"
                        text: qsTr("简单爱-周杰伦")
                    }
                    MouseArea{
                        id:info_area
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            info_area.cursorShape = Qt.PointingHandCursor
                        }
                        onExited: {
                            info_area.cursorShape = Qt.ArrowCursor
                        }
                    }
                }


            }

            Row{
                spacing: 5
                ImageNoEffBtn{
                    icon_size: 18
                    icon_path: "window_icons/window_like.svg"
                    onClicked: {
                        msg_popup.msg="喜欢功能\n未实现"
                        msg_popup.open()
                    }
                }
                ImageNoEffBtn{
                    icon_size: 18
                    icon_path: "window_icons/window_pl.svg"
                    onClicked: {
                        msg_popup.msg="查看评论功能\n未实现"
                        msg_popup.open()
                    }
                }
                ImageNoEffBtn{
                    icon_size: 18
                    icon_path: "window_icons/window_xz.svg"
                    onClicked: {
                        msg_popup.msg="下载功能\n未实现"
                        msg_popup.open()
                    }
                }
                ImageNoEffBtn{
                    icon_size: 18
                    icon_path: "window_icons/window_gd.svg"
                    onClicked: {
                        msg_popup.msg="更多操作功能\n未实现"
                        msg_popup.open()
                    }
                }
            }

        }

        // 音量滑动条
        VolumeControl{
            id:volume_slider
            anchors.right: player_ctl.right
            anchors.rightMargin: 30
            anchors.verticalCenter: player_ctl.verticalCenter
        }

        // 音量 左边控件
        Row{
            id:volleftctl
            spacing: 20
            anchors.right: volume_slider.left
            anchors.rightMargin: 20
            anchors.verticalCenter: volume_slider.verticalCenter

            Rectangle{
                anchors.verticalCenter: volleftctl.verticalCenter
                width: txt.width+2
                height: txt.height+2
                color:Qt.rgba(0,0,0,0)
                border.color: "white"
                radius: 3
                opacity: 0.5
                Text {
                    anchors.centerIn: parent
                    id:txt
                    text: qsTr("高清臻音")
                    color:"white"
                    font.pixelSize: 10
                }

                MouseArea{
                    id:area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        msg_popup.msg="高清臻音功能\n未实现"
                        msg_popup.open()
                    }


                    onEntered: {
                        area.cursorShape = Qt.PointingHandCursor
                        parent.opacity=1.0
                    }

                    onExited: {
                        area.cursorShape = Qt.ArrowCursor
                        parent.opacity=0.5
                    }
                }

            }

            OpactityBtn{
                icon_size: 20
                icon_path: "window_icons/window_yx.svg"
                onClick: {
                    msg_popup.msg="音效功能\n未实现"
                    msg_popup.open()
                }
            }


            OpactityBtn{
                anchors.verticalCenter: volume_slider.verticalCenter
                icon_size: 20
                icon_path: "window_icons/window_bflb.svg"
                onClick: {
                    msg_popup.msg="播放列表功能\n未实现"
                    msg_popup.open()
                }
            }

        }

    }


    // -------------------------- 右上角所有控件 --------------------------
    // 关闭按钮
    NormalBtn{
        id:wind_close
        anchors.right: move_space.right
        anchors.rightMargin: 60
        anchors.top: move_space.bottom
        icon_path: "window_icons/window_close.svg"
        onClicked: {
            windowapp.close()
        }
    }

    // 最大化按钮
    NormalBtn{
        id:wind_max
        anchors.right: wind_close.right
        anchors.rightMargin: 30
        anchors.top: wind_close.bottom
        icon_path: "window_icons/window_max.svg"
        onClicked: windowapp.toggleMaximized()
    }

    // 最小化按钮
    NormalBtn{
        id:wind_min
        anchors.right: wind_max.right
        anchors.rightMargin: 30
        anchors.top: wind_max.bottom
        icon_path: "window_icons/window_min.svg"
        onClicked: {
            windowapp.showMinimized()
        }
    }

    // 迷你模式按钮
    NormalBtn{
        id:wind_mini
        anchors.right: wind_min.right
        anchors.rightMargin: 30
        anchors.top: wind_min.bottom
        icon_path: "window_icons/window_mini.svg"
        icon_size: 14
        onClicked: {
            msg_popup.msg="迷你模式功能\n未实现"
            msg_popup.open()
        }
    }

    // 竖分割线
    Rectangle{
        id:vsplt
        width: 1
        height: 15
        focus: false
        anchors.right: wind_mini.left
        anchors.rightMargin: 10
        anchors.top: wind_mini.top
        anchors.topMargin: 7
        opacity: 0.3
        color:"#D3D3D3"
    }

    // 换肤按钮
    property int bgcount: 1
    property int endvaue: 3  // 总图片背景数量
    NormalBtn{
        id:wind_hf
        anchors.right: wind_mini.right
        anchors.rightMargin: 50
        anchors.top: wind_mini.bottom
        icon_path: "window_icons/window_hf.svg"
        icon_size: 20
        onClicked: {
            windowapp.bgcount+=1
            if (windowapp.bgcount===endvaue+1){
                windowapp.bgcount=1
            }
            background.bgsource="bg_imgs/"+"background"+windowapp.bgcount+".jpg"
        }
    }

    // 设置按钮
    NormalBtn{
        id:wind_set
        anchors.right: wind_hf.right
        anchors.rightMargin: 30
        anchors.top: wind_hf.bottom
        icon_path: "window_icons/window_set.svg"
        icon_size: 20
        onClicked: {
            msg_popup.msg="设置功能\n未实现"
            msg_popup.open()
        }
    }

    // 消息中心按钮
    NormalBtn{
        id:wind_msg
        anchors.right: wind_set.right
        anchors.rightMargin: 30
        anchors.top: wind_set.bottom
        icon_path: "window_icons/window_msg.svg"
        icon_size: 22
        onClicked: {
            msg_popup.msg="消息中心功能\n未实现"
            msg_popup.open()
        }
    }


    // -------------------------- 左上角所有控件 --------------------------  [1]

    Row{
        id:lefttopctl
        spacing: 10
        anchors.left: left_side.right
        anchors.leftMargin: 40
        anchors.top: move_space.bottom

        // 返回按钮
        IconBoradBtn{
            icon_path: "window_icons/window_back.svg"
            onClicked: {
                mainView.pop()
            }
        }

        // 搜索控件
        SearchInputEdite{
            icon_path: "window_icons/window_find.svg"
            onTexteEdt: {
                console.log(mtxt)
            }
        }

        // 听歌识曲按钮
        IconBoradBtn{
            icon_path: "window_icons/window_tgsq.svg"
            mwidth: 33
            icon_size: 23
            onClicked: {
                msg_popup.msg="听歌识曲功能\n未实现"
                msg_popup.open()
            }
        }
    }
    // ------------------------------------------------------------------  [1]

    // -------------------------- 关于move area的所有逻辑 -----------------  [0]
    function toggleMaximized() {
        if (windowapp.visibility === Window.Maximized) {
            wind_max.icon_path="window_icons/window_max.svg"
            windowapp.showNormal();
        } else {
            wind_max.icon_path="window_icons/window_reset.svg"
            windowapp.showMaximized();
        }
    }

    DragHandler {
        id: resizeHandler
        grabPermissions: TapHandler.TakeOverForbidden
        target: null
        onActiveChanged: if (active) {
                             const p = resizeHandler.centroid.position;
                             const b = 1; // Increase the corner size slightly
                             let e = 0;
                             if (p.x < b) { e |= Qt.LeftEdge }
                             if (p.x >= width - b) { e |= Qt.RightEdge }
                             if (p.y < b) { e |= Qt.TopEdge }
                             if (p.y >= height - b) { e |= Qt.BottomEdge }
                             windowapp.startSystemResize(e);
                         }
    }

    Item {
        anchors.fill: move_space
        TapHandler {
            onTapped: if (tapCount === 2) toggleMaximized()
            gesturePolicy: TapHandler.DragThreshold
        }
        DragHandler {
            grabPermissions: TapHandler.CanTakeOverFromAnything
            onActiveChanged: if (active) { windowapp.startSystemMove(); }
        }
    }
    // --------------------------------------------------------------------  [0]

    // 消息弹窗
    Popup {
        property string msg: "未实现"
        id: msg_popup
        width: 200
        height: 150
        x:windowapp.width/2-width/2
        y:windowapp.height/2-height/2
        background: Rectangle{
            id:p_rect
            anchors.fill: parent
            border.color: "black"
            border.width: 2
            radius: 15
            opacity: 0.7
            color: "#00868B"
            Text {
                text: msg_popup.msg
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                font.pixelSize: 20
                font.bold: true
                color: "white"
            }
            Image {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 10
                sourceSize.height: 60
                sourceSize.width: 60
                source: "window_icons/jorker.svg"
            }
            SequentialAnimation{
                id:ani
                ScaleAnimator {
                    id: scale_ani
                    target: p_rect
                    from: 0.0
                    to: 1.0
                    duration: 50000
                    easing.type: Easing.OutBack
                }
                PropertyAnimation{
                    id:opa_ani
                    target: p_rect
                    property: "opacity"
                    from:0.7
                    to:0.0
                    duration: 2500
                    easing.type: Easing.OutBack
                }
            }


        }

        onOpened: {
            ani.restart()
        }

        onClosed : {
            ani.stop()
            p_rect.opacity=0.7
            p_rect.scale=0.0
        }

    }


    // 为我推荐view
    Component{
        id:wwtj_view
        MyScrollView{
            id:wwtj_sc
            anchors.fill: parent
            Flow{
                width:wwtj_sc.width
                height: wwtj_sc.height
                spacing: 30
                MySwiperView{id:swv}

                Rectangle{
                    width: swv.width
                    height: swv.height
                    radius: swv.radius
                    color: Qt.rgba(150,150,150,0.5)
                    Image {
                        source: "swip_imgs/zwddzp.jpg"
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                    }
                }
                Repeater{
                    model:12
                    Rectangle{
                        width: 170
                        height: 300
                        radius: 10
                        color: Qt.rgba(150,150,150,0.5)
                        Image {
                            source: "swip_imgs/"+index+".jpg"
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectFit
                        }

                        MouseArea{
                            id:area
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                area.cursorShape = Qt.PointingHandCursor
                                parent.scale=1.01
                            }
                            onExited: {
                                area.cursorShape = Qt.ArrowCursor
                                parent.scale=1.0
                            }
                        }
                    }
                }

            }
        }
    }

    Component{
        id:yyyjx_view
        MyScrollView{
            id:yyyjx_scroll
            anchors.fill: parent
            Flow{
                width:yyyjx_scroll.width
                height: yyyjx_scroll.height
                spacing: 30
                Repeater{
                    model:60
                    Rectangle{
                        width: 200
                        height: 150
                        radius: 10
                        color: Qt.rgba(150,150,150,0.5)
                        Image {
                            source: "window_icons/jorker1.svg"
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                }
            }
        }
    }

    Component{
        id:wsx_view
        Rectangle{
            anchors.fill: parent
            color:Qt.rgba(120,120,120,0.3)
            border.color: "black"
            border.width: 2
            radius: 20
            Text {
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text:"糟糕!失去连接..."
                font.pixelSize: 40
                font.bold: true
                color: "white"
            }

            Image {
                anchors.centerIn: parent
                source: "window_icons/404.svg"
                sourceSize.width: 400
                sourceSize.height: 400
            }
        }
    }

    // 本地音乐view
    Component{
        id:local_view
        MyScrollView{
            id:local_scroll
            anchors.fill: parent

            Column{
                width:local_scroll.width
                height: local_scroll.height
                spacing: 30
                Row{
                    id:music_row
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 80
                    spacing: 20

                    // 本地音乐的路径选取
                    TextBtn{
                        anchors.verticalCenter: parent.verticalCenter
                        onClickBtn: {
                            // 选择文件夹
                            folderDialog.open()
                        }
                    }

                    TextBtn{
                        id:refreshbtn
                        mw: 40
                        mh: 40
                        mrdius: 10
                        mtxt: "刷新"
                        anchors.verticalCenter: parent.verticalCenter
                        onClickBtn: {
                            // 刷新列表
                            music_model.clear()
                            // 加载目录歌曲
                            var abc=file_scanner.findMp3Files(ttttt.text)
                            for (var i = 0; i < abc.length; i++) {
                                //                                console.log("Item at index", i, ":", abc[i]);
                                music_model.append({name:abc[i]})
                            }

                        }
                    }

                    // 文件夹路径显示
                    Rectangle{
                        property string ppp: ""
                        id:fold_path
                        anchors.verticalCenter: parent.verticalCenter
                        width: ttttt.width===0?0:ttttt.width+20
                        height: 40
                        radius: 3
                        color:Qt.rgba(0,0,0,0)
                        border.color: Qt.rgba(150,150,150,0.2)
                        Text {
                            id:ttttt
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            text: m_setting.local_music_path
                            color:"white"
                            font.pixelSize: 13
                        }
                    }


                }

                ListView{
                    id:music_view
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: music_row.bottom
                    anchors.topMargin: 30
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    model: music_model
                    delegate: music_delagete
                    spacing: 10
                }

                ListModel{
                    id:music_model
                    Component.onCompleted: {
                        refreshbtn.clickBtn()
                    }
                }

                Component{
                    id:music_delagete

                    MusicRect{
                        midx: index
                        music_path: file_scanner.parseMp3Name(name)
                        anchors.left:parent.left
                        anchors.right: parent.right

                        onDbclicked: {
                            if (!playMusic.playing){
                                wind_play.clicked()
                            }
                            playMusic.source=name
                            playMusic.play()
                            music_name.text=file_scanner.parseMp3Name(name)
                        }
                    }
                }

            }
        }
    }


    StackView{
        id:mainView
        anchors.top: lefttopctl.bottom
        anchors.topMargin: 15
        anchors.left: lefttopctl.left
        anchors.right: move_space.right
        anchors.rightMargin: 40
        anchors.bottom: player_ctl.top
        initialItem:wwtj_view
    }


    FolderDialog {
        id: folderDialog
        folder: StandardPaths.standardLocations(StandardPaths.MusicLocation)
        options:FolderDialog.ShowDirsOnly
        title: "选择本地音乐文件夹"
        onAccepted: {
            m_setting.local_music_path=folderDialog.folder.toString().replace("file:///", "")
            refreshbtn.clickBtn()
        }
    }

    onCurViewIndex: {
        if (idx===0){
            mainView.push(wwtj_view)
        }else if (idx===1){
            mainView.push(yyyjx_view)
        }else if(idx===11){
            mainView.push(local_view)
        }

        else{
            mainView.push(wsx_view)
        }

    }




}

