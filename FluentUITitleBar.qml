import QtQuick
import QtQuick.Window
import QtQuick.Controls
import FluentUI.impl
import FluentUI.Controls
import "qrc:/kddockwidgets/qtquick/views/qml/" as KDDW

KDDW.TitleBarBase {
    id: control
    FluentUI.theme: Theme.of(control)
    FluentUI.iconFamily: FluentIcons.fontLoader.name
    readonly property QtObject floatButton: floatButton
    readonly property QtObject closeButton: closeButton
    color: control.FluentUI.theme.res.micaBackgroundColor
    heightWhenVisible: 30
    function dpiSuffix() {
        if (Screen.devicePixelRatio === 1) {
            return "";
        } else if (Screen.devicePixelRatio === 1.5) {
            return "-1.5x";
        } else if (Screen.devicePixelRatio === 2) {
            return "-2x";
        } else {
            return "";
        }
    }
    radius: 4

    function imagePath(id) {
        return "qrc:/img/" + id + dpiSuffix() + ".png";
    }

    Label {
        id: title
        text: control.title
        anchors {
            left: parent ? parent.left : undefined
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
    }

    Row {
        anchors {
            verticalCenter: parent ? parent.verticalCenter : undefined
            right: parent ? parent.right : undefined
            topMargin: 5
            bottomMargin: 5
            rightMargin: 2
        }

        KDDW.TitleBarButton {
            id: minimizeButton
            visible: control.minimizeButtonVisible
            imageSource: imagePath("min")
            onClicked: {
                control.minimizeButtonClicked();
            }
        }

        // KDDW.TitleBarButton {
        //     id: floatButton
        //     visible: control.floatButtonVisible
        //     imageSource: imagePath("dock-float")
        //     onClicked: {
        //         control.floatButtonClicked();
        //         console.log(dpiSuffix())
        //     }
        // }
        IconButton{
            id: floatButton
            property bool hover: hovered
            implicitWidth: 30
            implicitHeight: 30
            radius: 0
            icon.width: 12
            visible: control.floatButtonVisible
            icon.height: 12
            icon.name: FluentIcons.graph_TaskViewSettings
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Float")
            ToolTip.delay: Theme.tooltipDelay
            backgroundColor: {
                if(floatButton.down){
                    return control.FluentUI.theme.res.subtleFillColorTertiary
                }
                if(floatButton.hover){
                    return control.FluentUI.theme.res.subtleFillColorSecondary
                }
                return control.FluentUI.theme.res.subtleFillColorTransparent
            }
            onClicked: {
                control.floatButtonClicked();
            }
        }

        IconButton{
            id: maximizeButton
            property bool hover: hovered
            implicitWidth: 30
            implicitHeight: 30
            padding: 0
            icon.width: 12
            visible: control.maximizeButtonVisible
            icon.height: 12
            icon.name: control.maximizeUsesRestoreIcon ? FluentIcons.graph_ChromeRestore : FluentIcons.graph_ChromeMaximize
            ToolTip.visible: hovered
            ToolTip.text: control.maximizeUsesRestoreIcon ? qsTr("Restore") : qsTr("Maximized")
            ToolTip.delay: Theme.tooltipDelay
            backgroundColor: {
                if(maximizeButton.down){
                    return control.FluentUI.theme.res.subtleFillColorTertiary
                }
                if(maximizeButton.hover){
                    return control.FluentUI.theme.res.subtleFillColorSecondary
                }
                return control.FluentUI.theme.res.subtleFillColorTransparent
            }
            onClicked: {
                control.maximizeButtonClicked()
            }
        }
        IconButton{
            id: closeButton
            implicitWidth: 30
            implicitHeight: 30
            radius: 0
            icon.width: 10
            icon.height: 10
            enabled: control.closeButtonEnabled
            icon.name: FluentIcons.graph_ChromeClose
            FluentUI.textColor: closeButton.hovered ? Colors.white : control.FluentUI.theme.res.textFillColorPrimary
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Close")
            ToolTip.delay: Theme.tooltipDelay
            backgroundColor: {
                if(closeButton.pressed){
                    return Colors.red.dark()
                }
                if(closeButton.hovered){
                    return Colors.red.light()
                }
                return control.FluentUI.theme.res.subtleFillColorTransparent
            }
            onClicked: {
                control.closeButtonClicked();
            }
        }
    }
}
