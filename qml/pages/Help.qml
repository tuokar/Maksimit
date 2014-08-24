import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: help

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: root.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "Help"
            }

            SectionHeader {
                text: "Instructions to use this calculator"
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignJustify
                font.pointSize: 18
                color: "white"
                text: "Before you can calculate your estimated 1RM you have to lift a set with a weight you can lift up fully to a maximum of 10 repetitions. Then select the amount of weight lifted and the number of reps completed and hit 'Calculate my 1RM'.<p><p>
                Calculator uses 7 different prediction equations for estimating your 1RM performance from repetitions to fatigue. Remember that the results are not 100 % accurate and the degree of accuracy can vary between different weight training exercises as well as the weight training experience and muscular composition of the trainee."
                wrapMode: TextEdit.WordWrap
            }

            SectionHeader {
                text: "Safety tips"
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignJustify
                font.pointSize: 18
                color: "white"
                text: "There are always risks when you're handling heavy weights. Be sure always to warm up and stretch your muscles and joints properly before the workout and especially when attempting your 1RM. It's always a good idea to ask a friend to act as a spotter to support your lifts. Stay hydrated and listen to your body to prevent injuries; you don't want to break yourself."
                wrapMode: TextEdit.WordWrap
            }

            SectionHeader {
                text: "In conclusion"
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignJustify
                font.pointSize: 18
                color: "white"
                text: "Workout safely and regularly, have fun and good luck on attempting those 1RMs! :-)<p>"
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}
