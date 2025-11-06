import QtQuick
import QtQuick.Window
import "qrc:/kddockwidgets/qtquick/views/qml/" as KDDW

KDDW.TitleBarBase {
    id: root

    // These two are just for unit-tests
    readonly property QtObject floatButton: floatButton
    readonly property QtObject closeButton: closeButton

    color: "#eff0f1"
    heightWhenVisible: 30

    function dpiSuffix() {
        // Since Qt's built-in @Nx doesn't support fractionals, we load the correct image manually
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

    function imagePath(id) {
        return "qrc:/img/" + id + dpiSuffix() + ".png";
    }

    Text {
        id: title
        text: root.title
        anchors {
            left: parent ? parent.left : undefined
            leftMargin: 5
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
            visible: root.minimizeButtonVisible
            imageSource: imagePath("min")
            onClicked: {
                root.minimizeButtonClicked();
            }
        }

        KDDW.TitleBarButton {
            id: floatButton
            visible: root.floatButtonVisible
            imageSource: imagePath("dock-float")
            onClicked: {
                root.floatButtonClicked();
                console.log(dpiSuffix())
            }
        }

        KDDW.TitleBarButton {
            id: maximizeButton
            visible: root.maximizeButtonVisible
            imageSource: root.maximizeUsesRestoreIcon ? imagePath("dock-float") : imagePath("max");
            onClicked: {
                root.maximizeButtonClicked();
            }
        }

        KDDW.TitleBarButton {
            id: closeButton
            enabled: root.closeButtonEnabled
            imageSource: imagePath("close")
            onClicked: {
                root.closeButtonClicked();
            }
        }
    }
}
