import QtQuick
import FluentUI.impl
import FluentUI.Controls

Item {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    readonly property QtObject dockWidgetCpp: parent
    anchors.fill: parent
}
