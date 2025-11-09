import QtQuick
import FluentUI.Controls
import FluentUI.impl

Rectangle {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property var primaryColor: accentColor?.defaultBrushFor(control.FluentUI.dark)??"#00000000"
    color: Colors?.withOpacity(primaryColor,0.3)??"#00000000"
    radius: 1
    border {
        color: primaryColor
        width: 1
    }
    anchors.fill: parent
}
