import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ToolBar {
    RowLayout {
        anchors.fill: parent
        ToolButton {
            text:  qsTr("‹")
            visible: _stack.depth > 1 ? true :
                                        false
            onClicked:  {
                _stack.pop()
            }
        }

        Label {
            text: "Big Brain"
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }

        ToolButton {
            Image {
                anchors.fill: parent
                source: "qrc:/resources/settings.png"
                scale: 0.5
            }

            onClicked: _stack.push(_pageSettings)
        }
    }

}
