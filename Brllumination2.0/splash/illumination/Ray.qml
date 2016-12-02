import QtQuick 2.2
import QtGraphicalEffects 1.0

Canvas {
    id: triangle
    antialiasing: true
    
    property real curAngle: 0
    property real setAngle: 0
    
    property bool glowing: true

    property int triangleWidth: 40
    property int triangleHeight: 600
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
    onCurAngleChanged: requestPaint();
    
//     Rectangle
//     {
//         anchors.fill: parent
//     }
    
    onPaint: {
        var ctx = getContext("2d");
        ctx.save();
        
        var gradient = ctx.createLinearGradient(0, 0, 0, 400);
        gradient.addColorStop(0.25, "#00ffffff");
        gradient.addColorStop(0.4, "#10ffffff");
        gradient.addColorStop(1, "#ffffffff");
        
        ctx.clearRect(0,0,triangle.width, triangle.height);
        ctx.strokeStyle = triangle.strokeStyle;
        ctx.lineWidth = triangle.lineWidth
        ctx.fillStyle = gradient
        ctx.globalAlpha = triangle.alpha
        ctx.beginPath();

        ctx.translate( (0.5 *width - 0.5*triangleWidth), 0)

        // draw the triangle
        ctx.moveTo(triangleWidth/2, 500); // left point of triangle
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
    }
    
    transform: Rotation { origin.x: width/2; origin.y: 0; angle: curAngle}
    
    function appear()
    {
        growAnim.running = true
        alpha = 0.5
    }
    
    function stepUp()
    {
        rotAnim.running = false
        setAngle += 60
        rotAnim.running = true
    }
    
    function startInfirot()
    {
        rotAnim.running = false
        infiRot.running = true
    }
    
    RotationAnimation on curAngle{
        id: rotAnim
        running: false
        from: curAngle
        to: setAngle
        duration: 2500
        easing.type: Easing.OutCubic
    }
    
    RotationAnimation on curAngle{
        id: infiRot
        running: false
        loops: Animation.Infinite
        from: curAngle
        to: curAngle + 60
        duration: 3000
    }
    
    NumberAnimation on triangleHeight{
        id: growAnim
        running: false
        from: 0
        to: 200
        duration: 1000
        easing.type: Easing.OutCubic
    }
} 
