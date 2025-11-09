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
#include <kddockwidgets/qtquick/views/ClassicIndicatorsWindow.h>

using namespace KDDockWidgets;
using namespace KDDockWidgets::Core;
using namespace KDDockWidgets::QtQuick;

class CustomViewFactory : public KDDockWidgets::QtQuick::ViewFactory
{
public:
    ~CustomViewFactory() override;
    QUrl titleBarFilename() const override{
        return QUrl(QStringLiteral("qrc:/qt/qml/FluentUIDock/FluentUITitleBar.qml"));
    }
    QUrl dockwidgetFilename() const override{
        return QUrl(QStringLiteral("qrc:/qt/qml/FluentUIDock/FluentUIDockWidget.qml"));
    }
    QUrl groupFilename() const override{
        return QUrl(QStringLiteral("qrc:/qt/qml/FluentUIDock/FluentUIGroup.qml"));
    }
    QUrl floatingWindowFilename() const override{
        return QUrl(QStringLiteral("qrc:/qt/qml/FluentUIDock/FluentUIFloatingWindow.qml"));
    }
    QUrl tabbarFilename() const override{
        return QUrl(QStringLiteral("qrc:/qt/qml/FluentUIDock/FluentUITabBar.qml"));
    }
    QUrl separatorFilename() const override{
        return QUrl(QStringLiteral("qrc:/qt/qml/FluentUIDock/FluentUISeparator.qml"));
    }
    QUrl rubberBandFilename() const override{
        return QUrl(QStringLiteral("qrc:/qt/qml/FluentUIDock/FluentUIRubberBand.qml"));
    }
    QUrl classicIndicatorsOverlayFilename() const override{
        return QUrl(QStringLiteral("qrc:/qt/qml/FluentUIDock/ClassicIndicatorsOverlay.qml"));
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
    config.setSeparatorThickness(10);
    config.setViewFactory(new CustomViewFactory());
    KDDockWidgets::QtQuick::Platform::instance()->setQmlEngine(qmlEngine(this));
}
