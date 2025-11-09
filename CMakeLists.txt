cmake_minimum_required(VERSION 3.21)

project(FluentUIDock VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(KDDockWidgets_QT6 ON)
set(KDDockWidgets_STATIC ON)
set(KDDockWidgets_EXAMPLES OFF)

set(FLUENTUI_QML_PLUGIN_DIRECTORY ${CMAKE_SOURCE_DIR}/imports)
set(QT_QML_OUTPUT_DIRECTORY ${FLUENTUI_QML_PLUGIN_DIRECTORY})

if (FLUENTUI_BUILD_STATIC_LIB)
    set(FLUENTUI_LIB_TYPE "STATIC")
    set(PLUGIN_TARGET_NAME "")
else ()
    set(FLUENTUI_LIB_TYPE "SHARED")
    set(PLUGIN_TARGET_NAME ${PROJECT_NAME})
endif ()

find_package(Qt6 COMPONENTS Quick Widgets QuickControls2 REQUIRED)
find_package(Qt6 OPTIONAL_COMPONENTS QuickPrivate WidgetsPrivate)
qt_standard_project_setup(REQUIRES ${QT_VERSION_REQUIRED})

qt_add_library(${PROJECT_NAME} ${FLUENTUI_LIB_TYPE})

set(QML_FILES
    DockingArea.qml
    DockWidget.qml
    FluentUITitleBar.qml
    FluentUIDockWidget.qml
    FluentUIFloatingWindow.qml
    FluentUIGroup.qml
    FluentUITabBar.qml
    FluentUIRubberBand.qml
    FluentUISeparator.qml
    ClassicIndicatorsOverlay.qml
    ClassicIndicator.qml
)

set(SOURCE_FILES
    stdafx.h
    FluentUIDock.h FluentUIDock.cpp
)

qt_add_qml_module(${PROJECT_NAME}
    URI "FluentUIDock"
    VERSION "${PROJECT_VERSION}"
    DESIGNER_SUPPORTED
    PLUGIN_TARGET ${PLUGIN_TARGET_NAME}
    QML_FILES ${QML_FILES}
    SOURCES ${SOURCE_FILES}
    RESOURCE_PREFIX /qt/qml
)

target_compile_definitions(${PROJECT_NAME} PRIVATE
    QT_NO_KEYWORDS
    QT_MESSAGELOGCONTEXT
    HAVE_CONFIG_H
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    DEBUG_POSTFIX "d"
)

if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE
        "$<$<CONFIG:Release>:/Zi>"
        "/MP"
    )
target_link_options(${PROJECT_NAME} PRIVATE
    "$<$<CONFIG:Release>:/DEBUG>"
    "$<$<CONFIG:Release>:/OPT:REF>"
    "$<$<CONFIG:Release>:/OPT:ICF>"
)
endif()


target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Quick
    Qt6::QuickPrivate
    Qt6::Widgets
    Qt6::WidgetsPrivate
    Qt6::QuickControls2
    FluentUI
    FluentUIImpl
    FluentUIControls
    KDAB::kddockwidgets
)

if (FLUENTUI_BUILD_STATIC_LIB)
    target_link_libraries(
        ${PROJECT_NAME} PRIVATE
        FluentUIplugin
        FluentUIImplplugin
        FluentUIControlsplugin
    )
endif()

add_subdirectory(KDDockWidgets)
