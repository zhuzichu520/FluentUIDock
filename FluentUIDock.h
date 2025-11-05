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
    Q_INVOKABLE void init();
};
