import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/Preferences.js" as Preferences


Page {
    id: percentages1RM

    property string kgUnit: parseInt(Preferences.get("kgUnit"))
    property string lbUnit: parseInt(Preferences.get("lbUnit"))
    property string kgIncrement: parseFloat(Preferences.get("kgIncrement"))
    property string lbIncrement: parseFloat(Preferences.get("lbIncrement"))
    property string brzycki_kg: parseFloat(Preferences.get("brzycki_kg_1RM"))
    property string epley_kg: parseFloat(Preferences.get("epley_kg_1RM"))
    property string lander_kg: parseFloat(Preferences.get("lander_kg_1RM"))
    property string lombardi_kg: parseFloat(Preferences.get("lombardi_kg_1RM"))
    property string mayhew_kg: parseFloat(Preferences.get("mayhew_kg_1RM"))
    property string oconner_kg: parseFloat(Preferences.get("oconner_kg_1RM"))
    property string wathan_kg: parseFloat(Preferences.get("wathan_kg_1RM"))
    property string brzycki_lb: parseFloat(Preferences.get("brzycki_lb_1RM"))
    property string epley_lb: parseFloat(Preferences.get("epley_lb_1RM"))
    property string lander_lb: parseFloat(Preferences.get("lander_lb_1RM"))
    property string lombardi_lb: parseFloat(Preferences.get("lombardi_lb_1RM"))
    property string mayhew_lb: parseFloat(Preferences.get("mayhew_lb_1RM"))
    property string oconner_lb: parseFloat(Preferences.get("oconner_lb_1RM"))
    property string wathan_lb: parseFloat(Preferences.get("wathan_lb_1RM"))

    SilicaListView {
        anchors.fill: parent

        VerticalScrollDecorator {}

        header: PageHeader {
            title: appName
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
                    width: (percentages1RM.width / 8)
                    height: 140
                    color: "transparent"
                    border.color: Theme.highlightColor
                    border.width: 1

                    Label {
                        text: model.text
                        font.pixelSize: 20
                        font.bold: true
                        rotation: -75
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
                    width: (percentages1RM.width / 8)
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
                    width: (percentages1RM.width / 8)
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
                    width: (percentages1RM.width / 8)
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
        var kgunit = kgUnit
        var header = [ kgunit == 1 ? "[kg]" : "[lb]",
                       "Brzycki",
                       "Epley",
                       "Lander",
                       "Lombardi",
                       "Mayhew et al.",
                       "O'Conner et al.",
                       "Wathan" ]

        for(var index = 0; index < entries; index++) {
            headerModel.append({"text": header[index * 1]})
        }
    }

    function addHighPercentages() {
        var entries = 40
        var kgunit = kgUnit
        var kgincrement = kgIncrement
        var lbincrement = lbIncrement
        var highPercentages = [ "125 %",
                                kgunit == 1 ? (Math.round((brzycki_kg * 1.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 1.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((epley_kg * 1.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 1.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lander_kg * 1.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 1.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lombardi_kg * 1.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 1.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((mayhew_kg * 1.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 1.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((oconner_kg * 1.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 1.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((wathan_kg * 1.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 1.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                "120 %",
                                kgunit == 1 ? (Math.round((brzycki_kg * 1.2) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 1.2) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((epley_kg * 1.2) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 1.2) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lander_kg * 1.2) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 1.2) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lombardi_kg * 1.2) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 1.2) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((mayhew_kg * 1.2) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 1.2) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((oconner_kg * 1.2) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 1.2) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((wathan_kg * 1.2) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 1.2) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                "115 %",
                                kgunit == 1 ? (Math.round((brzycki_kg * 1.15) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 1.15) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((epley_kg * 1.15) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 1.15) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lander_kg * 1.15) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 1.15) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lombardi_kg * 1.15) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 1.15) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((mayhew_kg * 1.15) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 1.15) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((oconner_kg * 1.15) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 1.15) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((wathan_kg * 1.15) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 1.15) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                "110 %",
                                kgunit == 1 ? (Math.round((brzycki_kg * 1.1) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 1.1) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((epley_kg * 1.1) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 1.1) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lander_kg * 1.1) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 1.1) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lombardi_kg * 1.1) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 1.1) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((mayhew_kg * 1.1) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 1.1) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((oconner_kg * 1.1) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 1.1) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((wathan_kg * 1.1) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 1.1) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                "105 %",
                                kgunit == 1 ? (Math.round((brzycki_kg * 1.05) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 1.05) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((epley_kg * 1.05) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 1.05) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lander_kg * 1.05) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 1.05) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((lombardi_kg * 1.05) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 1.05) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((mayhew_kg * 1.05) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 1.05) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((oconner_kg * 1.05) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 1.05) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                                kgunit == 1 ? (Math.round((wathan_kg * 1.05) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 1.05) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, "") ]

        for(var index = 0; index < entries; index++) {
            highPercentagesModel.append({"text": highPercentages[index * 1]})
        }
    }

    function addMidPercentages() {
        var entries = 8
        var kgunit = kgUnit
        var kgincrement = kgIncrement
        var lbincrement = lbIncrement
        var midPercentages = [ "100 %",
                               kgunit == 1 ? (Math.round((brzycki_kg) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, "") ]

        for(var index = 0; index < entries; index++) {
            midPercentagesModel.append({"text": midPercentages[index * 1]})
        }
    }

    function addLowPercentages() {
        var entries = 120
        var kgunit = kgUnit
        var kgincrement = kgIncrement
        var lbincrement = lbIncrement
        var lowPercentages = [ "95 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.95) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.95) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.95) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.95) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.95) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.95) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.95) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.95) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.95) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.95) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.95) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.95) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.95) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.95) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "90 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.9) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.9) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.9) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.9) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.9) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.9) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.9) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.9) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.9) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.9) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.9) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.9) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.9) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.9) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "85 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.85) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.85) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.85) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.85) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.85) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.85) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.85) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.85) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.85) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.85) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.85) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.85) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.85) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.85) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "80 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.8) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.8) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.8) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.8) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.8) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.8) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.8) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.8) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.8) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.8) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.8) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.8) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.8) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.8) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "75 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.75) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.75) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.75) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.75) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.75) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.75) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.75) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.75) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.75) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.75) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.75) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.75) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.75) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.75) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "70 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.7) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.7) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.7) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.7) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.7) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.7) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.7) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.7) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.7) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.7) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.7) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.7) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.7) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.7) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "65 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.65) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.65) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.65) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.65) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.65) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.65) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.65) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.65) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.65) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.65) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.65) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.65) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.65) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.65) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "60 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.6) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.6) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.6) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.6) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.6) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.6) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.6) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.6) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.6) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.6) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.6) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.6) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.6) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.6) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "55 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.55) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.55) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.55) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.55) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.55) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.55) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.55) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.55) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.55) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.55) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.55) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.55) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.55) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.55) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "50 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.5) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.5) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.5) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.5) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.5) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.5) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.5) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.5) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.5) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.5) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.5) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.5) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.5) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.5) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "45 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.45) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.45) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.45) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.45) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.45) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.45) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.45) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.45) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.45) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.45) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.45) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.45) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.45) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.45) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "40 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.4) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.4) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.4) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.4) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.4) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.4) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.4) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.4) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.4) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.4) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.4) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.4) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.4) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.4) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "35 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.35) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.35) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.35) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.35) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.35) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.35) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.35) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.35) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.35) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.35) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.35) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.35) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.35) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.35) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "30 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.3) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.3) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.3) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.3) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.3) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.3) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.3) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.3) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.3) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.3) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.3) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.3) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.3) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.3) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               "25 %",
                               kgunit == 1 ? (Math.round((brzycki_kg * 0.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((brzycki_lb * 0.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((epley_kg * 0.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((epley_lb * 0.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lander_kg * 0.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lander_lb * 0.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((lombardi_kg * 0.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((lombardi_lb * 0.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((mayhew_kg * 0.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((mayhew_lb * 0.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((oconner_kg * 0.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((oconner_lb * 0.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, ""),
                               kgunit == 1 ? (Math.round((wathan_kg * 0.25) / kgincrement) * kgincrement).toFixed(2).replace(/\.0+$/, "") : (Math.round((wathan_lb * 0.25) / lbincrement) * lbincrement).toFixed(2).replace(/\.0+$/, "") ]

        for(var index = 0; index < entries; index++) {
            lowPercentagesModel.append({"text": lowPercentages[index * 1]})
        }
    }
}
