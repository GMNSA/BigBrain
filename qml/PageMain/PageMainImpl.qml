import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Material 2.3

import MenuBarCustom 1.0
import ModuleStyle 1.0
import PageMain.ModuleRowRound 1.0
import PageMain.ButtonRound 1.0



Page {
    id: _root

    // anchors.fill: parent
    property real depthRound: 3

    function getRoundWidth() {
        return Math.min(parent.width, parent.height)
    }

    function getRoundWidthSmall() {
        return Math.min(parent.width, parent.height)
    }


    Label {
        anchors.centerIn: parent
        text: "MAIN"
    }

    ButtonRoundImpl {
        id: _roundButton

        anchors.centerIn: parent

        color: Style.fcolorMain
        fcolorTo: Style.fcolorSecond2
        fToDuration: 1000
        fFromDuration: 200

        onClicked:  {
            _stack.push(_pageGames)
        }
    }


    ModuleRowRoundImpl {
        id: _rowRound

        anchors.bottom: parent.bottom
        anchors.top: _roundButton.bottom
    }

    //  ----- ----- -----

    Dialog {
        id: _dialog
        visible: false
        title: "Choose a date"
        standardButtons: StandardButton.Cancel

        width: parent.width


        Column {
            id: _column
            spacing: 10
            width: parent.width
            anchors.margins: 10
            Label {
                id: _labelDialog
                text: "Rate our work"
            }

            Text {
                id: _textDialog
                width: parent.width
                text: "This game is done with lovefor you! It will be very pleasant to us to see your responses and wishes!"

                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                clip: true
            }
        }

        SpriteSequence {
            id: image
            width: 20   // The width of the area under the sprite
            height: 20  // The height of the area under the sprite
            // Sprite is located at the top left of the application window
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 100

            Sprite {
                id: sprite
                source: "qrc:/resources/spritesHeart.png"
                frameCount: 5
                frameWidth: 32
                frameHeight: 32
                frameSync: true
            }
        }

        AnimatedSprite {
            id: animatedSprite

            width: 100 // The width of the area under the sprite
            height: 100 // The height of the area under the sprite
            // Sprite is located at the top right of the application window
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 100
            frameDuration: 500
            frameRate: 500

            source: "qrc:/resources/spritesHeart.png"
            frameCount: 5
            frameWidth: 32
            frameHeight: 32
            frameSync: true
        }

    }
}
