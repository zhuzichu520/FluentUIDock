import QtQuick
import FluentUI.Controls
import FluentUI.impl

Item {
    id: control
    anchors.fill: parent
    FluentUI.theme: Theme.of(control)
    readonly property QtObject kddwSeparator: parent
    readonly property bool isVertical: kddwSeparator ? kddwSeparator.isVertical : false

    Rectangle {
        implicitWidth: control.isVertical ? control.width : 10
        implicitHeight: control.isVertical ? 10 : control.height
        clip: true
        color:{
            if(!control.enabled){
                return control.FluentUI.theme.res.controlFillColorDisabled
            }else{
                if(mouseArea.pressed){
                    return control.FluentUI.theme.res.subtleFillColorTertiary
                }
                if(mouseArea.containsMouse){
                    return control.FluentUI.theme.res.subtleFillColorSecondary
                }
                return control.FluentUI.theme.res.subtleFillColorTransparent
            }
        }
        Rectangle{
            width: control.isVertical ? 26 : 4
            height: control.isVertical ? 4 : 26
            anchors.centerIn: parent
            color: control.FluentUI.theme.res.controlStrongStrokeColorDefault
            radius: 2
        }
    }

    MouseArea {
        id: mouseArea
        cursorShape: kddwSeparator ? (control.isVertical ? Qt.SizeVerCursor : Qt.SizeHorCursor)
                                   : Qt.SizeHorCursor
        anchors.fill: parent
        onPressed: {
            kddwSeparator.onMousePressed();
        }
        hoverEnabled: true
        onReleased: {
            kddwSeparator.onMouseReleased();
        }

        onPositionChanged: (mouse) => {
                               kddwSeparator.onMouseMoved(Qt.point(mouse.x, mouse.y));
                           }

        onDoubleClicked: {
            kddwSeparator.onMouseDoubleClicked();
        }
    }
}
