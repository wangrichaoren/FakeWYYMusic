import QtQuick
import QtQuick.Controls


Rectangle {
    property int mwidth: 250
    property int mheight: 35
    property string icon_path : ""
    property int icon_size: 20

    property bool bling:true

    signal texteEdt(string mtxt)

    id:root
    radius: 10
    width: mwidth
    height: mheight
    color: Qt.rgba(0,0,0,0)
    border.color: "white"
    border.width: 1
    opacity: 0.3
    focus: false

    Image {
        id:img
        anchors.left: root.left
        anchors.leftMargin: 10
        anchors.verticalCenter: root.verticalCenter
        sourceSize.width: root.icon_size
        sourceSize.height: root.icon_size
        source: root.icon_path
        MouseArea{
            id:area
            anchors.fill:parent
            hoverEnabled: true
            onEntered: {
                area.cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                area.cursorShape = Qt.ArrowCursor
            }

        }
    }

    TextField {
        id:input
        height: root.height-15
        anchors.left:img.right
        anchors.right: root.right
        anchors.rightMargin: 10
        anchors.leftMargin: 2
        anchors.verticalCenter: root.verticalCenter
        placeholderText: placeholderTextChanged()
        placeholderTextColor: Qt.rgba(255,255,255,0.5)
        font.pixelSize: 13
        cursorDelegate:cursor


        color: "white"

        background:Rectangle{

            color: Qt.rgba(0,0,0,0)
        }

        Component{
            id:cursor
            Rectangle{
                id:cursorRect
                width: 1
                height: 30
                color: (root.bling === true) ? Qt.rgba(0,0,0,0) : "white"
            }
        }

        Timer{
            id:timer
            interval: 600;
            repeat: true;
            onTriggered: {
                bling = (bling === true) ? false : true
            }
        }

        // 自动轮换placehold歌曲名
        Timer{
            id:holdtext_timer
            interval: 3000;
            repeat: true;
            running: true
            onTriggered: {
                input.placeholderText=input.placeholderTextChanged()
            }
        }

        property var searchTexts: ["周杰伦","许嵩","林俊杰","月半小夜曲（李克勤）","稻香（周杰伦）",
            "Whataya Want from Me","罗生门（Follow）","カラノココロ (Matt Cab & MATZ Remix)",
            "花海", "夜曲", "晴天", "以父之名", "七里香", "可爱女人", "听妈妈的话", "简单爱", "彩虹",
            "发如雪", "轨迹", "世界第一等", "半兽人", "爱情转移", "东风破", "借口", "安静", "红尘客栈", "爷爷",
            "夢の蕾",
            "恋愛サーキュレーション",
            "ふたりごと",
            "Lemon",
            "シンゴジラ節",
            "未来のミュージアム",
            "香水",
            "Pretender",
            "パプリカ",
            "糸",
            "コンプリケイション",
            "宇多田ヒカル",
            "あなた",
            "Love Story",
            "STAY ALIVE",
            "夜に駆ける",
            "LIFE",
            "Lovers",
            "さくら",
            "Time Machine",
            "봄날 (Spring Day)",
            "Love Scenario",
            "Gangnam Style",
            "Dope (쩔어)",
            "Blood Sweat & Tears (피 땀 눈물)",
            "FANCY",
            "TT",
            "MIC Drop (Steve Aoki Remix)",
            "Boy With Luv (작은 것들을 위한 시)",
            "Ko Ko Bop",
            "Blue & Grey",
            "Black Mamba",
            "My Time (시차)",
            "Not Shy",
            "Psycho",
            "Signal",
            "How You Like That",
            "Monster",
            "Bad Boy",
            "Love Me Right (러브 미 라잇)",
            "Bohemian Rhapsody",
            "Imagine",
            "Hotel California",
            "Yesterday",
            "Let It Be",
            "Yesterday",
            "Wonderwall",
            "All You Need Is Love",
            "Smells Like Teen Spirit",
            "Stairway to Heaven",
            "Like a Rolling Stone",
            "Hey Jude",
            "With or Without You",
            "Another Brick in the Wall",
            "Sweet Child o' Mine",
            "Light My Fire",
            "Imagine",
            "Blowin' in the Wind",
            "American Pie",
            "Hey Jude",

        ]
        function placeholderTextChanged(){
            var randomIndex = Math.floor(Math.random() * searchTexts.length);
            return searchTexts[randomIndex];
        }

        onPressed: {timer.start()}

        onTextEdited: {
            root.texteEdt(input.text)
        }

        onFocusChanged: {
            //            if (input.activeFocus){
            //                console.log("input focus act")
            //            }else{
            //                root.bling=true
            //                timer.stop()
            //                console.log("input not focus act")
            //            }

        }
    }
}
