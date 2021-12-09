import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import PageMain.ButtonRound 1.0

Item {
    id: _root

    property string colorLeftBtn: Material.color(Material.BlueGrey)
    property string colorMiddleBtn: Material.color(Material.BlueGrey)
    property string colorRightBtn: Material.color(Material.BlueGrey)
    property real depthSize: 2
    property int spacingBtns: 10

    height: parent.height * 0.5
    width: parent.width

    Row {
        id: _rowsmallButtons

        height: _btn1.height

        anchors.centerIn: parent
        spacing: 10


         ButtonRoundImpl {
             id: _btn1


             width: _roundButton.width / depthSize

             height: _roundButton.height / depthSize
             radius: width / depthSize


             color: colorLeftBtn
             fimage: "qrc:/resources/heart.png"
             fimageScale: 0.7

             onClicked: {
                 _dialog.open()
             }
         }

         ButtonRoundImpl {
             id: _btn2

             width: _roundButton.width / depthSize

             height: _roundButton.height / depthSize
             radius: width / depthSize


             color: colorMiddleBtn
             fimage: "qrc:/resources/noAds.png"
             fimageScale: 0.9
             fimageRadius: 40

             Text {
                 anchors.centerIn: parent
             }
         }

         ButtonRoundImpl {
             id: _btn3

             width: _roundButton.width / depthSize

             height: _roundButton.height / depthSize
             radius: width / depthSize

             color: colorRightBtn
             fimage: "qrc:/resources/buy2.png"
             fimageScale: 0.5
             fimageRadius: 0

             onClicked: {
                 _stack.push(_pageShop)
             }
         }
    }
}
