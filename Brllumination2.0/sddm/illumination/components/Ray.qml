import QtQuick 2.2
import QtGraphicalEffects 1.0

Canvas {
    id: triangle
    antialiasing: true
    
    property bool rotating: false
    property bool infiRot: false
    property int rotationSpeed: 2 // deg/s
    property real curAngle: 0
    
    property bool lenghtChanging: false
    property int lenghtinigSpeed: 15 // px/s
    
    property bool glowing: false
    
    property bool failAnimating: false

    property int triangleWidth: 60
    property int triangleHeight: 60
    property color strokeStyle:  "#ffffff"
    property color fillStyle: "#ffffff"
    property int lineWidth: 3
    property bool fill: true
    property bool stroke: true
    property real alpha: 1.0

    onLineWidthChanged:requestPaint();
    onFillChanged:requestPaint();
    onStrokeChanged:requestPaint();
    onTriangleHeightChanged: requestPaint();

    onPaint: {
        var ctx = getContext("2d");
        ctx.save();
        
        var gradient = ctx.createLinearGradient(0, 0, 0, 500);
        gradient.addColorStop(0.4, "#00ffffff");
        gradient.addColorStop(1, "#ffffffff");
        
        ctx.clearRect(0,0,triangle.width, triangle.height);
        ctx.strokeStyle = triangle.strokeStyle;
        ctx.lineWidth = triangle.lineWidth
        ctx.fillStyle = gradient
        ctx.globalAlpha = triangle.alpha
        ctx.beginPath();

        ctx.translate( (0.5 *width - 0.5*triangleWidth), 0)

        // draw the triangle
        ctx.moveTo(triangleWidth/2,triangleHeight); // left point of triangle
        ctx.lineTo(0, 0);
        ctx.lineTo(triangleWidth, 0);

        ctx.closePath();
        if (triangle.fill)
            ctx.fill();
        if (triangle.stroke)
            ctx.stroke();
        ctx.restore();
    }
    
    layer.enabled: glowing
    layer.effect: Glow {
        id: rayGlow
        samples: 12
        radius: 10
        color: "#77f0f0f0"
        transparentBorder: true
        
        onRadiusChanged:requestPaint()
        
        SequentialAnimation on color{
            id: failAnimationColor
            running: failAnimating
            alwaysRunToEnd: true
            ColorAnimation { to: "#ff0000" ; duration: 300}
            PauseAnimation { duration: 1400 }
            ColorAnimation { to: "#f0f0f0" ; duration: 300}
        }
        
        SequentialAnimation on radius{
            id: failAnimationGlow
            running: failAnimating
            alwaysRunToEnd: true
            PropertyAnimation { to: 20 ; duration: 700}
            PropertyAnimation { to: 10 ; duration: 1400}
        }

        SequentialAnimation on  opacity{
            id: failAnimationOpacity
            running: failAnimating
            alwaysRunToEnd: true
            PropertyAnimation { to: 0.95 ; duration: 700}
            PropertyAnimation { to: 0.5 ; duration: 1400}
        }
    }
    
    
    transform: Rotation { origin.x: width/2; origin.y: 0; angle: curAngle}
    
    RotationAnimation on curAngle{
        running: rotating
        from: curAngle
        to: 360
        duration: (360-curAngle)/rotationSpeed * 1000
        onStopped: if(rotating) infiRot = true
    }
    
    RotationAnimation on curAngle{
        running: infiRot
        loops: Animation.Infinite
        from: 0
        to: 360
        duration: 360/rotationSpeed * 1000
    }
    
    NumberAnimation on triangleHeight
    {
        property int goal: height/3*2 + Math.random() * 200 - 100
        property int speed: Math.abs(triangleHeight - goal) / lenghtinigSpeed * 1000;
        running: lenghtChanging
        to: goal
        duration: speed
        
        onStopped:
        {
            goal = height/3*2 + Math.random() * 200 - 100
            speed = Math.abs(triangleHeight - goal) / lenghtinigSpeed * 1000;
            running = true
        }
    }
    
    function startFailScene()
    {
        //console.log("starting to fail")
        infiRot = false
        rotating = false
        lenghtChanging = false
        
        failAnimating = true
        
        failedTimer.running = true
    }
    
    
    Connections {
        target: parent
        onStartFailingMain: {
           startFailScene()
        }
    }
    
    
    Timer {
        id: failedTimer
        repeat: false
        interval: 2100
        running: false
        onTriggered: 
        {
            rotating = true
            lenghtChanging = true
            
            failAnimating = false
            
            running = false            
        }
    }
} 
