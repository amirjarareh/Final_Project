#!/usr/bin/env python3
from PySide2.QtCore    import QObject, QUrl
from PySide2.QtCore    import Slot as Slot
from PySide2.QtCore    import Signal as Signal
from PySide2.QtQuick   import QQuickView
from PySide2.QtWidgets import QApplication
from dronekit import connect, VehicleMode , Attitude , LocationGlobal
import numpy as np
import sys, threading , time, urllib. request, os, datetime
import cv2
from mydetect import detect

vehicle = 0

class QmlToPyQt(QObject):
        def __init__(self):
            global vehicle
            QObject.__init__(self) 

            f = open("config.txt", "r")
            self.CPATH = []
            for line in f:
                self.CPATH.append(f.readline())
            f.close()

            self.ip = "192.168.43.1"
            # self.ip = "192.168.43.1"
            self.port = "7070"
            self.analyze_mode = "Manual"
            self.analyze_flag = False

            self.take_picure_flag = True
            self.take_picure_count = True

            getpicture = threading.Thread(target=self.receiveImage,args=())
            getpicture.start()
            self.getparam = threading.Thread(target=QmlToPyQt.connect_func,args=(self,))
            startAnalze = threading.Thread(target=QmlToPyQt.analyze,args=(self,))
            startAnalze.start()
        
        result = Signal(str,arguments=['offlineAnalyse'])

        @Slot(bool)
        def connect_mode(self,arg0):
            global vehicle
            self.connecting = arg0
            if arg0:
                self.getparam.start()
            else:
                self.getparam._stop()

        
        def connect_func(self):
            global vehicle
            connect_path = "{0}:{1}".format(self.ip,self.port)
            vehicle = connect(connect_path, wait_ready=True,timeout=5)
        
        @Slot(bool)
        def arm_func(self,armed):
            vehicle.armed  = True
        
        @Slot()
        def takeoff_func(self):
            try:
                vehicle.mode    = VehicleMode("GUIDED")
                vehicle.simple_takeoff(300)
            except print(0):
                pass
            
        
        @Slot(str)
        def mode_func(self,qmode):
            vehicle.mode = VehicleMode(qmode)
            
        @Slot(str)
        def offlineAnalyse(self,qurl):
            #arg1 if true =1 and false=1
            qurl = qurl.replace('\\', '/')
            qurl = list(qurl)
            qurlme = []
            for i in range(8):
                qurl[i] = ''
            source = ''.join(qurl)
            j = 0
            for i in range(len(qurl)):
                if qurl[i] == '/':
                    j=i
                print(qurl[i])
            qurlme = qurl[j:-1]
            qurlme.append(qurl[-1])
            qurlme = ''.join(qurlme)
            out_folder = "Ui/Saved/Analyze"
            detect(qsource=source,output_dir=out_folder)
            self.result.emit(qurlme)
        
        
        @Slot(bool,int)
        def startCapture(self,take,count):
            #arg1 if true =1 and false=1 and arg2 = counter with initial 1
            self.take_picure_flag = take
            self.take_picure_count = count

        @Slot(int,int)
        def recordVideo(self,arg1,arg2):
            #arg1 if true =1 and false=1 and arg2 = counter with initial 1
            print(arg1,arg2)
       
        @Slot(int)
        def refreshfiles(self,arg1):
            #arg1 if true =1
            print(arg1)

        @Slot(int)
        def startMission(self,arg1):
            #arg1 if true =1
            print(arg1)
        
        @Slot(str,str)
        def set_ip_port(self,qip,qport):
            self.ip = qip
            self.port = qport
        
        @Slot(bool)
        def set_analyze(self,checked):
            print(checked)
            self.analyze_flag = checked
        
        def analyze(self):
            source = 'Ui/Data-Image/Manual/frame0.jpg'
            flag = False
            while True:
                try:
                    if self.analyze_flag:
                        if not flag:
                            try:
                                source = 'Ui/Data-Image/Manual/frame0.jpg'
                            except:
                                try:
                                    source = 'Ui/Data-Image/Manual/frame1.jpg'
                                except:
                                    source = 'Ui/Data-Image/Manual/frame2.jpg'
                            
                        else:
                            source = 'Ui/Data-Image/Manual/frame1.jpg'
                        detect(qsource=source)
                except:
                    time.sleep(0.1)
                time.sleep(0.5)
            
            

        def receiveImage(self):
            try:
                count = 0
                while True:
                    req = urllib.request.urlopen('http://{0}:8080/shot.jpg'.format(self.ip))
                    arr = np.asarray(bytearray(req.read()), dtype=np.uint8)
                    img = cv2.imdecode(arr, -1)
                    img1 = img
                    cv2.imwrite("Ui/Data-Image/Manual/frame%d.jpg" % count, img)
                    # if self.take_picure_flag:
                    #     cv2.imwrite("Ui/Saved/Picture/frame%d.jpg" % str(datetime.datetime.now()), img)
                    if count==1:
                        count=0
                    else:
                        count=1
                    
                    if self.take_picure_flag:
                        self.take_picure_flag = False
                        cv2.imwrite("Ui/Saved/Picture/frame%d.jpg" % self.take_picure_count, img1)
                    time.sleep(0.01)
            except:
                pass

                                   

class MainWindow(QQuickView):
    def __init__(self):
        super().__init__()
        self.rootContext().setContextProperty("qmlToPyQt",qmlToPyQt)
        self.title = "GCS"
        self.setSource(QUrl('Ui/ControlProject.qml'))            
        self.show()


    

if __name__ == '__main__':
    app = QApplication(sys.argv)
    qmlToPyQt = QmlToPyQt()
    w = MainWindow()
    sys.exit(app.exec_())
