import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/Preferences.js" as Preferences


Page {
    id: root
    onStatusChanged: {
        Preferences.initializeDatabase()
        root.refresh()
    }

    Component.onCompleted: {
        Preferences.initializeDatabase()
        root.refresh()
    }

    property string kgValue: parseFloat(Preferences.get("kgValue"))
    property string lbValue: parseFloat(Preferences.get("lbValue"))
    property string repsValue: parseInt(Preferences.get("repsValue"))
    property string kgUnit: parseInt(Preferences.get("kgUnit"))
    property string lbUnit: parseInt(Preferences.get("lbUnit"))
    property string kgIncrement: parseFloat(Preferences.get("kgIncrement"))
    property string lbIncrement: parseFloat(Preferences.get("lbIncrement"))
    property bool backStepping: true
    property int operationType: PageStackAction.Animated

    function refresh() {
        Preferences.getDatabase()
        kgValueLabel.text = parseFloat(Preferences.get("kgValue"))
        lbValueLabel.text = parseFloat(Preferences.get("lbValue"))
        repsValueLabel.text = parseInt(Preferences.get("repsValue"))
        kgUnitLabel.text = parseInt(Preferences.get("kgUnit"))
        lbUnitLabel.text = parseInt(Preferences.get("lbUnit"))
        kgIncrementLabel.text = parseFloat(Preferences.get("kgIncrement"))
        lbIncrementLabel.text = parseFloat(Preferences.get("lbIncrement"))
        //console.debug("root refreshed")
    }

    function switchOperationType() {
        operationType = (operationType === PageStackAction.Immediate ? PageStackAction.Animated : PageStackAction.Immediate)
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        PullDownMenu {

            MenuItem {
                id: calc1RM
                text: qsTr("1RM calculator")
                onClicked: {
                    calcRepMax.visible = true
                    calc1RM.visible = false
                    pageHeader.description = qsTr("Calculate your estimated 1RM!")
                    kgSlider.label = qsTr("Select the amount of weight lifted")
                    lbSlider.label = qsTr("Select the amount of weight lifted")
                    repsSlider.label = qsTr("Select the number of reps performed")
                    calculate1RM.visible = true
                    calculateRepMax.visible = false
                }
                visible: false
            }

            MenuItem {
                id: calcRepMax
                text: qsTr("Rep max calculator")
                onClicked: {
                    calc1RM.visible = true
                    calcRepMax.visible = false
                    pageHeader.description = qsTr("Calculate your estimated rep max!")
                    kgSlider.label = qsTr("Select your 1RM")
                    lbSlider.label = qsTr("Select your 1RM")
                    repsSlider.label = qsTr("Select the desired number of reps")
                    calculateRepMax.visible = true
                    calculate1RM.visible = false
                }
                visible: true
            }
        }

        PushUpMenu {

            MenuItem {
                text: qsTr("Settings")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
                }
            }

            MenuItem {
                text: qsTr("Help")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("HelpPage.qml"))
                }
            }

            MenuItem {
                text: qsTr("About...")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }
            }
        }

        Column {
            id: column
            width: root.width
            spacing: Theme.paddingLarge
            visible: true

            PageHeader {
                id: pageHeader
                title: appName
                description: qsTr("Calculate your estimated 1RM!")
            }

            Item {
                width: parent.width
                height: 70
            }

            Slider {
                id: kgSlider
                minimumValue: 20
                maximumValue: 300
                value: kgValueLabel.text
                stepSize: kgIncrementLabel.text
                width: parent.width
                valueText: value + " kg"
                label: qsTr("Select the amount of weight lifted")
                visible: {
                    if(kgUnitLabel.text == 1)
                        return(true)
                    else
                        return(false)
                }
                onValueChanged: Preferences.set("kgValue", value)
            }

            Slider {
                id: lbSlider
                minimumValue: 45
                maximumValue: 660
                value: lbValueLabel.text
                stepSize: lbIncrementLabel.text
                width: parent.width
                valueText: value + " lb"
                label: qsTr("Select the amount of weight lifted")
                visible: {
                    if(kgUnitLabel.text == 1)
                        return(false)
                    else
                        return(true)
                }
                onValueChanged: Preferences.set("lbValue", value)
            }

            Row {
                id: kgButtons
                spacing: 150
                anchors.horizontalCenter: parent.horizontalCenter
                visible: {
                    if(kgUnitLabel.text == 1)
                        return(true)
                    else
                        return(false)
                }

                MouseArea {
                    id: kgMinusButton
                    height: 70
                    width: 120
                    onClicked: kgMinus()

                    Label {
                        id: kgMinusLabel
                        anchors.centerIn: parent
                        text: "−" + kgIncrementLabel.text + " kg"
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "red"
                        opacity: 0.4
                        z: -1
                        radius: 20
                    }

                    function kgMinus() {
                        var kgincrement = kgIncrementLabel.text * 1
                        if(kgSlider.value > 20)
                            return(kgSlider.value = kgSlider.value - kgincrement)
                    }
                }

                MouseArea {
                    id: kgPlusButton
                    height: 70
                    width: 120
                    onClicked: kgPlus()

                    Label {
                        id: kgPlusLabel
                        anchors.centerIn: parent
                        text: "+" + kgIncrementLabel.text + " kg"
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "green"
                        opacity: 0.4
                        z: -1
                        radius: 20
                    }

                    function kgPlus() {
                        var kgincrement = kgIncrementLabel.text * 1
                        if(kgSlider.value < 300)
                            return(kgSlider.value = kgSlider.value + kgincrement)
                    }
                }
            }

            Row {
                id: lbButtons
                spacing: 150
                anchors.horizontalCenter: parent.horizontalCenter
                visible: {
                    if(kgUnitLabel.text == 1)
                        return(false)
                    else
                        return(true)
                }

                MouseArea {
                    id: lbMinusButton
                    height: 70
                    width: 120
                    onClicked: lbMinus()

                    Label {
                        id: lbMinusLabel
                        anchors.centerIn: parent
                        text: "−" + lbIncrementLabel.text + " lb"
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "red"
                        opacity: 0.4
                        z: -1
                        radius: 20
                    }

                    function lbMinus() {
                        var lbincrement = lbIncrementLabel.text * 1
                        if(lbSlider.value > 45)
                            return(lbSlider.value = lbSlider.value - lbincrement)
                    }
                }

                MouseArea {
                    id: lbPlusButton
                    height: 70
                    width: 120
                    onClicked: lbPlus()

                    Label {
                        id: lbPlusLabel
                        anchors.centerIn: parent
                        text: "+" + lbIncrementLabel.text + " lb"
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "green"
                        opacity: 0.4
                        z: -1
                        radius: 20
                    }

                    function lbPlus() {
                        var lbincrement = lbIncrementLabel.text * 1
                        if(lbSlider.value < 660)
                            return(lbSlider.value = lbSlider.value + lbincrement)
                    }
                }
            }

            Item {
                width: parent.width
                height: 25
            }

            Slider {
                id: repsSlider
                minimumValue: 2
                maximumValue: 12
                value: repsValueLabel.text
                stepSize: 1
                width: parent.width
                valueText: value + qsTr(" reps")
                label: qsTr("Select the number of reps performed")
                onValueChanged: Preferences.set("repsValue", value)
            }

            Item {
                width: parent.width
                height: 25
            }

            Button {
                id: calculate1RM
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Calculate my 1RM!")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("CalcPage1RM.qml"))
                }
                visible: true
            }

            Button {
                id: calculateRepMax
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Calculate my ") + repsSlider.value + qsTr("RM!")
                onClicked: pageStack.push(Qt.resolvedUrl("CalcPageRepMax.qml"))
                visible: false
            }

            Label {
                id: kgValueLabel
                visible: false
            }

            Label {
                id: lbValueLabel
                visible: false
            }

            Label {
                id: repsValueLabel
                visible: false
            }

            Label {
                id: kgUnitLabel
                visible: false
            }

            Label {
                id: lbUnitLabel
                visible: false
            }

            Label {
                id: kgIncrementLabel
                visible: false
            }

            Label {
                id: lbIncrementLabel
                visible: false
            }
        }
    }
}
