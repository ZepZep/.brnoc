import QtQuick 2.2

import SddmComponents 2.0


Rectangle
{
    property double sizeMultiplayer: 0.5
    property bool hidden: true
    
    id: powerRect
    
    color: "transparent"
    opacity: 0
    
    function show()
    {
        animHideView.running = false
        animShowView.running = true
    }
    
    function hide()
    {
        animShowView.running = false
        animHideView.running = true
    }
    
    onHiddenChanged:
    {
        if(!hidden) show()
        else hide()
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: hidden = false
        onExited: hidden = true
    }
    
    BlurImageButton
    {
        id: shutdownButton
        source: "img/shutdown.png"
        
        anchors.bottom: rebootButton.top
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.width*sizeMultiplayer
        width: parent.width*sizeMultiplayer
        
        onEntered: hidden = false
        onExited: hidden = true
        
        onClicked: sddm.powerOff()
    }
    
    BlurImageButton
    {
        id: rebootButton
        source: "img/restart.png"
        
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.width*sizeMultiplayer
        width: parent.width*sizeMultiplayer
        
        onEntered: hidden = false
        onExited: hidden = true
        
        onClicked: sddm.reboot()
    }
    
    BlurImageButton
    {
        id: suspendButton
        source: "img/suspend.png"
        
        anchors.top: rebootButton.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.width*sizeMultiplayer
        width: parent.width*sizeMultiplayer
        
        onEntered: hidden = false
        onExited: hidden = true
        
        onClicked: sddm.suspend()
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
