import QtQuick 2.2
import QtMultimedia 5.6
import QtGraphicalEffects 1.0

import SddmComponents 2.0


Rectangle
{
    property string avatarIconName: "face"
    
    width: eyeLeft.width *2
    height: eyeLeft.height
    
    color: "#00000000"
    
    Image
    {
        source: "img/eyePart.png"
        id: eyeLeft
        
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        
        anchors.right: parent.horizontalCenter 
        anchors.verticalCenter: parent.verticalCenter
        
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: { 
                usersList.decrementCurrentIndex()
                usersList.currentItem.select()
            }
        }
    }
    
    Image
    {
        source: "img/eyePart.png"
        id: eyeRight
        rotation: 180
        
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        
        anchors.left: parent.horizontalCenter 
        anchors.verticalCenter: parent.verticalCenter
        
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: { 
                usersList.incrementCurrentIndex() 
                usersList.currentItem.select()
            }
        }
    }
    
    
    Canvas
    {
        id: avatar
        antialiasing: true
        anchors.fill: parent
        property string source: parent.avatarIconName
        property color m_strokeStyle: "#000000"
        property int irisWidth: height * 0.87
        
        signal clicked()
        
        onSourceChanged:
        {
            loadImage(source)
            if(isImageLoaded(source))
                avatar.requestPaint()            
        }
        onImageLoaded:
        {
            avatar.requestPaint()
        }
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height)
            ctx.beginPath()
            ctx.ellipse(width/2 - irisWidth/2, 0, irisWidth, height)
            ctx.clip()
            ctx.drawImage(source, width/2 - height/2, 0, height, height)
            ctx.strokeStyle = avatar.m_strokeStyle
            ctx.lineWidth = 6
            ctx.stroke()
        }

        MouseArea {
            height: eyeRight.height
            width: avatar.irisWidth
            anchors.horizontalCenter: parent.horizontalCenter
            
            hoverEnabled: true
            onEntered: {
                unHoweredAnim.running = false
                howeredAnim.running = true
            }
            onExited: {
                howeredAnim.running = false
                unHoweredAnim.running = true
            }
            onClicked: avatar.clicked()
        }

    
        Timer {
            id: delayPaintTimer
            repeat: false
            interval: 10
            onTriggered: avatar.requestPaint()
            running: true
        }
    }
    
    Glow {
            id: avatarGlow
            visible: true
            anchors.fill: avatar
            radius: 0
            samples: 17
            color: "#fff0f0f0"
            source: avatar
            opacity: 0

            
        ParallelAnimation {
            id: howeredAnim
            running: false
            NumberAnimation { 
                target: avatarGlow
                property: "radius"
                to: 20
                duration: 200
            }
            NumberAnimation { 
                target: avatarGlow
                property: "opacity"
                to: 0.3
                duration: 200
            }
        }
        
        ParallelAnimation {
            id: unHoweredAnim
            running: false
            NumberAnimation { 
                target: avatarGlow
                property: "radius"
                to: 0
                duration: 500 
            }
            NumberAnimation { 
                target: avatarGlow
                property: "opacity"
                to: 0
                duration: 500
            }
        }
        
    }


}
