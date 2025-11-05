#include "FluentUIDock.h"

#include <QGuiApplication>
#include <QCursor>
#include <QPalette>
#include <QClipboard>
#include <QScreen>
#include <QIcon>

#include <kddockwidgets/Config.h>
#include <kddockwidgets/core/DockRegistry.h>
#include <kddockwidgets/qtquick/ViewFactory.h>
#include <kddockwidgets/qtquick/Platform.h>

class CustomViewFactory : public KDDockWidgets::QtQuick::ViewFactory
{
public:
    ~CustomViewFactory() override;
    QUrl titleBarFilename() const override{
        return QUrl("qrc:/qt/qml/FluentUIDock/MyTitleBar.qml");
    }
    QUrl separatorFilename() const override{
        return QUrl("qrc:/qt/qml/FluentUIDock/MySeparator.qml");
    }
    QUrl dockwidgetFilename() const override{
        return QUrl("qrc:/qt/qml/FluentUIDock/MyDockWidget.qml");
    }
};

CustomViewFactory::~CustomViewFactory() = default;

FluentUIDock::FluentUIDock(QObject *parent) : QObject{parent} {
}

void FluentUIDock::init(){
    KDDockWidgets::initFrontend(KDDockWidgets::FrontendType::QtQuick);
    auto &config = KDDockWidgets::Config::self();
    auto flags = config.flags() | KDDockWidgets::Config::Flag_TitleBarIsFocusable;
    config.setFlags(flags);
    config.setViewFactory(new CustomViewFactory());
    KDDockWidgets::QtQuick::Platform::instance()->setQmlEngine(qmlEngine(this));
    qDebug()<<"FluentUIDock::init";
}
