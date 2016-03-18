import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../js/Preferences.js" as Preferences

Page {
    id: settingsPage
    onStatusChanged: settingsPage.refresh()

    Component.onCompleted: settingsPage.refresh()

    property string kgUnit: parseInt(Preferences.get("kgUnit"))
    property string lbUnit: parseInt(Preferences.get("lbUnit"))
    property string kgIncrement: parseFloat(Preferences.get("kgIncrement"))
    property string lbIncrement: parseFloat(Preferences.get("lbIncrement"))

    function refresh() {
        Preferences.getDatabase()
        kgSwitch.checked = parseInt(Preferences.get("kgUnit"))
        lbSwitch.checked = parseInt(Preferences.get("lbUnit"))
        kgIncrementSlider.value = parseFloat(Preferences.get("kgIncrement"))
        lbIncrementSlider.value = parseFloat(Preferences.get("lbIncrement"))
        //console.debug("settingsPage refreshed")
    }

    RemorsePopup {
        id: remorse
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator { }

        Column {
            id: column
            width: settingsPage.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: appName
                description: qsTr("Settings")
            }

            SectionHeader {
                text: qsTr("Unit")
            }

            Row {
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                Switch {
                    id: kgSwitch
                    checked: {
                        if(kgUnit == 1)
                            return(true)
                        else
                            return(false)
                    }
                    onClicked: {
                        lbSwitch.checked = false
                        Preferences.set("kgUnit", "1")
                        Preferences.set("lbUnit", "0")
                    }
                    icon.source: "../images/weight-icon_kg.png"
                }

                Switch {
                    id: lbSwitch
                    checked: {
                        if(kgUnit == 1)
                            return(false)
                        else
                            return(true)
                    }
                    onClicked: {
                        kgSwitch.checked = false
                        Preferences.set("lbUnit", "1")
                        Preferences.set("kgUnit", "0")
                    }
                    icon.source: "../images/weight-icon_lb.png"
                }
            }

            Item {
                width: parent.width
                height: 25
            }

            SectionHeader {
                text: qsTr("Increment")
            }

            Slider {
                id: kgIncrementSlider
                minimumValue: 0.5
                maximumValue: 10
                stepSize: 0.25
                width: parent.width
                valueText: value + " kg"
                label: value == 2.5 ? qsTr("Adjust the default increment") : qsTr("Adjust the increment")
                onValueChanged: Preferences.set("kgIncrement", value)
                visible: {
                    if(kgSwitch.checked == true)
                        return(true)
                    else
                        return(false)
                }
            }

            Slider {
                id: lbIncrementSlider
                minimumValue: 1
                maximumValue: 20
                stepSize: 0.5
                width: parent.width
                valueText: value + " lb"
                label: value == 5 ? qsTr("Adjust the default increment") : qsTr("Adjust the increment")
                onValueChanged: Preferences.set("lbIncrement", value)
                visible: {
                    if(lbSwitch.checked == true)
                        return(true)
                    else
                        return(false)
                }
            }

            Item {
                width: parent.width
                height: 25
            }

            SectionHeader {
                text: qsTr("<b>Warning! Reset button below!</b>")
            }

            Item {
                width: parent.width
                height: 25
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Reset database/settings")
                onClicked: {
                    remorse.execute(qsTr("Resetting database/settings"),
                        function() {
                            Preferences.resetDatabase();
                            settingsPage.refresh();
                        }
                    );
                }
            }
        }
    }
}
