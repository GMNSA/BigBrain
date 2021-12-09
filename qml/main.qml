import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import MenuBarCustom 1.0
import PageSettings 1.0
import PageGames 1.0
import PageMain 1.0
import PageShop 1.0


ApplicationWindow {
    id: _root

    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")


    Material.theme: Material.Dark

    StackView {
        id: _stack
        // initialItem: _mainPage
        initialItem: _pageGames
        anchors.fill: parent
    }

    menuBar:  MenuBarImpl {
        id: _menuBar
    }

    PageMainImpl {
        id: _mainPage
        visible: false
    }

    PageSettingsImpl {
        id: _pageSettings
        visible: false
    }

    PageGamesImpl {
        id: _pageGames
        visible: false
    }

    PageShopImpl {
        id: _pageShop
        visible: false
    }
}

