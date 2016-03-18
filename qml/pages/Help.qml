import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: helpPage

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator {}

        Column {
            id: column
            width: root.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: appName
                description: "Help"
            }

            SectionHeader {
                text: "What is 1RM?"
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignJustify
                font.pointSize: 18
                color: Theme.primaryColor
                text: "1RM stands for <i>One Repetition Maximum</i> and in weight training it is the maximum amount of weight one can lift in a single repetition for a given exercise. More information about 1RM and the prediction equations used by this calculator can be found <a href='http://en.m.wikipedia.org/wiki/One-repetition_maximum'>at Wikipedia</a>.<p><p>
                There's also an interesting study on the subject of the accuracy of prediction equations published in 1997 by the National Strength and Conditioning Association. You can view and download the PDF-file of this study <a href='http://www.researchgate.net/publication/232239360_The_Accuracy_of_Prediction_Equations_for_Estimating_1-RM_Performance_in_the_Bench_Press_Squat_and_Deadlift'>here</a>."
                wrapMode: TextEdit.WordWrap
                onLinkActivated: Qt.openUrlExternally(link)
            }

            SectionHeader {
                text: "Instructions to use this calculator"
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignJustify
                font.pointSize: 18
                color: Theme.primaryColor
                text: "Before you can calculate your estimated 1RM you have to lift a set with a weight you can lift up fully to a maximum of 12 repetitions. Then select the amount of weight lifted and the number of reps completed and hit the calculate button. On the results page swipe left to view percentages table.<p><p>
                You can also calculate your maximum repetitions when you know your 1RM. On the main calculator page you find a rep max calculator from the pull-down menu. Select your 1RM and desired number of reps and hit the calculate button.<p><p>
                Calculator uses 7 different prediction equations for estimating your 1RM performance from repetitions to fatigue. Remember that the results are not 100 % accurate and the degree of accuracy can vary between different weight training exercises as well as the weight training experience and muscular composition of the trainee."
                wrapMode: TextEdit.WordWrap
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
                color: Theme.primaryColor
                text: "where:<p><p> 1RM is One Repetition Maximum<p> W is the amount of weight lifted<p> R is the number of repetitions completed<p> e is Euler's number (approx. 2,71828)<p>"
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
                color: Theme.primaryColor
                text: "There are always risks when you're handling heavy weights. Be sure always to warm up and stretch your muscles and joints properly before the workout, especially when attempting your 1RM. It's always a good idea to ask a friend to act as a spotter to support your lifts. Stay hydrated, pay attention to your lifting technique and listen to your body to prevent injuries; you don't want to break yourself."
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
                color: Theme.primaryColor
                text: "Workout safely and regularly, have fun and good luck on attempting those 1RMs! :-)<p>"
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}
