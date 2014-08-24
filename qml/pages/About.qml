import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: about

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: about.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "About 1RM Calculator"
            }

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/harbour-1rmcalc.png"
                fillMode: Image.PreserveAspectFit
                width: implicitWidth * 1.5
                height: implicitHeight * 1.5
            }

            Label {
                x: Theme.paddingMedium
                anchors.horizontalCenter: parent.horizontalCenter
                text: "1RM Calculator for SailfishOS<p>"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 18
                color: "white"
                text: "This is a simple 1RM (One Repetition Maximum) calculator for all the weight training enthusiastic Jolla users out there.<p><p>
                Version 0.2.0-1<p> Created by Tuomas Kärki<p>"
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}
