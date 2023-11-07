import QtQuick
import QtQuick.Controls

Rectangle{
    id:m_swiperview
    width: 370/**windowapp.ratio*/
    height: 178/**windowapp.ratio*/
    radius: 10/**windowapp.ratio*/
    color: Qt.rgba(150,150,150,0.5)

    SwipeView {
        id:view
        anchors.fill: parent
        currentIndex: indicator.currentIndex
        clip: true
        Repeater{
            model: 13
            Image {
                source: "swip_imgs/"+index+".jpg"
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    PageIndicator {
        id: indicator
        interactive: true
        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Timer{
        id:indicator_timer
        interval: 2000;
        running: true;
        repeat: true
        onTriggered: {
            if (indicator.currentIndex===view.count-1){
                indicator.currentIndex=0
                return
            }
            indicator.currentIndex=view.currentIndex+1
        }
    }
}
