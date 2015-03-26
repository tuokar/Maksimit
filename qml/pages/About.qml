import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: aboutPage

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: aboutPage.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "About 1RM Calculator"
            }

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/big_icon.png"
                fillMode: Image.PreserveAspectFit
            }

            Item {
                width: parent.width
                height: 30
            }

            Label {
                x: Theme.paddingMedium
                anchors.horizontalCenter: parent.horizontalCenter
                text: "1RM Calculator for SailfishOS"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 18
                color: Theme.primaryColor
                text: "<p>This is a simple 1RM (One Repetition Maximum) calculator for all the weight training enthusiastic SailfishOS users out there.<p>"
                wrapMode: TextEdit.WordWrap
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 20
                color: Theme.highlightColor
                text: "Version 0.3.2-1<p>
                Created by Tuomas Kärki"
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}

