import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import "qrc:/kddockwidgets/qtquick/views/qml/" as KDDW

KDDW.TitleBarBase {
    id: control
    color: Theme.res.popupBackgroundColor
    border.width: 0
    heightWhenVisible: 50

    Label{
        font.bold: isFocused
        text: control.title
        anchors {
            left: parent.left
            leftMargin: 10
            verticalCenter: control.verticalCenter
        }
    }

    Row {
        id: buttonRow
        spacing: 10

        height: control.height - 20
        anchors {
            right: control.right
            rightMargin: 10
            verticalCenter: control.verticalCenter
        }

        Rectangle {
            id: floatButton
            visible: control.floatButtonVisible
            radius: 5
            color: isFocused ? "red" : "white"
            height: parent.height
            width: height

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    control.floatButtonClicked();
                }
            }
        }

        Rectangle {
            id: closeButton
            enabled: control.closeButtonEnabled
            radius: 5
            color: isFocused ? "cyan" : "green"
            height: parent.height
            width: height

            Text {
                anchors.centerIn: parent
                text: "X"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    control.closeButtonClicked();
                }
            }
        }
    }
}
