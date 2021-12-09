import QtQuick 2.12
import QtGraphicalEffects 1.0

import ModuleStyle 1.0

Rectangle {
    id: _root

    signal clicked();

    property string fimage: "qrc:/resources/triangleBtn.png"
    property string fcolorTo: Style.fcolorSecond2
    property int fToDuration: 2000
    property int fFromDuration: 500
    property real fimageScale: 1
    property real fimageRadius: 0

    width: getRoundWidth() / depthRound > 100 ? 100 :
                                                getRoundWidth() / depthRound
    height: width
    radius: width / 2

    color: Style.fcolorSecond2

    states: State {
        name: "toColor"
        when: _mouseAreaRoundBtn.pressed

        PropertyChanges {
            target: _root
            color: fcolorTo
        }

    }

    transitions: [
        Transition {
            to: "toColor"
            ColorAnimation {
                duration: fToDuration
            }
        },
        Transition {
            to: "from"
            ColorAnimation {
                duration: fFromDuration
            }
        }

    ]


    Image {

        anchors.fill: parent
        anchors.centerIn: parent

        source: fimage
        scale: fimageScale
        antialiasing: true
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: _mask
        }


    }

     Rectangle {
        id: _mask
        anchors.fill: parent
        anchors.centerIn: parent
        radius: fimageRadius
        visible: false
    }

     MouseArea {
         id: _mouseAreaRoundBtn

         anchors.fill: parent

         onClicked: {
             _root.clicked()
         }
     }
}
