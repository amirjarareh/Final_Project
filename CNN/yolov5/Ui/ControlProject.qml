import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Extras 1.4
import "imports/ControlProject"

Rectangle {
    id: rectangle2
    width: Constants.width
    height: Constants.height

    color: '#333'


    Component.onCompleted: myLoader.sourceComponent = myCon1
    Loader{
        id: myLoader
        anchors.fill: parent
    }


    Component{
        id : myCon1
        My_Menu{
            onReal_Page_Menu: myLoader.sourceComponent = myCon2
            onAnalyze_Page_Menu: myLoader.sourceComponent = myCon3
        }

    }


    Component{
        id : myCon2

        My_View{
            onBack_Page_My_View: myLoader.sourceComponent = myCon1
        }

    }

    Component{
        id : myCon3
        Analyze{
            onBack_Page_Analyze: myLoader.sourceComponent = myCon1
        }
    }
}
















    //    Rectangle {
    //        id: rectangle
    //        x: 203
    //        y: 54
    //        width: 874
    //        height: 612
    //        color: "#ffffff"

    //        WebView{
    //            anchors.fill: parent
    //            url : "https://google.com"
    //        }
    //    }









    //    Rectangle {
    //        id: rect
    //        width: 100; height: 100
    //        color: "red"

    //        MouseArea {
    //            id: mouseArea
    //            anchors.fill: parent
    //        }

    //        states: State {
    //            name: "moved"; when: mouseArea.pressed
    //            PropertyChanges { target: rect; x: 50; y: 50 }
    //        }

    //        transitions: Transition {
    //            NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad }
    //        }
    //    }













//09334673769
