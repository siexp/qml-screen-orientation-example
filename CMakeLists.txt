cmake_minimum_required(VERSION 3.14)

project(qml-screen-orientation-example LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check https://doc.qt.io/qt/deployment-android.html for more information.
# They need to be set before the find_package(...) calls below.
if(ANDROID)
    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick AndroidExtras REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick AndroidExtras REQUIRED)

set(PROJECT_SOURCES
        main.cpp
        AndroidInterface.cpp
        qml.qrc
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(qml-screen-orientation-example
        ${PROJECT_SOURCES}
    )
else()
    if(ANDROID)
        add_library(qml-screen-orientation-example SHARED
            ${PROJECT_SOURCES}
        )
    else()
        add_executable(qml-screen-orientation-example
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_compile_definitions(qml-screen-orientation-example
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(qml-screen-orientation-example
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt5::AndroidExtras)