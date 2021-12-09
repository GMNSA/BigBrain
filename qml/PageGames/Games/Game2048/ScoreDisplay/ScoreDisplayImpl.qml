import QtQuick 2.15
import QtQuick.Controls 2.5

Item {
    id: _root

    property int fradius: 5

    width: _score.width + _hightScore.width
    height: _score.height

        Rectangle {
            id: _score

            width: 50 > _displayScore.width ? 50 : _displayScore.width
            height: 40

            anchors.left: parent.left

            radius: fradius
            color: "lightblue"

            Column {
                width: parent.width
                height: parent.height

                Label {
                    id: _nameScore
                    text: qsTr("Score")

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label
                {
                    id: _displayScore

                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "168"
                }
            }
        }

        Rectangle {
            id: _hightScore

            width: 100
            height: 40

            anchors.left: _score.right
            anchors.leftMargin: 10

            radius: fradius
            color: "lightblue"

            Column {
                width: parent.width
                height: parent.height

                Label {
                    id: _nameHightScore
                    text: qsTr("High Score")

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label
                {
                    id: _displayHightScore

                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "168"
                }
            }
        }
}
