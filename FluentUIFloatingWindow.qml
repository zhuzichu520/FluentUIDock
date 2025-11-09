import QtQuick
import FluentUI.Controls
import FluentUI.impl
import "qrc:/kddockwidgets/qtquick/views/qml/" as KDDW

Rectangle {
    id: control
    readonly property QtObject floatingWindowCpp: parent
    readonly property QtObject titleBarCpp: floatingWindowCpp ? floatingWindowCpp.titleBar : null
    readonly property QtObject dropAreaCpp: floatingWindowCpp ? floatingWindowCpp.dropArea : null
    readonly property int titleBarHeight: titleBar.heightWhenVisible
    property int margins: 4
    FluentUI.theme: Theme.of(control)
    FluentUI.dark: Theme.dark
    FluentUI.primaryColor: Theme.primaryColor
    property var accentColor: FluentUI.theme.accentColor
    property var primaryColor: accentColor?.defaultBrushFor(control.FluentUI.dark)??"#00000000"
    anchors.fill: parent
    color: Theme.res.micaBackgroundColor
    border {
        color: control.primaryColor
        width: 2
    }

    onTitleBarHeightChanged: {
        if (floatingWindowCpp)
            floatingWindowCpp.geometryUpdated();
    }

    Loader {
        id: titleBar
        readonly property QtObject titleBarCpp: control.titleBarCpp
        readonly property int heightWhenVisible: item.heightWhenVisible
        source: _kddw_widgetFactory.titleBarFilename()
        FluentUI.dark: control.FluentUI.dark
        anchors {
            top:  parent ? parent.top : undefined
            left: parent ? parent.left : undefined
            right: parent ? parent.right : undefined
            margins: control.margins
        }
    }

    KDDW.DropArea {
        id: dropArea
        dropAreaCpp: control.dropAreaCpp
        anchors {
            left: parent ? parent.left : undefined
            right: parent ? parent.right : undefined
            top: titleBar.bottom
            bottom: parent ? parent.bottom : undefined

            leftMargin: control.margins
            rightMargin: control.margins
            bottomMargin: control.margins
        }

        onHeightChanged: {
            // console.log("FloatingWindow.qml.dropArea height changed to " + height + " ; control.height= " + control.height)
        }
    }

    onDropAreaCppChanged: {
        // Parent the cpp obj to the visual obj. So the user can style it
        if (dropAreaCpp) {
            //console.log("Setup start: height=" + height + "; dropArea.height=" + dropAreaCpp.height);
            dropAreaCpp.parent = dropArea;
            dropAreaCpp.anchors.fill = dropArea;
            //console.log("Setup done: height=" + height + "; dropArea.height=" + dropAreaCpp.height);
        }
    }

    onHeightChanged: {
        // console.log("FloatingWindow.qml.control height changed to " + height)
    }

    onWidthChanged: {
        // console.log("FloatingWindow.qml.control width changed to " + width)
    }
}
