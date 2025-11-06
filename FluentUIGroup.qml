import QtQuick
import QtQuick.Layouts
import FluentUI.Controls
import FluentUI.impl
import com.kdab.dockwidgets
import "qrc:/kddockwidgets/qtquick/views/qml/" as KDDW

Rectangle {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property QtObject groupCpp
    readonly property QtObject titleBarCpp: groupCpp ? groupCpp.titleBar : null
    readonly property int nonContentsHeight: (titleBar.item ? titleBar.item.heightWhenVisible : 0) + tabbar.implicitHeight + (2 * contentsMargin) + titleBarContentsMargin
    property int contentsMargin: isMDI ? 2 : 1
    property int titleBarContentsMargin: 1
    property int mouseResizeMargin: 8
    readonly property bool isMDI: groupCpp && groupCpp.isMDI
    readonly property bool resizeAllowed: control.isMDI && !_kddwHelpers.isDragging && _kddwDockRegistry && (!_kddwHelpers.groupViewInMDIResize || _kddwHelpers.groupViewInMDIResize === groupCpp)
    property alias tabBarHeight: tabbar.height
    readonly property bool hasCustomMouseEventRedirector: false
    readonly property bool isFixedHeight: groupCpp && groupCpp.isFixedHeight
    readonly property bool isFixedWidth: groupCpp && groupCpp.isFixedWidth
    readonly property bool tabsAtTop: !groupCpp || !groupCpp.tabsAtBottom
    anchors.fill: parent
    radius: 4
    color: "transparent"
    border {
        color: control.FluentUI.theme.res.dividerStrokeColorDefault
        width: 1
    }
    onGroupCppChanged: {
        if (groupCpp) {
            groupCpp.setStackLayout(stackLayout);
        }
    }
    onNonContentsHeightChanged: {
        if (groupCpp)
            groupCpp.geometryUpdated();
    }
    MouseArea {
        anchors.fill: parent
        KDDW.MDIResizeHandlerHelper {
            anchors {
                left: parent ? parent.left : undefined
                top: parent ? parent.top : undefined
                bottom: parent ? parent.bottom : undefined
            }
            width: resizeMargin
            z: 100
            groupCpp: control.groupCpp
            resizeAllowed: control.resizeAllowed && !control.isFixedWidth
            resizeMargin: control.mouseResizeMargin
            cursorPosition: KDDockWidgets.CursorPosition_Left
        }
        KDDW.MDIResizeHandlerHelper {
            anchors {
                right: parent ? parent.right : undefined
                top: parent ? parent.top : undefined
                bottom: parent ? parent.bottom : undefined
            }
            width: resizeMargin
            z: 100
            groupCpp: control.groupCpp
            resizeAllowed: control.resizeAllowed && !control.isFixedWidth
            resizeMargin: control.mouseResizeMargin
            cursorPosition: KDDockWidgets.CursorPosition_Right
        }
        KDDW.MDIResizeHandlerHelper {
            anchors {
                right: parent ? parent.right : undefined
                top: parent ? parent.top : undefined
                left: parent ? parent.left : undefined
            }
            height: resizeMargin
            z: 100
            groupCpp: control.groupCpp
            resizeAllowed: control.resizeAllowed && !control.isFixedHeight
            resizeMargin: control.mouseResizeMargin
            cursorPosition: KDDockWidgets.CursorPosition_Top
        }
        KDDW.MDIResizeHandlerHelper {
            anchors {
                right: parent ? parent.right : undefined
                left: parent ? parent.left : undefined
                bottom: parent ?  parent.bottom : undefined
            }
            height: resizeMargin
            z: 100
            groupCpp: control.groupCpp
            resizeAllowed: control.resizeAllowed && !control.isFixedHeight
            resizeMargin: control.mouseResizeMargin
            cursorPosition: KDDockWidgets.CursorPosition_Bottom
        }
        KDDW.MDIResizeHandlerHelper {
            anchors {
                right: parent ? parent.right : undefined
                bottom: parent ? parent.bottom : undefined
            }
            height: width
            width: resizeMargin
            z: 101
            groupCpp: control.groupCpp
            resizeAllowed: control.resizeAllowed
            resizeMargin: control.mouseResizeMargin
            cursorPosition: KDDockWidgets.CursorPosition_Bottom | KDDockWidgets.CursorPosition_Right
        }
        KDDW.MDIResizeHandlerHelper {
            anchors {
                left:  parent ? parent.left : undefined
                top:  parent ? parent.top : undefined
            }
            height: width
            width: resizeMargin
            z: 101
            groupCpp: control.groupCpp
            resizeAllowed: control.resizeAllowed
            resizeMargin: control.mouseResizeMargin
            cursorPosition: KDDockWidgets.CursorPosition_Top | KDDockWidgets.CursorPosition_Left
        }
        KDDW.MDIResizeHandlerHelper {
            anchors {
                right: parent ? parent.right : undefined
                top: parent ? parent.top : undefined
            }
            height: width
            width: resizeMargin
            z: 101
            groupCpp: control.groupCpp
            resizeAllowed: control.resizeAllowed
            resizeMargin: control.mouseResizeMargin
            cursorPosition: KDDockWidgets.CursorPosition_Top | KDDockWidgets.CursorPosition_Right
        }
        KDDW.MDIResizeHandlerHelper {
            anchors {
                left: parent ? parent.left : undefined
                bottom: parent ? parent.bottom : undefined
            }
            height: width
            width: resizeMargin
            z: 101
            groupCpp: control.groupCpp
            resizeAllowed: control.resizeAllowed
            resizeMargin: control.mouseResizeMargin
            cursorPosition: KDDockWidgets.CursorPosition_Left | KDDockWidgets.CursorPosition_Bottom
        }
    }
    Loader {
        id: titleBar
        readonly property QtObject titleBarCpp: control.titleBarCpp
        source: groupCpp ? _kddw_widgetFactory.titleBarFilename() : ""
        anchors {
            top:  parent ? parent.top : undefined
            left: parent ? parent.left : undefined
            right: parent ? parent.right : undefined
            topMargin: control.titleBarContentsMargin
            leftMargin: control.titleBarContentsMargin
            rightMargin: control.titleBarContentsMargin
        }
    }
    Loader {
        id: tabbar
        readonly property QtObject groupCpp: control.groupCpp
        readonly property bool hasCustomMouseEventRedirector: control.hasCustomMouseEventRedirector
        source: groupCpp ? _kddw_widgetFactory.tabbarFilename() : ""
        function topAnchor() {
            if (control.tabsAtTop) {
                return (titleBar && titleBar.visible) ? titleBar.bottom
                                                      : (parent ? parent.top : undefined);
            } else {
                return undefined;
            }
        }
        anchors {
            left: parent ? parent.left : undefined
            right: parent ? parent.right : undefined
            top: topAnchor()
            bottom: control.tabsAtTop ? undefined : parent.bottom
            leftMargin: 1
            rightMargin: 1
        }
    }
    Item {
        id: stackLayout
        function bottomAnchor() {
            if (!parent)
                return undefined;

            if (control.tabsAtTop || !tabbar.visible)
                return parent.bottom;

            return tabbar.top;
        }
        anchors {
            left: parent ? parent.left : undefined
            right: parent ? parent.right : undefined
            top: (parent && tabbar.visible && control.tabsAtTop) ? tabbar.bottom : ((titleBar && titleBar.visible) ? titleBar.bottom : parent ? parent.top : undefined);
            bottom: bottomAnchor()
            leftMargin: control.contentsMargin
            rightMargin: control.contentsMargin
            bottomMargin: control.contentsMargin
        }
    }
}
