import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.3

import "imports/ControlProject"


Rectangle {
    id: menuPage_Rect
    width: Constants.width
    height: Constants.height

    signal back_Page_Analyze()
    property int video_number: 0
    property string img_path: ""

    FontLoader { id: dastnevis; source: "fonts/danstevis.otf" }

    OpacityAnimator {
        target: menuPage_Rect
        from: 0;
        to: 1;
        duration: 500
        running: true
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        visible : false
        nameFilters: [ "Image files (*.jpg *.png *.jpeg )","Video files(*.mp4 *.avi)", "All files (*)" ]

    }

    Image {
        id: background
        x: 342
        y: 195
        anchors.fill: parent

        fillMode: Image.Tile
        source: "file/back.png"
    }

    Rectangle {
        id: rectangle
        x: 428
        y: 24
        width: 830
        height: 666
        color: "#ffffff"
        radius: 10
        border.width: 10
        opacity: 0.5
    }

    Image {
        id: runimage
        x: 710
        y: 288
        width: 256
        height: 144
        source: "file/videoplay.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: analyzed_image
        anchors.fill: parent
        visible: false
        source: "Saved/Analyze"+img_path
        anchors.bottomMargin: 30
        anchors.topMargin: 24
        anchors.rightMargin: 36
        anchors.leftMargin: 442
        fillMode: Image.PreserveAspectFit
    }


    Rectangle {
        id: rectangle1
        x: 8
        y: 24
        width: 370
        height: 666
        color: "#ffffff"
        radius: 10
        border.width: 10
        opacity: 0.5
    }

    Button {
        id: button
        x: 31
        y: 458
        width: 324
        height: 88
        text:"آنالیز"
        font.family: dastnevis.name
        font.pointSize: 18

        onClicked:{
            if(fileDialog.fileUrl !== '')
                qmlToPyQt.offlineAnalyse(fileDialog.fileUrl)
        }
    }


    Button {
        id: btn_Refresh
        x: 31
        y: 64
        width: 324
        height: 43
        text: qsTr("بارگذاری فایل")
        font.family: dastnevis.name
        font.pointSize: 18

        onClicked: {
            fileDialog.visible = true
        }
    }

    Button {
        id: btn_Back_To_Menu
        x: 31
        y: 566
        width: 324
        height: 88
        text: qsTr("بازگشت به فهرست")
        font.family: dastnevis.name
        font.pointSize: 18

        onClicked:{
            back_Page_Analyze()
            cbItems.clear()
            video_number = 0
        }
    }

    Component.onCompleted:  {

    }

    Connections{
        target: qmlToPyQt
        onResult: {img_path = offlineAnalyse;analyzed_image.visible = true}
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
