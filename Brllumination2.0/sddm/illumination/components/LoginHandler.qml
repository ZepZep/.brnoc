import QtQuick 2.2
import QtMultimedia 5.6
import QtGraphicalEffects 1.0

import SddmComponents 2.0


Rectangle
{
    property variant geometry: screenModel.geometry(screenModel.primary)
    x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
    color: "transparent"
    transformOrigin: Item.Top
    
    property int sessionIndex: sessionModel.lastIndex

    MediaPlayer {
        id: playBoucnik
        source: "sound/boucnik.ogg"
    }
    
    TextConstants { id: textConstants }
    
    Connections {
        target: sddm
        onLoginSucceeded: {
            Qt.quit()
        }
        onLoginFailed: {
            passwdInput.echoMode = TextInput.Normal
            passwdInput.text = textConstants.loginFailed
            passwdInput.focus = true
            passwdInput.selectAll()
            passwdRect.visible = true
        }
    }
    
    EyeAvatar
    {
        id: eye
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        
        width: 300
        height: 150
    }
    
    Text
    {
        id: userNameText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: eye.bottom
        anchors.topMargin: 5
        width: 300
        height: eye.height/5 + 10
        
        font.pointSize: eye.height/5
        color: "black"
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }
    
    signal startFailing()
    
    Rectangle
    {
        id: passwdRect
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: userNameText.bottom
        anchors.topMargin: 15
        width: 200
        height: 35
        
        border.color: "#aa303030"
        border.width: 2
        color: "#50505070"
        
        TextInput {
            id: passwdInput
            anchors.fill: parent
            anchors.topMargin: 2
            anchors.bottomMargin: 2
            anchors.leftMargin: 5
            anchors.rightMargin: 5
                
            clip: true
            color: "black"
            //focus: true
            font.pointSize: 15
            selectByMouse: true
            selectionColor: "#22a8d6ec"
            echoMode: TextInput.Password
            verticalAlignment: TextInput.AlignVCenter
            
            Timer {
                interval: 200
                running: true
                repeat: false
                onTriggered: passwdInput.forceActiveFocus()
            }
            Timer
            {
                id: laterBoucTimer
                repeat: false
                interval: 200
                onTriggered: playBoucnik.play()
            }
            
            onAccepted: {
                sddm.login(userNameText.text, passwdInput.text, sessionIndex)
                startFailing()
                passwdRect.visible = false
                laterBoucTimer.running = true
            }
            Keys.onPressed:
            {
                if (echoMode != TextInput.Password)
                {
                    echoMode = TextInput.Password
                    text = ""
                }
            }
            
        }
    }

    ListView {
        id: usersList
        keyNavigationWraps: true
        model: userModel

        delegate: Item {
            id: item
            
            function select() {
                //console.log("selecting", name)
                usersList.currentIndex = index
                userNameText.text = name
                eye.avatarIconName = icon
            }
            
            Component.onCompleted: {
                //console.log("found ", name)
                if (name === userModel.lastUser) {
                    //console.log("going to select", name)
                    item.select()
                }
            }
        }
        //onCurrentItemChanged: currentItem.select()
    }
    
    //Component.onCompleted: passwdInput.forceActiveFocus()
}
