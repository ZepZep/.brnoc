/********************************************************************
This file is part of the KDE project.

Copyright (C) 2014 Aleix Pol Gonzalez <aleixpol@blue-systems.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/

import QtQuick 2.5
import QtMultimedia 5.6
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.workspace.keyboardlayout 1.0
import org.kde.plasma.private.sessions 2.0

Image {
    id: root
    
    source: "images/background.jpg"
    
    signal startFailingMain()
    
    //Adding rays
    Repeater {
        id: rays
        model: 9
        delegate: Ray {            
            anchors.top: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            
            triangleWidth: 140
            triangleHeight: 500
            stroke: false
            width: 150
            height: 800
            alpha: 1
            
            curAngle: 360/9*(index)
            
            rotating: true
            lenghtChanging: true
            glowing: true
        }
    }
    
    function login()
    {
        console.log("Unlocking!")
        authenticator.tryUnlock("brnoc")
    }
    
    Image
    {
        id: pus
        source: "images/iluminat.png"
        
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        
        width: 300
        fillMode: Image.PreserveAspectFit
        
        MouseArea
        {
            anchors.fill: parent
            focus: true
            
            Keys.onPressed: login()
            onClicked: login()
        }
    }
}
