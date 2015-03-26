import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: calculatorPage

    property bool backStepping: true
    property int operationType: PageStackAction.Animated

    function switchOperationType() {
        operationType = (operationType === PageStackAction.Immediate ? PageStackAction.Animated : PageStackAction.Immediate)
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        PullDownMenu {

            MenuItem {
                text: "About..."
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }
            }

            MenuItem {
                text: "What is 1RM?"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("InfoPage.qml"))
                }
            }

            MenuItem {
                text: "Help"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("HelpPage.qml"))
                }
            }
        }

        Column {
            id: column
            width: calculatorPage.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "1RM Calculator"
                description: "Calculate your estimated 1RM!"
            }

            Row {
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                Switch {
                    id: kgSelect
                    checked: true
                    onClicked: {
                        lbSelect.checked = false
                        lbButtons.visible = false
                        kgSlider.visible = true
                        kgFunctions.visible = true
                    }
                    onCheckedChanged: {
                        lbSelect.checked = true
                        kgButtons.visible = true
                        kgSlider.visible = false
                        kgFunctions.visible = false
                    }
                    icon.source: "../images/weight-icon_kg.png"
                }

                Switch {
                    id: lbSelect
                    checked: false
                    onClicked: {
                        kgSelect.checked = false
                        kgButtons.visible = false
                        lbSlider.visible = true
                        lbFunctions.visible = true
                    }
                    onCheckedChanged: {
                        kgSelect.checked = true
                        lbButtons.visible = true
                        lbSlider.visible = false
                        lbFunctions.visible = false
                    }
                    icon.source: "../images/weight-icon_lb.png"
                }
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Select unit"
                font.pixelSize: 28
                color: Theme.secondaryColor
            }

            Slider {
                id: kgSlider
                value: 20
                minimumValue: 20
                maximumValue: 300
                stepSize: 2.5
                width: parent.width
                valueText: value + " kg"
                label: "Select the amount of weight"
                visible: true
            }

            Slider {
                id: lbSlider
                value: 45
                minimumValue: 45
                maximumValue: 660
                stepSize: 5
                width: parent.width
                valueText: value + " lb"
                label: "Select the amount of weight"
                visible: false
            }

            Row {
                id: kgButtons
                spacing: 150
                anchors.horizontalCenter: parent.horizontalCenter
                visible: {
                    if(kgSelect.checked == true)
                        return(kgButtons.visible = true)
                    else
                        return(kgButtons.visible = false)
                }

                MouseArea {
                    id: kgMinusButton
                    height: 70
                    width: 120
                    onClicked: {
                        if(kgSlider.value > 20)
                            return(kgSlider.value = kgSlider.value - 2.5)
                    }

                    Label {
                        anchors.centerIn: parent
                        text: "−2.5 kg"
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "red"
                        opacity: 0.4
                        z: -1
                        radius: 20
                    }
                }

                MouseArea {
                    id: kgPlusButton
                    height: 70
                    width: 120
                    onClicked: {
                        if(kgSlider.value < 300)
                            return(kgSlider.value = kgSlider.value + 2.5)
                    }

                    Label {
                        anchors.centerIn: parent
                        text: "+2.5 kg"
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "green"
                        opacity: 0.4
                        z: -1
                        radius: 20
                    }
                }
            }

            Row {
                id: lbButtons
                spacing: 150
                anchors.horizontalCenter: parent.horizontalCenter
                visible: {
                    if(lbSelect.checked == true)
                        return(lbButtons.visible = true)
                    else
                        return(lbButtons.visible = false)
                }

                MouseArea {
                    id: lbMinusButton
                    height: 70
                    width: 120
                    onClicked: {
                        if(lbSlider.value > 45)
                            return(lbSlider.value = lbSlider.value - 5)
                    }

                    Label {
                        anchors.centerIn: parent
                        text: "−5 lb"
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "red"
                        opacity: 0.4
                        z: -1
                        radius: 20
                    }
                }

                MouseArea {
                    id: lbPlusButton
                    height: 70
                    width: 120
                    onClicked: {
                        if(lbSlider.value < 660)
                            return(lbSlider.value = lbSlider.value + 5)
                    }

                    Label {
                        anchors.centerIn: parent
                        text: "+5 lb"
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "green"
                        opacity: 0.4
                        z: -1
                        radius: 20
                    }
                }
            }

            Slider {
                id: repsSlider
                minimumValue: 2
                maximumValue: 10
                value: 2
                stepSize: 1
                width: parent.width
                valueText: value + " reps"
                label: "Select the number of repetitions"
            }

            Item {
                width: parent.width
                height: 25
            }

            Button {
                id: calculate
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Calculate my 1RM!"
                onClicked: pageStack.push(resultsPage, {}, operationType)
            }

            Component {
                id: resultsPage

                Page {
                    onStatusChanged: {
                        if(status == PageStatus.Active) {
                            return(pageStack.pushAttached(percentagesPage, {}, operationType))
                        }
                    }

                    SilicaFlickable {
                        anchors.fill: parent
                        contentHeight: column.height

                        Column {
                            id: column
                            width: calculatorPage.width
                            spacing: Theme.paddingLarge

                            PageHeader {
                                title: "1RM Calculator"
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
                                id: kgFunctions
                                font.pixelSize: Theme.fontSizeExtraLarge
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.highlightColor
                                text: {
                                    if(Math.min(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) === Math.max(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()))
                                        return(kgFunctions.text = Math.min(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) + " kg")
                                    else
                                        return(Math.min(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) + " - " + Math.max(brzycki_kg(), epley_kg(), lander_kg(), lombardi_kg(), mayhew_kg(), oconner_kg(), wathan_kg()) + " kg")
                                }
                                visible: {
                                    if(kgSelect.checked == true)
                                        return(kgFunctions.visible = true)
                                    else
                                        return(kgFunctions.visible = false)
                                }

                                // Brzycki: 1RM = W x (36 / (37 - R))
                                function brzycki_kg() {
                                    var weights = kgSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(weights * (36 / (37 - reps))/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                                }

                                // Epley: 1RM = W x (1 + R / 30)
                                function epley_kg() {
                                    var weights = kgSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(weights * (1 + reps / 30)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                                }

                                // Lander: 1RM = 100 x W / (101.3 - 2.67123 x R)
                                function lander_kg() {
                                    var weights = kgSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(100 * weights / (101.3 - 2.67123 * reps)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                                }

                                // Lombardi: 1RM = W x R^0.1
                                function lombardi_kg() {
                                    var weights = kgSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(weights * Math.pow(reps, 0.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                                }

                                // Mayhew et al.: 1RM = 100 x W / (52.2 + (41.9 x e^(-0.055 x R)))
                                function mayhew_kg() {
                                    var weights = kgSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(100 * weights / (52.2 + (41.9 * Math.pow(Math.E, (-0.055 * reps))))/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                                }

                                // O'Conner et al.: 1RM = W x (1 + 0.025 x R)
                                function oconner_kg() {
                                    var weights = kgSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(weights * (1 + 0.025 * reps)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                                }

                                // Wathan: 1RM = 100 x W / (48.8 + (53.8 x e^(-0.075 x R)))
                                function wathan_kg() {
                                    var weights = kgSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(100 * weights / (48.8 + (53.8 * Math.pow(Math.E, (-0.075 * reps))))/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                                }
                            }

                            Label {
                                id: lbFunctions
                                font.pixelSize: Theme.fontSizeExtraLarge
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.highlightColor
                                text: {
                                    if(Math.min(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) === Math.max(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()))
                                        return(lbFunctions.text = Math.min(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) + " lb")
                                    else
                                        return(Math.min(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) + " - " + Math.max(brzycki_lb(), epley_lb(), lander_lb(), lombardi_lb(), mayhew_lb(), oconner_lb(), wathan_lb()) + " lb")
                                }
                                visible: {
                                    if(lbSelect.checked == true)
                                        return(lbFunctions.visible = true)
                                    else
                                        return(lbFunctions.visible = false)
                                }

                                // Brzycki: 1RM = W x (36 / (37 - R))
                                function brzycki_lb() {
                                    var weights = lbSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(weights * (36 / (37 - reps))/5)*5).toFixed(0)
                                }

                                // Epley: 1RM = W x (1 + R / 30)
                                function epley_lb() {
                                    var weights = lbSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(weights * (1 + reps / 30)/5)*5).toFixed(0)
                                }

                                // Lander: 1RM = 100 x W / (101.3 - 2.67123 x R)
                                function lander_lb() {
                                    var weights = lbSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(100 * weights / (101.3 - 2.67123 * reps)/5)*5).toFixed(0)
                                }

                                // Lombardi: 1RM = W x R^0.1
                                function lombardi_lb() {
                                    var weights = lbSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(weights * Math.pow(reps, 0.1)/5)*5).toFixed(0)
                                }

                                // Mayhew et al.: 1RM = 100 x W / (52.2 + (41.9 x e^(-0.055 x R)))
                                function mayhew_lb() {
                                    var weights = lbSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(100 * weights / (52.2 + (41.9 * Math.pow(Math.E, (-0.055 * reps))))/5)*5).toFixed(0)
                                }

                                // O'Conner et al.: 1RM = W x (1 + 0.025 x R)
                                function oconner_lb() {
                                    var weights = lbSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(weights * (1 + 0.025 * reps)/5)*5).toFixed(0)
                                }

                                // Wathan: 1RM = 100 x W / (48.8 + (53.8 x e^(-0.075 x R)))
                                function wathan_lb() {
                                    var weights = lbSlider.value
                                    var reps = repsSlider.value
                                    return(Math.round(100 * weights / (48.8 + (53.8 * Math.pow(Math.E, (-0.075 * reps))))/5)*5).toFixed(0)
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
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? lbFunctions.brzycki_lb() : kgFunctions.brzycki_kg() }
                                    }

                                    Rectangle { width: 50; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? "lb" : "kg" }
                                    }
                                }

                                Row {
                                    spacing: 20

                                    Rectangle { width: 205; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Epley" }
                                    }

                                    Rectangle { width: 100; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? lbFunctions.epley_lb() : kgFunctions.epley_kg() }
                                    }

                                    Rectangle { width: 50; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? "lb" : "kg" }
                                    }
                                }

                                Row {
                                    spacing: 20

                                    Rectangle { width: 205; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Lander" }
                                    }

                                    Rectangle { width: 100; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? lbFunctions.lander_lb() : kgFunctions.lander_kg() }
                                    }

                                    Rectangle { width: 50; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? "lb" : "kg" }
                                    }
                                }

                                Row {
                                    spacing: 20

                                    Rectangle { width: 205; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Lombardi" }
                                    }

                                    Rectangle { width: 100; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? lbFunctions.lombardi_lb() : kgFunctions.lombardi_kg() }
                                    }

                                    Rectangle { width: 50; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? "lb" : "kg" }
                                    }
                                }

                                Row {
                                    spacing: 20

                                    Rectangle { width: 205; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Mayhew et al." }
                                    }

                                    Rectangle { width: 100; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? lbFunctions.mayhew_lb() : kgFunctions.mayhew_kg() }
                                    }

                                    Rectangle { width: 50; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? "lb" : "kg" }
                                    }
                                }

                                Row {
                                    spacing: 20

                                    Rectangle { width: 205; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "O'Conner et al." }
                                    }

                                    Rectangle { width: 100; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? lbFunctions.oconner_lb() : kgFunctions.oconner_kg() }
                                    }

                                    Rectangle { width: 50; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? "lb" : "kg" }
                                    }
                                }

                                Row {
                                    spacing: 20

                                    Rectangle { width: 205; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: "Wathan" }
                                    }

                                    Rectangle { width: 100; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? lbFunctions.wathan_lb() : kgFunctions.wathan_kg() }
                                    }

                                    Rectangle { width: 50; height: 40; color: "transparent"
                                        Text { font.pointSize: 19; color: Theme.primaryColor; text: lbSelect.checked ? "lb" : "kg" }
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

                        Page {
                            id: percentagesPage

                            SilicaListView {
                                anchors.fill: parent

                                VerticalScrollDecorator {}

                                header: PageHeader {
                                    title: "1RM Calculator"
                                    description: "Percentages table"
                                }

                                Grid {
                                    id: gridHeader
                                    rows: 1
                                    columns: 8
                                    spacing: -1
                                    anchors.left: parent.left
                                    anchors.leftMargin: 4
                                    anchors.top: parent.top
                                    anchors.topMargin: 125

                                    Repeater {
                                        model: headerModel

                                        Rectangle {
                                            width: (percentagesPage.width / 8)
                                            height: 140
                                            color: "transparent"
                                            border.color: Theme.highlightColor
                                            border.width: 1

                                            Label {
                                                text: model.text
                                                font.pixelSize: 20
                                                font.bold: true
                                                rotation: -80
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                }

                                Grid {
                                    id: gridHighPercentages
                                    rows: 5
                                    columns: 8
                                    spacing: -1
                                    anchors.left: parent.left
                                    anchors.leftMargin: 4
                                    anchors.top: gridHeader.bottom
                                    anchors.topMargin: -1

                                    Repeater {
                                        model: highPercentagesModel

                                        Rectangle {
                                            width: (percentagesPage.width / 8)
                                            height: (width / 2)
                                            color: "transparent"
                                            border.color: Theme.highlightColor
                                            border.width: 1

                                            Label {
                                                text: model.text
                                                font.pixelSize: 20
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                }

                                Grid {
                                    id: gridMidPercentages
                                    rows: 1
                                    columns: 8
                                    spacing: -1
                                    anchors.left: parent.left
                                    anchors.leftMargin: 4
                                    anchors.top: gridHighPercentages.bottom
                                    anchors.topMargin: -1

                                    Repeater {
                                        model: midPercentagesModel

                                        Rectangle {
                                            width: (percentagesPage.width / 8)
                                            height: (width / 2)
                                            color: "transparent"
                                            border.color: Theme.highlightColor
                                            border.width: 1

                                            Label {
                                                text: model.text
                                                font.pixelSize: 20
                                                font.bold: true
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                }

                                Grid {
                                    id: gridLowPercentages
                                    rows: 15
                                    columns: 8
                                    spacing: -1
                                    anchors.left: parent.left
                                    anchors.leftMargin: 4
                                    anchors.top: gridMidPercentages.bottom
                                    anchors.topMargin: -1

                                    Repeater {
                                        model: lowPercentagesModel

                                        Rectangle {
                                            width: (percentagesPage.width / 8)
                                            height: (width / 2)
                                            color: "transparent"
                                            border.color: Theme.highlightColor
                                            border.width: 1

                                            Label {
                                                text: model.text
                                                font.pixelSize: 20
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                }
                            }

                            ListModel {
                                id: headerModel
                            }

                            ListModel {
                                id: highPercentagesModel
                            }

                            ListModel {
                                id: midPercentagesModel
                            }

                            ListModel {
                                id: lowPercentagesModel
                            }

                            pageContainer: {
                                addHeader()
                                addHighPercentages()
                                addMidPercentages()
                                addLowPercentages()
                            }

                            function addHeader() {
                                var entries = 8
                                var header = [ lbSelect.checked ? "[lb]" : "[kg]",
                                    "Brzycki",
                                    "Epley",
                                    "Lander",
                                    "Lombardi",
                                    "Mayhew et al.",
                                    "O'Conner et al.",
                                    "Wathan" ]

                                for (var index = 0; index < entries; index++) {
                                    headerModel.append({"text": header[index * 1]})
                                }
                            }

                            function addHighPercentages() {
                                var entries = 40
                                var highPercentages = [ "125 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*1.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*1.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*1.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*1.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*1.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*1.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*1.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*1.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*1.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*1.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*1.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*1.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*1.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*1.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "120 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*1.2)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*1.2)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*1.2)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*1.2)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*1.2)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*1.2)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*1.2)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*1.2)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*1.2)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*1.2)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*1.2)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*1.2)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*1.2)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*1.2)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "115 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*1.15)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*1.15)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*1.15)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*1.15)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*1.15)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*1.15)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*1.15)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*1.15)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*1.15)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*1.15)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*1.15)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*1.15)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*1.15)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*1.15)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "110 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*1.1)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*1.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*1.1)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*1.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*1.1)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*1.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*1.1)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*1.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*1.1)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*1.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*1.1)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*1.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*1.1)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*1.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "105 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*1.05)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*1.05)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*1.05)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*1.05)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*1.05)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*1.05)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*1.05)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*1.05)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*1.05)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*1.05)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*1.05)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*1.05)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*1.05)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*1.05)/2.5)*2.5).toFixed(1).replace(/.0+$/, "") ]

                                for (var index = 0; index < entries; index++) {
                                    highPercentagesModel.append({"text": highPercentages[index * 1]})
                                }
                            }

                            function addMidPercentages() {
                                var entries = 8
                                var midPercentages = [ "100 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb())/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg())/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb())/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg())/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb())/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg())/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb())/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg())/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb())/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg())/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb())/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg())/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb())/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg())/2.5)*2.5).toFixed(1).replace(/.0+$/, "") ]

                                for (var index = 0; index < entries; index++) {
                                    midPercentagesModel.append({"text": midPercentages[index * 1]})
                                }
                            }

                            function addLowPercentages() {
                                var entries = 120
                                var lowPercentages = [ "95 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.95)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.95)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.95)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.95)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.95)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.95)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.95)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.95)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.95)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.95)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.95)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.95)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.95)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.95)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "90 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.9)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.9)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.9)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.9)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.9)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.9)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.9)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.9)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.9)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.9)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.9)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.9)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.9)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.9)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "85 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.85)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.85)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.85)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.85)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.85)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.85)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.85)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.85)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.85)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.85)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.85)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.85)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.85)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.85)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "80 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.8)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.8)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.8)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.8)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.8)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.8)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.8)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.8)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.8)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.8)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.8)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.8)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.8)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.8)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "75 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.75)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.75)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.75)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.75)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.75)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.75)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.75)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.75)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.75)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.75)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.75)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.75)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.75)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.75)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "70 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.7)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.7)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.7)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.7)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.7)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.7)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.7)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.7)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.7)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.7)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.7)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.7)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.7)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.7)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "65 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.65)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.65)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.65)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.65)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.65)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.65)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.65)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.65)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.65)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.65)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.65)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.65)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.65)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.65)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "60 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.6)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.6)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.6)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.6)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.6)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.6)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.6)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.6)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.6)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.6)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.6)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.6)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.6)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.6)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "55 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.55)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.55)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.55)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.55)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.55)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.55)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.55)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.55)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.55)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.55)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.55)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.55)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.55)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.55)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "50 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.5)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.5)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.5)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.5)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.5)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.5)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.5)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.5)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.5)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.5)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.5)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.5)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.5)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.5)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "45 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.45)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.45)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.45)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.45)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.45)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.45)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.45)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.45)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.45)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.45)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.45)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.45)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.45)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.45)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "40 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.4)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.4)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.4)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.4)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.4)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.4)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.4)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.4)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.4)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.4)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.4)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.4)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.4)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.4)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "35 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.35)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.35)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.35)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.35)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.35)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.35)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.35)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.35)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.35)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.35)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.35)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.35)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.35)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.35)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "30 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.3)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.3)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.3)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.3)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.3)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.3)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.3)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.3)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.3)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.3)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.3)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.3)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.3)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.3)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  "25 %",
                                                  lbSelect.checked ? (Math.round((lbFunctions.brzycki_lb()*0.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.brzycki_kg()*0.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.epley_lb()*0.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.epley_kg()*0.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lander_lb()*0.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.lander_kg()*0.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.lombardi_lb()*0.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.lombardi_kg()*0.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.mayhew_lb()*0.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.mayhew_kg()*0.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.oconner_lb()*0.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.oconner_kg()*0.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, ""),
                                                  lbSelect.checked ? (Math.round((lbFunctions.wathan_lb()*0.25)/5)*5).toFixed(0) : (Math.round((kgFunctions.wathan_kg()*0.25)/2.5)*2.5).toFixed(1).replace(/.0+$/, "") ]

                                for (var index = 0; index < entries; index++) {
                                    lowPercentagesModel.append({"text": lowPercentages[index * 1]})
                                }
                            }
                    }
                }
            }
        }
    }
}
