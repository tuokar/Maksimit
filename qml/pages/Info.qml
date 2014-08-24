import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: info

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
                title: "What is 1RM?"
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignJustify
                font.pointSize: 18
                color: "white"
                text: "1RM stands for <i>One Repetition Maximum</i> and in weight training it is the maximum amount of weight one can lift in a single repetition for a given exercise. More information about 1RM and the prediction equations used by this calculator can be found <a href='http://en.m.wikipedia.org/wiki/One-repetition_maximum'>at Wikipedia</a>.<p><p>
                There's also an interesting study on the subject of the accuracy of prediction equations published in 1997 by the National Strength and Conditioning Association. You can view and download the PDF-file of this study <a href='http://www.researchgate.net/publication/232239360_The_Accuracy_of_Prediction_Equations_for_Estimating_1-RM_Performance_in_the_Bench_Press_Squat_and_Deadlift'>here</a>."
                wrapMode: TextEdit.WordWrap
                onLinkActivated: Qt.openUrlExternally(link)
            }

            SectionHeader {
                text: "Prediction equations for 1RM"
            }

            TextField {
                width: parent.width
                readOnly: true
                label: "Brzycki"
                text: "1RM = W x (36 / (37 − R))"
            }

            TextField {
                width: parent.width
                readOnly: true
                label: "Epley"
                text: "1RM = W x (1 + R / 30)"
            }

            TextField {
                width: parent.width
                readOnly: true
                label: "Lander"
                text: "1RM = 100 x W / (101.3 − 2.67123 x R)"
            }

            TextField {
                width: parent.width
                readOnly: true
                label: "Lombardi"
                text: "1RM = W x R^0.1"
            }

            TextField {
                width: parent.width
                readOnly: true
                label: "Mayhew et al."                
                text: "1RM = 100 x W / (52.2 + 41.9 x e^(−0.055 x R))"
            }

            TextField {
                width: parent.width
                readOnly: true
                label: "O'Conner et al."
                text: "1RM = W x (1 + 0.025 x R)"
            }

            TextField {
                width: parent.width
                readOnly: true
                label: "Wathan"
                text: "1RM = 100 x W / (48.8 + 53.8 x e^(−0.075 x R))"
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                font.pointSize: 18
                color: "white"
                text: "where:<p><p> 1RM is One Repetition Maximum<p> W is the amount of weight lifted<p> R is the number of repetitions completed<p> e is Euler's number (approx. 2,71828)<p>"
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}





