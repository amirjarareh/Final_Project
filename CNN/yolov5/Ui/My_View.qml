import QtQuick 2.10
import QtQuick.Controls 2.3
import QtLocation 5.9
import QtPositioning 5.6
import QtQuick.Extras 1.4


import "imports/ControlProject"


Rectangle {
    id:menuPage_Rect
    width: Constants.width
    height: Constants.height

    FontLoader { id: dastnevis; source: "fonts/danstevis.otf" }

    signal back_Page_My_View()
    property int capture_counter: 1
    property int record_counter: 1
    property int videoplay_flag: 0
    property bool myVideo_Change: false

    property bool record: false
    property string folder_show: "Manual"

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
            x: 130
            y: 472
            width: 656
            height: 200
            color: "#d9d9d9"
            radius: 5
            border.width: 3

            DelayButton {
                id: delayButton
                x: 8
                y: 47
                width: 102
                height: 107
                delay: 500
                visible: false
                text: qsTr("Connect")

                onCheckedChanged:{

                    quad_ip_item.visible = false
                    mode_item.visible = true
                    start_mode_item.visible = true
                    qmlToPyQt.connect_mode(checked)

                }
            }

            Item {
                id: mode_item
                x: 224
                y: 0
                width: 318
                height: 182

                visible: false


                ToggleButton {
                    id: toggleButton
                    x: 16
                    y: 34
                    width: 68
                    height: 60
                    text: "Hold"
                    onCheckedChanged:{

                        toggleButton1.checked = false
                        toggleButton2.checked = false
                        toggleButton3.checked = false
                        toggleButton4.checked = false
                        toggleButton5.checked = false
                        qmlToPyQt.mode_func("LOITER")
                    }
                }

                ToggleButton {
                    id: toggleButton1
                    x: 16
                    y: 114
                    width: 68
                    height: 60
                    text: qsTr("Brake")
                    onCheckedChanged:{

                        toggleButton.checked = false
                        toggleButton2.checked = false
                        toggleButton3.checked = false
                        toggleButton4.checked = false
                        toggleButton5.checked = false
                        qmlToPyQt.mode_func("BRAKE")
                    }
                }

                ToggleButton {
                    id: toggleButton2
                    x: 96
                    y: 34
                    width: 68
                    height: 60
                    text: qsTr("GUIDED")
                    onCheckedChanged: {
                        toggleButton1.checked = false
                        toggleButton.checked = false
                        toggleButton3.checked = false
                        toggleButton4.checked = false
                        toggleButton5.checked = false
                        qmlToPyQt.mode_func("GUIDED")
                    }


                }

                ToggleButton {
                    id: toggleButton3
                    x: 100
                    y: 113
                    width: 68
                    height: 60
                    text: qsTr("AltHold")
                    onCheckedChanged:{

                        toggleButton1.checked = false
                        toggleButton2.checked = false
                        toggleButton.checked = false
                        toggleButton4.checked = false
                        toggleButton5.checked = false
                        qmlToPyQt.mode_func("ALT_HOLD")
                    }
                }

                ToggleButton {
                    id: toggleButton4
                    x: 179
                    y: 34
                    width: 68
                    height: 60
                    text: qsTr("RTL")
                    onCheckedChanged:{

                        toggleButton1.checked = false
                        toggleButton2.checked = false
                        toggleButton3.checked = false
                        toggleButton.checked = false
                        toggleButton5.checked = false
                        qmlToPyQt.mode_func("RTL")
                    }

                }

                ToggleButton {
                    id: toggleButton5
                    x: 179
                    y: 113
                    width: 68
                    height: 60
                    text: qsTr("Land")
                    onCheckedChanged:{

                        toggleButton1.checked = false
                        toggleButton2.checked = false
                        toggleButton3.checked = false
                        toggleButton4.checked = false
                        toggleButton.checked = false
                        qmlToPyQt.mode_func("LAND")
                    }
                }
            }

            Rectangle {
                id: rectangle2
                x: 490
                y: 14
                width: 140
                height: 168
                color: "#333"
                radius: 5

                Button {
                    id: startAnalyse6
                    x: 14
                    y: 22
                    width: 106
                    height: 64
                    checkable: true
                    text: qsTr("آنالیز")
                    font.family: dastnevis.name
                    font.pointSize: 14
                    checked : false

                    onClicked:{
                        if (checked == true){
                            videoAnalyse_Anime.running = true
                            videoAnalyse_Rect.opacity = 1
                            folder_show = "Analyze"
                        }
                        else{
                            videoAnalyse_Rect.opacity = 0
                            folder_show = "Manual"
                        }
                        qmlToPyQt.set_analyze(checked)

                    }
                }

                Button {
                    id: backButton
                    x: 14
                    y: 98
                    width: 106
                    height: 61
                    text: qsTr("برگشت")
                    font.family: dastnevis.name
                    font.pointSize: 14


                    onClicked:{
                        back_Page_My_View()
                        startAnalyse6.checked = false
                        back_Page_My_View()
                    }

                }
            }

            Item {
                id: start_mode_item
                x: 118
                y: 8
                width: 100
                height: 174
                visible: false

                DelayButton {
                    id: delayButton1
                    x: 15
                    y: 27
                    width: 70
                    height: 64
                    text: qsTr("ARM")
                    onCheckedChanged: {
                        qmlToPyQt.arm_func(checked)
                    }
                }

                DelayButton {
                    id: delayButton2
                    x: 15
                    y: 102
                    width: 70
                    height: 64
                    text: qsTr("TakeOff")
                    delay: 500
                    onCheckedChanged: {
                        qmlToPyQt.takeoff_func()
                    }
                }
            }

            Item {
                id: quad_ip_item
                x: 162
                y: 14
                width: 268
                height: 168
                visible: true
                Rectangle {
                    x: 490
                    y: 14
                    anchors.fill: parent
                    color: "#333"
                    radius: 5

                    Column{
                        x: 8
                        y: 8
                        width: 268
                        height: 168
                        spacing: 5

                        Row{
                            width: 268
                            height: 50
                            spacing: 5

                            TextField {
                                id: textField_ip
                                width: 178
                                height: 40
                                placeholderText: qsTr("127.0.0.1")
                            }

                            Label {
                                width: 65
                                font.pixelSize: 20
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                color: "#fdfdfd"
                                font.family: dastnevis.name
                                font.bold: true
                                text: qsTr("آی پی :")
                            }


                        }

                        Row{
                            width: 268
                            height: 50
                            spacing: 5

                            TextField {
                                id: textField_port
                                width: 178
                                height: 40
                                placeholderText: qsTr("8080")
                            }

                            Label {

                                width: 65
                                font.pixelSize: 20
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                color: "#fdfdfd"
                                font.family: dastnevis.name
                                font.bold: true
                                text: qsTr("پورت : ")
                            }
                        }
                    }

                    Button {
                        x: 8
                        y: 120
                        width: 252
                        height: 40
                        font.family: dastnevis.name
                        font.pixelSize: 15
                        text: qsTr("اعمال تنظیمات")

                        onClicked: {
                            if(textField_ip.text !== "" && textField_port !== ""){
                                delayButton.visible = true
                                qmlToPyQt.set_ip_port(textField_ip.text,textField_port.text)
                            }
                        }
                    }




                }
            }

        }

    }

    Rectangle {
        id: logo_backgrond
        x: 1173
        y: 9
        width: 91
        height: 94
        color: "#ffffff"
        radius: 95
        opacity: 0.7
        border.width: 5
    }


    Image {
        id: logo
        x: 1192
        y: 30
        width: 54
        height: 53
        source: "file/logo.png"

        RotationAnimation on rotation {
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 1000
        }


    }


    Rectangle {
        id: videoplay_Rect
        x: 281
        y: 109
        width: 666
        height: 326
        color: "#d9d9d9"

        radius: 10
        anchors.horizontalCenterOffset: -179
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 5
        anchors.margins: 5

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            onClicked: {
                if(videoplay_flag == 0){
                    videoplay_Rect.color  = "#999"
                    videoplay_flag = 1
                    videoplay_image.anchors.fill =  parent
                }
                else{
                    videoplay_flag = 0
                    videoplay_image.source =  "file/videoplay.png"
                    videoplay_image.width =  112
                    videoplay_image.height = 86
                    videoplay_image.x = 281
                    videoplay_image.y = 113
                }
            }
        }

        Image {
            id: videoplay_image
            x: 281
            y: 113
            width: 112
            height: 86
            anchors.horizontalCenterOffset: -14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 8
            anchors.verticalCenter: parent.verticalCenter
            source: "file/videoplay.png"
            
            
            // source: "http://192.168.1.183:8080/photo.jpg"

        }


    }

    Rectangle {
        id: videomap_Rect
        x: 811
        y: 109
        width: 412
        height: 563
        color: "#fff"
        radius: 10
        border.width: 5


        Plugin {
            id: mapPlugin
            name: "osm"//other = "osm","mapboxgl"
        }

        Rectangle{
            id: videoAnalyse_Rect
            anchors.fill: parent
            anchors{
                margins: 5
            }
            opacity:0
            color:"#d9d9d9"

            OpacityAnimator {
                id: videoAnalyse_Anime
                target: videoAnalyse_Rect
                from: 0;
                to: 1;
                duration: 500
                running: false
            }

            Image{
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "file/videoplay.png"
            }
        }



        Rectangle {
            id: shatter_rect
            x: -747
            y: 116
            width: 50
            height: 130
            color: "#d9d9d9"
            radius: 5
            border.width: 2

            Image {
                id: record_video
                x: 8
                y: 22
                width: 34
                height: 34
                source: "images/cred.png"
                fillMode: Image.PreserveAspectFit

                MouseArea{
                    anchors.fill : parent
                    onClicked: {
                        if(record===true){
                            record=false
                            record_video_t.running = false
                            record_video.width = 34
                            record_video.height = 34
                        }
                        else{
                            record=true
                            record_video_t.running = true
                        }
                    }
                }

                Timer{
                    id:record_video_t
                    repeat: true
                    running: false
                    interval: 200
                    onTriggered: {
                        if(record_video.width===34){
                            record_video.width = 36
                            record_video.height = 36
                        }
                        else{
                            record_video.width = 34
                            record_video.height = 34
                        }
                    }
                }


            }

            Image {
                id: record_picure
                x: -1
                y: 68
                width: 52
                height: 46
                source: "images/tpred.png"
                fillMode: Image.PreserveAspectFit
                MouseArea{
                    anchors.fill : parent
                    onClicked: {
                        qmlToPyQt.startCapture(true,capture_counter)
                        record_picure.source = "images/tpblue.png"
                        record_picure_t.running = true
                        capture_counter++
                    }
                }

                Timer{
                    id:record_picure_t
                    repeat: false
                    running: false
                    interval: 500
                    onTriggered: {
                        record_picure.source = "images/tpred.png"
                    }
                }
            }

        }

        Map {
            id:map
            anchors.rightMargin: 8
            anchors.bottomMargin: 8
            anchors.leftMargin: 8
            anchors.topMargin: 8
            anchors.fill: parent
            plugin: mapPlugin
            center: QtPositioning.coordinate("27.219392" , "56.336560") // BND
            zoomLevel: 16
            anchors{
                margins: 12
            }

            MapQuickItem {
                id: marker1
                anchorPoint.x: image1.width/2
                anchorPoint.y: image1.height

                coordinate {
                    latitude: map.center.latitude
                    longitude: map.center.longitude
                }
                sourceItem: Image {
                    id: image1
                    width: 30
                    height: 30
                    source: "file/marker3.png"
                }
            }
        }

        Item {
            x: 284
            y: 18
            width: 111
            height: 131

            Rectangle {
                id: start_rect
                width: 108
                height: 130
                color: "#666"
                radius: 5
                opacity: 0.8
            }

            Label {
                x: 8
                y: 39
                width: 35
                height: 22
                font.pixelSize: 15
                color: "#fdfdfd"
                text: "lat: "+parseInt(map.center.latitude*1000000)/1000000
            }

            Label {
                x: 8
                y: 17
                width: 43
                height: 22
                font.pixelSize: 15
                color: "#fdfdfd"
                text: "lon: "+parseInt(map.center.longitude*1000000)/1000000
            }

            Button {
                id: start_mission
                x: 4
                y: 82
                text: qsTr("رفتن به نقطه")
                font.family: dastnevis.name

            }

        }



    }

    Timer{
        interval: 150
        repeat: true
        running: true

        onTriggered:{
            
            if (myVideo_Change == false && videoplay_flag == 1){
                videoplay_image.source = "Data-Image/"+folder_show+"/frame1.jpg"
                videoplay_image.source = "Data-Image/"+folder_show+"/frame0.jpg"
//                myVideo_Change = true
            }

//            else if(myVideo_Change == true && videoplay_flag == 1){
//                videoplay_image.source = "Data-Image/"+folder_show+"/frame1.jpg"
//                myVideo_Change = false
//            }
        }
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
