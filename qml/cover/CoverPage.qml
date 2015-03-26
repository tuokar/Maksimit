import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Image {
        anchors.top: parent.top
        anchors.topMargin: 20
        source: "../images/cover-background.png"
        opacity: 0.1
    }

    Text {
        width: parent.width - 2*Theme.paddingMedium
        x: Theme.paddingMedium
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 20
        color: Theme.primaryColor
        text: "1RM Calculator\nfor SailfishOS"
        wrapMode: TextEdit.WordWrap
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
        }
    }
}


