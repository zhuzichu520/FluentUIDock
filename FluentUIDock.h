#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>
#include "stdafx.h"

#include "kddockwidgets/KDDockWidgets.h"

class FluentUIDock : public QObject {
    Q_OBJECT
    QML_NAMED_ELEMENT(FluentUIDock)
    QML_SINGLETON
private:
    explicit FluentUIDock(QObject *parent = nullptr);
    int windowBuildNumber();

public:
    SINGLETON(FluentUIDock)
    static FluentUIDock *create(QQmlEngine *, QJSEngine *) {
        return getInstance();
    }
    enum Location {
        Location_None = KDDockWidgets::Location::Location_None,
        Location_OnLeft = KDDockWidgets::Location::Location_OnLeft,
        Location_OnTop = KDDockWidgets::Location::Location_OnTop,
        Location_OnRight = KDDockWidgets::Location::Location_OnRight,
        Location_OnBottom = KDDockWidgets::Location::Location_OnBottom
    };
    Q_DECLARE_FLAGS(Locations, Location)
    Q_FLAG(Locations)
    enum MainWindowOption {
        MainWindowOption_None = KDDockWidgets::MainWindowOption::MainWindowOption_None,
        MainWindowOption_HasCentralGroup = KDDockWidgets::MainWindowOption::MainWindowOption_HasCentralGroup,
        MainWindowOption_HasCentralFrame = KDDockWidgets::MainWindowOption::MainWindowOption_HasCentralFrame,
        MainWindowOption_MDI = KDDockWidgets::MainWindowOption::MainWindowOption_MDI,
        MainWindowOption_HasCentralWidget = KDDockWidgets::MainWindowOption::MainWindowOption_HasCentralWidget,
        MainWindowOption_QDockWidgets = KDDockWidgets::MainWindowOption::MainWindowOption_QDockWidgets,
        MainWindowOption_ManualInit = KDDockWidgets::MainWindowOption::MainWindowOption_ManualInit
    };
    Q_DECLARE_FLAGS(MainWindowOptions, MainWindowOption)
    Q_FLAG(MainWindowOptions)
    Q_INVOKABLE void init();
};
