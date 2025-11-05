import QtQuick
import com.kdab.dockwidgets as KDDW

KDDW.DockingArea {
    id: control

    function addDockWidget2(dockWidget,location){
        this.addDockWidget(dockWidget, KDDW.KDDockWidgets.Location_OnBottom);
    }
}
