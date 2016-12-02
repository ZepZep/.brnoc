import QtQuick 2.2
import QtGraphicalEffects 1.0

Rectangle
{
    property string source;
    
    signal entered
    signal exited
    
    signal clicked
    
    id: button
    color: "transparent"
    
    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        
        onClicked: button.clicked()
    
        onEntered: {
            unHoweredAnim.running = false
            howeredAnim.running = true
            button.entered()
        }
        
        onExited: {
            howeredAnim.running = false
            unHoweredAnim.running = true
            button.exited()
        }
    }
        
    Image
    {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: button.source
    } 
    
    Glow {
        id: imgGlow
        visible: true
        anchors.fill: img
        samples: 17
        color: "#fff0f0f0"
        source: img
        opacity: 0


        ParallelAnimation {
            id: howeredAnim
            running: false
            NumberAnimation { 
                target: imgGlow
                property: "radius"
                to: 15
                duration: 100
            }
            NumberAnimation { 
                target: imgGlow
                property: "opacity"
                to: 0.5
                duration: 100
            }
        }
        
        ParallelAnimation {
            id: unHoweredAnim
            running: false
            NumberAnimation { 
                target: imgGlow
                property: "radius"
                to: 0
                duration: 500 
            }
            NumberAnimation { 
                target: imgGlow
                property: "opacity"
                to: 0
                duration: 500
            }
        }
    }
    
    Component.onCompleted: {
        imgGlow.radius = 0
    }
}

