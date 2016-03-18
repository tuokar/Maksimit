import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/Preferences.js" as Preferences


Page {
    id: calc1RM
    onStatusChanged: {
        if(status == PageStatus.Active) {
            return(pageStack.pushAttached("Percentages1RM.qml", {}, operationType))
        }
    }

    Component.onCompleted: calc1RM.setResults()

    property string kgValue: parseFloat(Preferences.get("kgValue"))
    property string lbValue: parseFloat(Preferences.get("lbValue"))
    property string repsValue: parseInt(Preferences.get("repsValue"))
    property string kgUnit: parseInt(Preferences.get("kgUnit"))
    property string lbUnit: parseInt(Preferences.get("lbUnit"))
    property string kgIncrement: parseFloat(Preferences.get("kgIncrement"))
    property string lbIncrement: parseFloat(Preferences.get("lbIncrement"))
    property bool backStepping: true
    property int operationType: PageStackAction.Animated

    function switchOperationType() {
        operationType = (operationType === PageStackAction.Immediate ? PageStackAction.Animated : PageStackAction.Immediate)
    }


    // ----- KG CALCULATIONS -----

    // Brzycki: 1RM = W x (36 / (37 - R))
    function brzycki_kg() {
        var weight = kgValue
        var reps = repsValue
        var increment = kgIncrement
        return(Math.round(weight * (36 / (37 - reps)) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Epley: 1RM = W x (1 + R / 30)
    function epley_kg() {
        var weight = kgValue
        var reps = repsValue
        var increment = kgIncrement
        return(Math.round(weight * (1 + reps / 30) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Lander: 1RM = 100 x W / (101.3 - 2.67123 x R)
    function lander_kg() {
        var weight = kgValue
        var reps = repsValue
        var increment = kgIncrement
        return(Math.round(100 * weight / (101.3 - 2.67123 * reps) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Lombardi: 1RM = W x R^0.1
    function lombardi_kg() {
        var weight = kgValue
        var reps = repsValue
        var increment = kgIncrement
        return(Math.round(weight * Math.pow(reps, 0.1) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Mayhew et al.: 1RM = 100 x W / (52.2 + (41.9 x e^(-0.055 x R)))
    function mayhew_kg() {
        var weight = kgValue
        var reps = repsValue
        var increment = kgIncrement
        return(Math.round(100 * weight / (52.2 + (41.9 * Math.pow(Math.E, (-0.055 * reps)))) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // O'Conner et al.: 1RM = W x (1 + 0.025 x R)
    function oconner_kg() {
        var weight = kgValue
        var reps = repsValue
        var increment = kgIncrement
        return(Math.round(weight * (1 + 0.025 * reps) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Wathan: 1RM = 100 x W / (48.8 + (53.8 x e^(-0.075 x R)))
    function wathan_kg() {
        var weight = kgValue
        var reps = repsValue
        var increment = kgIncrement
        return(Math.round(100 * weight / (48.8 + (53.8 * Math.pow(Math.E, (-0.075 * reps)))) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }


    // ----- LB CALCULATIONS -----

    // Brzycki: 1RM = W x (36 / (37 - R))
    function brzycki_lb() {
        var weight = lbValue
        var reps = repsValue
        var increment = lbIncrement
        return(Math.round(weight * (36 / (37 - reps)) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Epley: 1RM = W x (1 + R / 30)
    function epley_lb() {
        var weight = lbValue
        var reps = repsValue
        var increment = lbIncrement
        return(Math.round(weight * (1 + reps / 30) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Lander: 1RM = 100 x W / (101.3 - 2.67123 x R)
    function lander_lb() {
        var weight = lbValue
        var reps = repsValue
        var increment = lbIncrement
        return(Math.round(100 * weight / (101.3 - 2.67123 * reps) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Lombardi: 1RM = W x R^0.1
    function lombardi_lb() {
        var weight = lbValue
        var reps = repsValue
        var increment = lbIncrement
        return(Math.round(weight * Math.pow(reps, 0.1) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Mayhew et al.: 1RM = 100 x W / (52.2 + (41.9 x e^(-0.055 x R)))
    function mayhew_lb() {
        var weight = lbValue
        var reps = repsValue
        var increment = lbIncrement
        return(Math.round(100 * weight / (52.2 + (41.9 * Math.pow(Math.E, (-0.055 * reps)))) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // O'Conner et al.: 1RM = W x (1 + 0.025 x R)
    function oconner_lb() {
        var weight = lbValue
        var reps = repsValue
        var increment = lbIncrement
        return(Math.round(weight * (1 + 0.025 * reps) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }

    // Wathan: 1RM = 100 x W / (48.8 + (53.8 x e^(-0.075 x R)))
    function wathan_lb() {
        var weight = lbValue
        var reps = repsValue
        var increment = lbIncrement
        return(Math.round(100 * weight / (48.8 + (53.8 * Math.pow(Math.E, (-0.075 * reps)))) / increment) * increment).toFixed(2).replace(/\.0+$/, "")
    }


    function setResults() {
        Preferences.set("brzycki_kg_1RM", brzycki_kg())
        Preferences.set("epley_kg_1RM", epley_kg())
        Preferences.set("lander_kg_1RM", lander_kg())
        Preferences.set("lombardi_kg_1RM", lombardi_kg())
        Preferences.set("mayhew_kg_1RM", mayhew_kg())
        Preferences.set("oconner_kg_1RM", oconner_kg())
        Preferences.set("wathan_kg_1RM", wathan_kg())
        Preferences.set("brzycki_lb_1RM", brzycki_lb())
        Preferences.set("epley_lb_1RM", epley_lb())
        Preferences.set("lander_lb_1RM", lander_lb())
        Preferences.set("lombardi_lb_1RM", lombardi_lb())
        Preferences.set("mayhew_lb_1RM", mayhew_lb())
        Preferences.set("oconner_lb_1RM", oconner_lb())
        Preferences.set("wathan_lb_1RM", wathan_lb())
        Preferences.set("min_kg_1RM", Math.min(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()))
        Preferences.set("max_kg_1RM", Math.max(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()))
        Preferences.set("min_lb_1RM", Math.min(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()))
        Preferences.set("max_lb_1RM", Math.max(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()))
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: calc1RM.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: appName
                description: "The results"
            }

            Label {
                x: Theme.paddingMedium
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Your estimated 1RM is:"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
            }

            Label {
                id: kgResults
                font.pixelSize: Theme.fontSizeExtraLarge
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.highlightColor
                text: {
                    if(Math.min(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) === Math.max(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()))
                        return(kgResults.text = Math.min(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) + " kg")
                    else
                        return(Math.min(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) + " − " + Math.max(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) + " kg")
                }
                visible: {
                    if(kgUnit == 1)
                        return(true)
                    else
                        return(false)
                }
            }

            Label {
                id: lbResults
                font.pixelSize: Theme.fontSizeExtraLarge
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.highlightColor
                text: {
                    if(Math.min(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) === Math.max(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()))
                        return(lbResults.text = Math.min(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) + " lb")
                    else
                        return(Math.min(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) + " − " + Math.max(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) + " lb")
                }
                visible: {
                    if(kgUnit == 1)
                        return(false)
                    else
                        return(true)
                }
            }

            Column {
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "<p>According to these equations:<p>"
                    color: Theme.primaryColor
                }

                Row {
                    spacing: 20

                    Rectangle { width: 205; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Brzycki" }
                    }

                    Rectangle { width: 100; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? brzycki_kg() : brzycki_lb() }
                    }

                    Rectangle { width: 50; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? "kg" : "lb" }
                    }
                }

                Row {
                    spacing: 20

                    Rectangle { width: 205; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Epley" }
                    }

                    Rectangle { width: 100; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? epley_kg() : epley_lb() }
                    }

                    Rectangle { width: 50; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? "kg" : "lb" }
                    }
                }

                Row {
                    spacing: 20

                    Rectangle { width: 205; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Lander" }
                    }

                    Rectangle { width: 100; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? lander_kg() : lander_lb() }
                    }

                    Rectangle { width: 50; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? "kg" : "lb" }
                    }
                }

                Row {
                    spacing: 20

                    Rectangle { width: 205; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Lombardi" }
                    }

                    Rectangle { width: 100; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? lombardi_kg() : lombardi_lb() }
                    }

                    Rectangle { width: 50; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? "kg" : "lb" }
                    }
                }

                Row {
                    spacing: 20

                    Rectangle { width: 205; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Mayhew et al." }
                    }

                    Rectangle { width: 100; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? mayhew_kg() : mayhew_lb() }
                    }

                    Rectangle { width: 50; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? "kg" : "lb" }
                    }
                }

                Row {
                    spacing: 20

                    Rectangle { width: 205; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "O'Conner et al." }
                    }

                    Rectangle { width: 100; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? oconner_kg() : oconner_lb() }
                    }

                    Rectangle { width: 50; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? "kg" : "lb" }
                    }
                }

                Row {
                    spacing: 20

                    Rectangle { width: 205; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Wathan" }
                    }

                    Rectangle { width: 100; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? wathan_kg() : wathan_lb() }
                    }

                    Rectangle { width: 50; height: 40; color: "transparent"
                        Text { font.pointSize: 19; color: Theme.primaryColor; text: kgUnit == 1 ? "kg" : "lb" }
                    }
                }
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignJustify
                font.pointSize: 18
                color: Theme.highlightColor
                text: "<u>Remember:</u> these equations gives you the <i>estimated</i> 1RM lift and the results are not 100 % accurate. The degree of accuracy can vary between different weight training exercises as well as the weight training experience and muscular composition of the trainee."
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}
