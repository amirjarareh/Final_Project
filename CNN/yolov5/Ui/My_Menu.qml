import QtQuick 2.10
import "imports/ControlProject"
import QtQuick.Controls 2.3

Rectangle {
    id: menuPage_Rect
    width: Constants.width
    height: Constants.height

    FontLoader { id: dastnevis; source: "fonts/danstevis.otf" }

    signal real_Page_Menu()
    signal analyze_Page_Menu()

    OpacityAnimator {
        target: menuPage_Rect
        from: 0;
        to: 1;
        duration: 500
        running: true
    }


    Image {
        id: background
        x: 342
        y: 195
        anchors.fill: parent

        fillMode: Image.Tile
        source: "file/back.png"


        Rectangle {
            id: rectangle
            x: 260
            y: 218
            width: 836
            height: 434
            color: "#fdfdfd"
            opacity: 0.5
            border.width: 10
            radius: 20
        }


        Button {
            id: button
            x: 389
            y: 256
            width: 578
            height: 60
            text: qsTr("نمایش بر خط")
            font.family: dastnevis.name
            font.pointSize: 18

            onClicked: {
                real_Page_Menu()
            }
        }

        Button {
            id: button1
            x: 389
            y: 340
            width: 578
            height: 62
            text: qsTr("بررسی و آنالیز داده ها")
            font.family: dastnevis.name
            font.pointSize: 18

            onClicked: {
                analyze_Page_Menu()
            }
        }

        Rectangle {
            id: rectangle1
            x: 389
            y: 486
            width: 580
            height: 72
            color: "#d6d6d6"
            border.width: 3
            radius: 10
            opacity: 0.9
        }

        Text {
            id: element
            x: 516
            y: 510
            width: 391
            height: 66
            text: qsTr("تهیه شده توسط : حسن ذاکری ، امیرحسین جراره ، ابولفضل منافی")
            font.pixelSize: 20
            font.family: dastnevis.name
        }
    }
}
