import QtQuick
import FluentUI.impl
import FluentUI.Controls
import com.kdab.dockwidgets

Loader {
  id: control
  property int indicatorType: KDDockWidgets.DropLocation_None
  property var accentColor: FluentUI.theme.accentColor
  property var primaryColor: accentColor?.defaultBrushFor(control.FluentUI.dark)??"#00000000"
  property var normalColor: Colors?.withOpacity(primaryColor,0.5)??"#00000000"
  property var solidOpacity: isHovered ? 1 : 0.3
  readonly property bool isHovered: _kddw_overlayWindow && _kddw_overlayWindow.currentDropLocation === indicatorType
  width: 64
  height: 64
  FluentUI.theme: Theme.of(control)
  sourceComponent: {
    if(indicatorType === KDDockWidgets.DropLocation_OutterLeft){
      return comp_Left
    }
    if(indicatorType === KDDockWidgets.DropLocation_OutterRight){
      return comp_Right
    }
    if(indicatorType === KDDockWidgets.DropLocation_OutterTop){
      return comp_Top
    }
    if(indicatorType === KDDockWidgets.DropLocation_OutterBottom){
      return comp_Bottom
    }
    if(indicatorType === KDDockWidgets.DropLocation_Left){
      return comp_Left
    }
    if(indicatorType === KDDockWidgets.DropLocation_Right){
      return comp_Right
    }
    if(indicatorType === KDDockWidgets.DropLocation_Top){
      return comp_Top
    }
    if(indicatorType === KDDockWidgets.DropLocation_Bottom){
      return comp_Bottom
    }
    if(indicatorType === KDDockWidgets.DropLocation_Center){
      return comp_Center
    }
    return undefined
  }

  Component{
    id: comp_Left
    Rectangle{
      color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
      radius: 4
      border.width: 1
      border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
      Rectangle{
        radius: 4
        width: 40
        height: 44
        color: parent.color
        anchors.centerIn: parent
        border.width: 1
        border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
        Rectangle{
          width: 20
          height: 36
          border.width: 2
          radius: 2
          opacity: control.solidOpacity
          border.color: control.primaryColor
          color: control.normalColor
          anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
          }
        }
      }
    }
  }

  Component{
    id: comp_Right
    Rectangle{
      color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
      radius: 4
      border.width: 1
      border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
      Rectangle{
        radius: 4
        width: 40
        height: 44
        color: parent.color
        anchors.centerIn: parent
        border.width: 1
        border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
        Rectangle{
          width: 20
          height: 36
          border.width: 2
          radius: 2
          opacity: control.solidOpacity
          border.color: control.primaryColor
          color: control.normalColor
          anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
          }
        }
      }
    }
  }

  Component{
    id: comp_Top
    Rectangle{
      color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
      radius: 4
      border.width: 1
      border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
      Rectangle{
        radius: 4
        width: 44
        height: 40
        color: parent.color
        anchors.centerIn: parent
        border.width: 1
        border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
        Rectangle{
          width: 36
          height: 20
          border.width: 2
          radius: 2
          opacity: control.solidOpacity
          border.color: control.primaryColor
          color: control.normalColor
          anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
          }
        }
      }
    }
  }

  Component{
    id: comp_Bottom
    Rectangle{
      color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
      radius: 4
      border.width: 1
      border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
      Rectangle{
        radius: 4
        width: 44
        height: 40
        color: parent.color
        anchors.centerIn: parent
        border.width: 1
        border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
        Rectangle{
          width: 36
          height: 20
          border.width: 2
          radius: 2
          opacity: control.solidOpacity
          border.color: control.primaryColor
          color: control.normalColor
          anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
          }
        }
      }
    }
  }

  Component{
    id: comp_Center
    Rectangle{
      color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
      radius: 4
      border.width: 1
      border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
      Rectangle{
        radius: 4
        width: 44
        height: 44
        color: parent.color
        anchors.centerIn: parent
        border.width: 1
        border.color: control.FluentUI.theme.res.surfaceStrokeColorDefault
        Rectangle{
          width: 32
          height: 32
          border.width: 2
          radius: 2
          opacity: control.solidOpacity
          border.color: control.primaryColor
          color: control.normalColor
          anchors.centerIn: parent
        }
      }
    }
  }
}
