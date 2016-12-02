/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5

Image {
    id: root
    source: "images/background.jpg"
    fillMode: Image.PreserveAspectCrop

    property int stage

    onStageChanged: {
        if(stage<7)
        {
            rays.itemAt(stage-1).appear()
        
            for (var i=0; i<stage; i++) 
            {
                if(stage == 6) rays.itemAt(i).startInfirot()
                else rays.itemAt(i).stepUp()
            }
        }
    }
    
    Repeater {
        id: rays
        model: 6
        delegate: Ray {            
            anchors.top: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            
            triangleWidth: 100
            triangleHeight: 800
            stroke: false
            width: 100
            height: 800
            alpha: 0
            
            curAngle: 0//60*(index-1)
        }
    }
    
    Image
    {
        source: "images/iluminat.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        
        width: 300
        fillMode: Image.PreserveAspectFit
    }
}
