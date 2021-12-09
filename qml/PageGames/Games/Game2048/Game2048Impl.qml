import QtQuick 2.14
import QtQuick.Controls 2.5
import QtQuick.Window 2.3

import model.game2048 1.0
import PageGames.Games.Game2048.ScoreDisplay 1.0
import ModuleDialog 1.0

import "qrc:/colorTile.js" as ColorTile

Page {
    id: _root

   Component.onCompleted: {

       // maximumWidth = 500
   }

    ModelGame2048 {
        id: _model
    }

    // ----------------------

    ScoreDisplayImpl {
        id: _wrapperScore
    }

    Column {
        id: _columntBtn
        anchors.right: parent.right
        spacing: 3

        property int fheight: 30
        property int fwidht:  _txtBtnRestart.width > 100 ? _txtBtnRestart.width :
                                               100
        property int fradius: 5

        Rectangle {
            id: _btnRestart

            width: _columntBtn.fwidht
            height:_columntBtn.fheight

            radius: _columntBtn.fradius

            color: "lightblue"

            Text {
                id: _txtBtnRestart

                anchors.centerIn: parent

                text: "restart"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    print("RESET QML");
                    _dialogRestart.open()
                }
            }

        }

        Rectangle {
            id: _btnBack

            width: _columntBtn.fwidht
            height:_columntBtn.fheight

            radius: _columntBtn.fradius

            color: "lightblue"

            Text {
                id: _txtBtnBack

                text: "back"
                anchors.centerIn: parent
            }
        }

    }

    // ----------------------

    Component {
        id: _contactDelegate

        Rectangle {
            id: wrapper
            width: _grid.cellWidth
            height: _grid.cellHeight

            color: ColorTile.colorTile(display)
            border.width: 2
            border.color: "#403c3e"

            radius: 10

            Text {
                text: display != 0 ? display : ""
                anchors.centerIn: parent
            }

            PropertyAnimation { properties: "y";
                easing.type: Easing.InOutElastic;
                easing.amplitude: 2.0;
                easing.period: 1.5 }
        }
    }


    GridView {
        id: _grid


        width: parent.width > 500 ? 500 : parent.width
        height: Screen.width

        anchors.top: _wrapperScore.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: _wrapperScore.height

        cellWidth: width / 4
        cellHeight: cellWidth

        interactive: false

        model: _model
        delegate: _contactDelegate

        focus: true

        displaced: Transition {
            NumberAnimation {
                properties: "x,y"
                duration: 200
            }
        }
    }

    /*          ***** ***** ***** *****          */

    DialogImpl {
        id: _dialogRestart

        textLabel: "Reset"
        text: "Are you sure you wish to reset the game?"

        width: parent.width

        onAccepted: {
            _model.restart()
        }
    }

    MouseArea {

        property real xVelocity: 0.0
        property real yVelocity: 0.0
        property int xStart: 0
        property int xPrev: 0
        property int yStart: 0
        property int yPrev: 0
        property bool tracing: false


        property real triggerVelocity: 15
        property real lengthSwipe: 0.2

        width: 100
        height: 50

        anchors.fill: _grid
        preventStealing: true

        onPressed: {
            xStart = mouse.x
            xPrev = mouse.x
            yStart = mouse.y
            yPrev = mouse.y

            xVelocity = 0
            yVelocity = 0
            tracing = true
        }

        onPositionChanged: {
        }

        onReleased: {
            if ( !tracing ) return
            var xCurrVel = (mouse.x-xPrev)
            var yCurrVel = (mouse.y-yPrev)

            xVelocity = (xVelocity + xCurrVel)/2.0
            yVelocity = (yVelocity + yCurrVel)/2.0

            xPrev = mouse.x
            yPrev = mouse.y
            if (xVelocity > triggerVelocity && mouse.x > parent.width * lengthSwipe)
            {
                print("right")
                _model.moveRight()
            }
            if (xVelocity < -triggerVelocity && mouse.x < (parent.width * lengthSwipe))
            {
                print("left")
                _model.moveLeft()
            }
            if (yVelocity > triggerVelocity && mouse.y > parent.height * lengthSwipe)
            {
                print("Down")
                _model.moveDown()
            }
            if (yVelocity < -triggerVelocity &&  mouse.y < (parent.height * lengthSwipe))
            {
                print("Up")
                _model.moveUp()
            }
        }
    }

}
