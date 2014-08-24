import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: root

    property bool backStepping: true
    property int operationType: PageStackAction.Animated

    function switchOperationType() {
        operationType = (operationType === PageStackAction.Immediate ? PageStackAction.Animated : PageStackAction.Immediate)
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {

            MenuItem {
                text: "About..."
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("About.qml"))
                    weightSliderWarning.visible = false
                    repsSliderWarning.visible = false
                }
            }

            MenuItem {
                text: "What is 1RM?"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("Info.qml"))
                    weightSliderWarning.visible = false
                    repsSliderWarning.visible = false
                }
            }

            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("Help.qml"))
                    weightSliderWarning.visible = false
                    repsSliderWarning.visible = false
                }
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: root.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "1RM Calculator"
            }

            Label {
                x: Theme.paddingLarge
                text: "Calculate your estimated 1RM!"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignJustify
                font.pointSize: 18
                color: "white"
                text: "Just select the amount of weight you lifted and the number of repetitions completed that time (max. 10 reps). Then hit 'Calculate my 1RM' to get your estimated <b>ONE REPETITION MAXIMUM!</b>"
                wrapMode: TextEdit.WordWrap
            }

            Row {
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                Switch {
                    id: kgSelect
                    checked: true
                    onClicked: {
                        lbSelect.checked = false
                        weightSlider.value = 0
                        repsSlider.value = 0
                    }
                    onCheckedChanged: lbSelect.checked = true
                    icon.source: "../images/weight-icon_kg.png"
                }
                Switch {
                    id: lbSelect
                    checked: false
                    onClicked: {
                        kgSelect.checked = false
                        weightSlider.value = 0
                        repsSlider.value = 0
                    }
                    onCheckedChanged: kgSelect.checked = true
                    icon.source: "../images/weight-icon_lb.png"
                }
            }

            Slider {
                id: weightSlider
                minimumValue: lbSelect.checked ? 45 : 20
                maximumValue: lbSelect.checked ? 550 : 250
                stepSize: lbSelect.checked ? 5 : 2.5
                width: parent.width
                valueText: value
                onValueChanged: weightSliderWarning.visible = false
                label: lbSelect.checked ? "Select the amount of weight [lb]" : "Select the amount of weight [kg]"
                Rectangle {
                    id: weightSliderWarning
                    anchors.fill: parent
                    color: "red"
                    opacity: 0.5
                    z: -1
                    visible: false
                }
            }

            Slider {
                id: repsSlider
                minimumValue: 2
                maximumValue: 10
                stepSize: 1
                width: parent.width
                valueText: value
                onValueChanged: repsSliderWarning.visible = false
                label: "Select the number of repetitions"
                Rectangle {
                    id: repsSliderWarning
                    anchors.fill: parent
                    color: "red"
                    opacity: 0.5
                    z: -1
                    visible: false
                }
            }

            Button {
                id: calculate
                anchors.horizontalCenter: parent.horizontalCenter
                text: "<p>Calculate my 1RM"
                onClicked: {
                    if(weightSlider.value != 0 && repsSlider.value != 0)
                        pageStack.push(calculatorPage, {}, operationType)
                    if(weightSlider.value == 0) {
                        weightSliderWarning.visible = true
                    }
                    if(repsSlider.value == 0) {
                        repsSliderWarning.visible = true
                    }
                }
            }

