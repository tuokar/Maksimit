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
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml")), warning.visible = false
            }
            MenuItem {
                text: "What is 1RM?"
                onClicked: pageStack.push(Qt.resolvedUrl("Info.qml")), warning.visible = false
            }
            MenuItem {
                text: "Help"
                onClicked: pageStack.push(Qt.resolvedUrl("Help.qml")), warning.visible = false
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
                text: "Just enter the amount of weight you lifted and the number of repetitions completed that time (max. 10 reps). Then hit 'Calculate my 1RM' to get your estimated <b>ONE REPETITION MAXIMUM!</b><p>"
                wrapMode: TextEdit.WordWrap
            }

            TextField {
                id: w
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Enter the amount of weight"
                placeholderText: label
                validator: DoubleValidator { bottom: 20; top: 600; decimals: 1; }
                onTextChanged: { if (parseFloat(w.text) > 19.9 && parseFloat(w.text) < 600.1)
                                     EnterKey.enabled = true
                                 else(EnterKey.enabled = false) }
                focusOutBehavior: { if(w.text && r.text != 0)
                                        warning.visible = false; }
                EnterKey.enabled: text.length > 0
                EnterKey.onClicked: { if(w.text && r.text != 0)
                                          warning.visible = false;
                                      parent.focus = true; }
            }

            TextField {
                id: r
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Enter the number of repetitons"
                placeholderText: label
                validator: RegExpValidator { regExp: /^([1-9]{1}|10)$/ }
                focusOutBehavior: { if(w.text && r.text != 0)
                                        warning.visible = false; }
                EnterKey.enabled: text.length > 0
                EnterKey.onClicked: { if(w.text && r.text != 0)
                                          warning.visible = false;
                                      parent.focus = true; }
            }

            Button {
                id: calculate
                anchors.horizontalCenter: parent.horizontalCenter
                text: "<p>Calculate my 1RM"
                onClicked: { if(w.text && r.text != 0)
                                pageStack.push(calculatorpage, {}, operationType), warning.visible = false
                             else(warning.visible = true) }
            }

            Text {
                id: warning
                x: 25; y: 0; width: 500;
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 20
                color: "red"
                text: "<p>Enter the weight lifted and/or repetitions completed before calculating!"
                visible: false
                wrapMode: TextEdit.WordWrap
            }

            Component {
                id: calculatorpage

                Page {

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
                            text: Math.min(brzycki(), epley(), lander(), lombardi(), mayhew(), oconner(), wathan()) + "-" + Math.max(brzycki(), epley(), lander(), lombardi(), mayhew(), oconner(), wathan()) + " kg"
                            color: Theme.highlightColor

                            // Brzycki: 1RM = W x (36 / (37 - R))
                            function brzycki() {
                                var weights = w.text
                                var reps = r.text
                                return(Math.round(weights * (36 / (37 - reps))/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                            }

                            // Epley: 1RM = W x (1 + R / 30)
                            function epley() {
                                var weights = w.text
                                var reps = r.text
                                return(Math.round(weights * (1 + reps / 30)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                            }

                            // Lander: 1RM = 100 x W / (101.3 - 2.67123 x R)
                            function lander() {
                                var weights = w.text
                                var reps = r.text
                                return(Math.round(100 * weights / (101.3 - 2.67123 * reps)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                            }

                            // Lombardi: 1RM = W x R^0.1
                            function lombardi() {
                                var weights = w.text
                                var reps = r.text
                                return(Math.round(weights * Math.pow(reps, 0.1)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                            }

                            // Mayhew et al.: 1RM = 100 x W / (52.2 + (41.9 x e^(-0.055 x R)))
                            function mayhew() {
                                var weights = w.text
                                var reps = r.text
                                return(Math.round(100 * weights / (52.2 + (41.9 * Math.pow(Math.E, (-0.055 * reps))))/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                            }

                            // O'Conner et al.: 1RM = W x (1 + 0.025 x R)
                            function oconner() {
                                var weights = w.text
                                var reps = r.text
                                return(Math.round(weights * (1 + 0.025 * reps)/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
                            }

                            // Wathan: 1RM = 100 x W / (48.8 + (53.8 x e^(-0.075 x R)))
                            function wathan() {
                                var weights = w.text
                                var reps = r.text
                                return(Math.round(100 * weights / (48.8 + (53.8 * Math.pow(Math.E, (-0.075 * reps))))/2.5)*2.5).toFixed(1).replace(/.0+$/, "")
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
                                            Text { font.pointSize: 19; color: "white"
                                                text: "Brzycki:" }
                                }
                                Rectangle { width: 100; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: functions.brzycki() }
                                }
                                Rectangle { width: 50; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "kg" }
                                }
                            }

                            Row {
                                spacing: 20
                                Rectangle { width: 205; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "Epley:" }
                                }
                                Rectangle { width: 100; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: functions.epley() }
                                }
                                Rectangle { width: 50; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "kg" }
                                }
                            }

                            Row {
                                spacing: 20
                                Rectangle { width: 205; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "Lander:" }
                                }
                                Rectangle { width: 100; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: functions.lander() }
                                }
                                Rectangle { width: 50; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "kg" }
                                }
                            }

                            Row {
                                spacing: 20
                                Rectangle { width: 205; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "Lombardi:" }
                                }
                                Rectangle { width: 100; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: functions.lombardi() }
                                }
                                Rectangle { width: 50; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "kg" }
                                }
                            }

                            Row {
                                spacing: 20
                                Rectangle { width: 205; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "Mayhew et al.:" }
                                }
                                Rectangle { width: 100; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: functions.mayhew() }
                                }
                                Rectangle { width: 50; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "kg" }
                                }
                            }

                            Row {
                                spacing: 20
                                Rectangle { width: 205; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "O'Conner et al.:" }
                                }
                                Rectangle { width: 100; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: functions.oconner() }
                                }
                                Rectangle { width: 50; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "kg" }
                                }
                            }

                            Row {
                                spacing: 20
                                Rectangle { width: 205; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "Wathan:" }
                                }
                                Rectangle { width: 100; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: functions.wathan() }
                                }
                                Rectangle { width: 50; height: 40; color: "transparent"
                                            Text { font.pointSize: 19; color: "white"
                                                text: "kg" }
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
