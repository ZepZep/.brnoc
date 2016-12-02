import QtQuick 2.2

import SddmComponents 2.0

ListView {
    id: sessionView
    
    model: sessionModel
    currentIndex: sessionModel.lastIndex
    
    spacing: 0
    clip: true
    opacity: 0
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            animHideView.running = false
            animShowView.running = true
        }
        onExited: {
            animShowView.running = false
            animHideView.running = true
        }
        propagateComposedEvents: true
    }
    
    keyNavigationWraps: true
    
    highlight: Rectangle { color: "lightsteelblue"; opacity: 0.3; radius: 5 }
    highlightRangeMode: ListView.StrictlyEnforceRange
    preferredHighlightBegin: 200; preferredHighlightEnd: 200
    highlightFollowsCurrentItem: true
    
    delegate: Rectangle {
        
        width: 160
        height: 190
        
        color: "transparent"
        
        MouseArea {
            anchors.fill: parent
            onClicked: 
            {
                currentIndex = index
            }
        }
        
        Image {
            id: sessImage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: -5
            
            width: 150
            height: 150
            
            source: "img/session/defaultSession.png"
        }

        Text {
            anchors.top: sessImage.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: -10
            
            width: 150
            height: 40
            
            text: name
            
            color: "white"
            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
        }
        
        Keys.onUpPressed: {
            sessionView.decrementCurrentIndex()
        }
        Keys.onDownPressed: {
            sessionView.incrementCurrentIndex()
        }
    }
    
    focus: true
    
    add: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
        NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
    }


    Component.onCompleted:
    {
        forceLayout()
    }
    
    PropertyAnimation on opacity
    {
        id: animShowView
        running: false
        to: 1
        duration: 500
    }
    
    PropertyAnimation on opacity
    {
        id: animHideView
        running: false
        to: 0
        duration: 500
    }
}