Component {
    id: calculatorPage

        SilicaFlickable {
            anchors.fill: parent

            // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
            PullDownMenu {

                MenuItem {
                    text: "About..."
                    onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
                }

                MenuItem {
                    text: "What is 1RM?"
                    onClicked: pageStack.push(Qt.resolvedUrl("Info.qml"))
                }

                MenuItem {
                    text: "Help"
                    onClicked: pageStack.push(Qt.resolvedUrl("Help.qml"))
                }
            }

            // Tell SilicaFlickable the height of its content.
            contentHeight: column.height

            // Place our content in a Column.  The PageHeader is always placed at the top
            // of the page, followed by our content.
            Column {
                id: column
                width: root.width
                spacing: Theme.paddingLarge

                PageHeader {
                    title: "1RM Calculator"
                }

                Label {
                    x: Theme.paddingMedium
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Your estimated 1RM is:"
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeLarge
                }

                Label {
                    id: functions
                    font.pixelSize: Theme.fontSizeExtraLarge
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: lbSelect.checked ? Math.min(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) + "-" + Math.max(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) + " lb" : Math.min(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) + "-" + Math.max(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) + " kg"
                    color: Theme.highlightColor

                    // Brzycki: 1RM = W x (36 / (37 - R))
                    function brzycki_kg() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(weights * (36 / (37 - reps))/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                    }

                    function brzycki_lb() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(weights * (36 / (37 - reps))/5)*5).toFixed(0)
                    }

                    // Epley: 1RM = W x (1 + R / 30)
                    function epley_kg() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(weights * (1 + reps / 30)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                    }

                    function epley_lb() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(weights * (1 + reps / 30)/5)*5).toFixed(0)
                    }

                    // Lander: 1RM = 100 x W / (101.3 - 2.67123 x R)
                    function lander_kg() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(100 * weights / (101.3 - 2.67123 * reps)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                    }

                    function lander_lb() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(100 * weights / (101.3 - 2.67123 * reps)/5)*5).toFixed(0)
                    }

                    // Lombardi: 1RM = W x R^0.1
                    function lombardi_kg() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(weights * Math.pow(reps, 0.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                    }

                    function lombardi_lb() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(weights * Math.pow(reps, 0.1)/5)*5).toFixed(0)
                    }

                    // Mayhew et al.: 1RM = 100 x W / (52.2 + (41.9 x e^(-0.055 x R)))
                    function mayhew_kg() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(100 * weights / (52.2 + (41.9 * Math.pow(Math.E, (-0.055 * reps))))/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                    }

                    function mayhew_lb() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(100 * weights / (52.2 + (41.9 * Math.pow(Math.E, (-0.055 * reps))))/5)*5).toFixed(0)
                    }

                    // O'Conner et al.: 1RM = W x (1 + 0.025 x R)
                    function oconner_kg() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(weights * (1 + 0.025 * reps)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                    }

                    function oconner_lb() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(weights * (1 + 0.025 * reps)/5)*5).toFixed(0)
                    }

                    // Wathan: 1RM = 100 x W / (48.8 + (53.8 x e^(-0.075 x R)))
                    function wathan_kg() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(100 * weights / (48.8 + (53.8 * Math.pow(Math.E, (-0.075 * reps))))/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                    }

                    function wathan_lb() {
                        var weights = weightSlider.value
                        var reps = repsSlider.value
                        return(Math.round(100 * weights / (48.8 + (53.8 * Math.pow(Math.E, (-0.075 * reps))))/5)*5).toFixed(0)
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        text: "<p>According to these equations<p>"
                        color: "white"
                    }

                    Row {
                        spacing: 20

                        Rectangle { width: 205; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: "Brzycki:" }
                        }

                        Rectangle { width: 100; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? functions.brzycki_lb() : functions.brzycki_kg() }
                        }

                        Rectangle { width: 50; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? "lb" : "kg" }
                        }
                    }

                    Row {
                        spacing: 20

                        Rectangle { width: 205; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: "Epley:" }
                        }

                        Rectangle { width: 100; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? functions.epley_lb() : functions.epley_kg() }
                        }

                        Rectangle { width: 50; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? "lb" : "kg" }
                        }
                    }

                    Row {
                        spacing: 20

                        Rectangle { width: 205; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: "Lander:" }
                        }

                        Rectangle { width: 100; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? functions.lander_lb() : functions.lander_kg() }
                        }

                        Rectangle { width: 50; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? "lb" : "kg" }
                        }
                    }

                    Row {
                        spacing: 20

                        Rectangle { width: 205; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: "Lombardi:" }
                        }

                        Rectangle { width: 100; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? functions.lombardi_lb() : functions.lombardi_kg() }
                        }

                        Rectangle { width: 50; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? "lb" : "kg" }
                        }
                    }

                    Row {
                        spacing: 20

                        Rectangle { width: 205; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: "Mayhew et al.:" }
                        }

                        Rectangle { width: 100; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? functions.mayhew_lb() : functions.mayhew_kg() }
                        }

                        Rectangle { width: 50; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? "lb" : "kg" }
                        }
                    }

                    Row {
                        spacing: 20

                        Rectangle { width: 205; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: "O'Conner et al.:" }
                        }

                        Rectangle { width: 100; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? functions.oconner_lb() : functions.oconner_kg() }
                        }

                        Rectangle { width: 50; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? "lb" : "kg" }
                        }
                    }

                    Row {
                        spacing: 20

                        Rectangle { width: 205; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: "Wathan:" }
                        }

                        Rectangle { width: 100; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? functions.wathan_lb() : functions.wathan_kg() }
                        }

                        Rectangle { width: 50; height: 40; color: "transparent"
                                    Text { font.pointSize: 19; color: "white"; text: lbSelect.checked ? "lb" : "kg" }
                        }
                    }
                }

                Text {
                    width: parent.width - 2*Theme.paddingLarge
                    x: Theme.paddingLarge
                    horizontalAlignment: Text.AlignJustify
                    font.pointSize: 18
                    color: Theme.highlightColor
                    text: "<p><u>Remember:</u> these equations gives you the <i>estimated</i> 1RM lift and the results are not 100 % accurate. The degree of accuracy can vary between different weight training exercises as well as the weight training experience and muscular composition of the trainee."
                    wrapMode: TextEdit.WordWrap
                    }
                }
                }
            }
            }
        }
    }
}
