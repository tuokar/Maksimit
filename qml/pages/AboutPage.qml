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
                title: "About " + appName
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

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.highlightColor
                text: "Rep max calculator<p>for Sailfish OS"
                wrapMode: TextEdit.WordWrap
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 18
                color: Theme.primaryColor
                text: "<p>" + appName + " is a simple rep max calculator for all the weight training enthusiastic Sailfish OS users out there.<p>"
                wrapMode: TextEdit.WordWrap
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 20
                color: Theme.highlightColor
                text: "Version " + appVersion + "<p>Developed by Tuomas Kärki"
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}

