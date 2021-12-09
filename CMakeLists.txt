cmake_minimum_required(VERSION 3.14)

project(BigBrain LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


set(QML_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR}/qml
    CACHE STRING "Qt Creator 5.15 extra qml import paths"
    FORCE)


# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check https://doc.qt.io/qt/deployment-android.html for more information.
# They need to be set before the find_package(...) calls below.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED)
find_package(game2048)

set(PROJECT_SOURCES
        srcs/main.cpp
        qml.qrc
		app.qrc
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(BigBrain
        ${PROJECT_SOURCES}
        ${QML_IMPORT_PATH}
    )
else()
    if(ANDROID)
        add_library(BigBrain SHARED
            ${PROJECT_SOURCES}
        ${QML_IMPORT_PATH}
        )
    else()
        add_executable(BigBrain
          ${PROJECT_SOURCES}
        ${QML_IMPORT_PATH}
        )
    endif()
endif()

target_include_directories(BigBrain
	PRIVATE
	${CMAKE_CURRENT_LIST_DIR}/includes
)

add_subdirectory(lib)
add_subdirectory(tests)

target_compile_definitions(BigBrain
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(BigBrain
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick game2048)
