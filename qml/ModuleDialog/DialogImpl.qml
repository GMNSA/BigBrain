import QtQuick 2.15
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.5

Dialog {
    id: _root
    visible: false
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

    height: 200

    x: parent.width / 2 - _root.width / 2
    y: parent.height / 2 - _root.height / 2

    property alias text : _textContainer.text
    property alias textLabel : _labelContainer.text

    Column {
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        Label {
            id: _labelContainer

            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20
            font.bold: true
        }

        Text {
            id: _textContainer

            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.wrapMode

            font.pixelSize: 15
            color: "white"

        }
    }
}
