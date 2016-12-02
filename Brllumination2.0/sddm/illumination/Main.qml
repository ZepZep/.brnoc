import QtQuick 2.2
import QtMultimedia 5.6

import SddmComponents 2.0
import "components"


Image {
    id: root
    source: config.background

    signal startFailingMain()
    
    //Adding rays
    Repeater {
        property int rayCount: 12
        
        model: 9
        delegate: Ray {            
            anchors.top: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            
            triangleWidth: 50
            triangleHeight: 600
            stroke: false
            width: 100
            height: 800
            alpha: 0.5
            
            rotating: true
            lenghtChanging: true
            glowing: true
            
            curAngle: 360 / 9 * index
        }
    }
    
    //login    
    LoginHandler {
        id: loginFrame
        onStartFailing: startFailingMain()
    }
    
    //sessions
    SessionChooser
    {
        id: sessionFrame
        anchors.verticalCenter: parent.verticalCenter
        //anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        
        width: 200
        height: 570
        
        onCurrentIndexChanged: loginFrame.sessionIndex = currentIndex
    }
    
    //power
    PowerOptions
    {
        id: powerFrame
        anchors.verticalCenter: parent.verticalCenter
        
        anchors.left: parent.left
        
        width: 150
        height: 300
    }
}
