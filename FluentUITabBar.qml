import QtQuick
import QtQuick.Controls
import FluentUI.impl
import FluentUI.Controls
import "qrc:/kddockwidgets/qtquick/views/qml/" as KDDW

KDDW.TabBarBase {
    id: control
    FluentUI.theme: Theme.of(control)
    function getInternalListView() {
        for(var i = 0; i < tabBar.children.length; ++i) {
            if (tabBar.children[i].toString().startsWith("QQuickListView"))
                return tabBar.children[i]
        }
        console.warn("Couldn't find the internal ListView")
        return null
    }
    function getTabAtIndex(index) {
        var listView = getInternalListView()
        var content = listView.children[0]
        var curr = 0
        for (var i = 0; i < content.children.length; ++i) {
            var candidate = content.children[i]
            if (typeof candidate.tabIndex == "undefined") {
                continue
            }
            if (curr === index)
                return candidate

            curr++
        }
        if (index < listView.children.length)
            return listView.children[0].children[index]
        return null
    }
    function getTabIndexAtPosition(globalPoint) {
        var listView = getInternalListView()
        var content = listView.children[0]
        for (var i = 0; i < content.children.length; ++i) {
            var candidate = content.children[i]
            if (typeof candidate.tabIndex == "undefined") {
                continue
            }
            var localPt = candidate.mapFromGlobal(globalPoint.x, globalPoint.y)
            if (candidate.contains(localPt)) {
                return i
            }
        }
        return tabBar.currentIndex
    }
    implicitHeight: tabBar.implicitHeight
    onCurrentTabIndexChanged: {
        tabBar.currentIndex = control.currentTabIndex
    }
    SegmentedControl {
        id: tabBar
        FluentUI.radius: 0
        width: parent.width
        position: (control.groupCpp && control.groupCpp.tabsAtBottom) ? TabBar.Footer : TabBar.Header
        onCurrentIndexChanged: {
            control.currentTabIndex = this.currentIndex
        }
        Connections {
            target: control.groupCpp
            function onCurrentIndexChanged() {
                control.currentTabIndex = groupCpp.currentIndex
            }
        }
        Repeater {
            model: control.groupCpp ? control.groupCpp.tabBar.dockWidgetModel : 0
            SegmentedButton {
                readonly property int tabIndex: index
                text: title
                width: Math.max(Math.min(140,tabBar.width/tabBar.count),48)
            }
        }
    }
}
