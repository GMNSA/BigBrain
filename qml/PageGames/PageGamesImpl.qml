import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import PageGames.Games.Game2048 1.0
import PageGames.Games.QuickMath 1.0

import "qrc:/gamesImages.js" as GamesImages


Page {
    id: _root

    Game2048Impl {
        id: _pageGame2048
        visible: false
    }

    GameQuickMathImpl {
        id: _pageGameQuickMath
        visible: false
    }

    // -------------------------------------------------------

    ListModel {
        id: _model
        ListElement {
            name: "2048"
            image: "qrc:/resources/settings.png"
            score: "10"
        }
        ListElement {
            name: "QUICK MATH"
            image: "qrc:/resources/settings.png"
            score: "0"
        }
        ListElement {
            name: "BRAIN OVER"
            image: "qrc:/resources/settings.png"
            score: "14"
        }
        ListElement {
            name: "TABLE OF GROW"
            image: "qrc:/resources/settings.png"
            score: "10"
        }
        ListElement {
            name: "BALANCE"
            image: "qrc:/resources/settings.png"
            score: "10"
        }
        ListElement {
            name: "HARD MATH"
            image: "qrc:/resources/settings.png"
            score: "10"
        }
        ListElement {
            name: "TRUE / FALSE"
            image: "qrc:/resources/settings.png"
            score: "10"
        }
        ListElement {
            name: "MULTIPLICATION TABLE"
            image: "qrc:/resources/settings.png"
            score: "10"
        }
        ListElement {
            name: "INPUT MATH"
            image: "qrc:/resources/settings.png"
            score: "10"
        }
        ListElement {
            name: "POWER MEMO"
            image: "qrc:/resources/settings.png"
            score: "10"
        }
    }

    GridView {
        anchors.fill: parent
        cellHeight: 200
        cellWidth: parent.width * 0.5 - 5


        model: _model

        delegate: Rectangle {
            width: _root.width * 0.5
            height: 150

            color: Material.color(Material.Blue)
            border.width: 2
            border.color: "black"

            Column {
                anchors.fill: parent
                spacing: 10

                Item {
                    height: 10
                    width: 10
                }

                Image {
                    width: 50
                    height: 50
                    source: GamesImages.imagesGames(name)

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: name

                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: score

                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked:  {
                    if (name == "2048")
                        _stack.push(_pageGame2048)
                    if (name == "QUICK MATH")
                        _stack.push(_pageGameQuickMath)
                }
            }
        }
    }
}
