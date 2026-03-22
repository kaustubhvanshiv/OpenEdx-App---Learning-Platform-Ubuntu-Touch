// qml/components/QuizDelegate.qml
import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Qt5Compat.GraphicalEffects

ColumnLayout {
    property var quizInfo: ({})
    property bool answered: false
    property string resultText: ""

    signal completed()

    Settings { id: appSettings }
    property color textColor: appSettings.darkMode ? "#f5f5f5" : "#222222"
    property color accentColor: "#3b82f6"
    property color correctColor: "#22c55e"
    property color wrongColor: "#ef4444"

    Rectangle {
        Layout.fillWidth: true
        height: 50 + (quizInfo.options.length * 40) + 50
        radius: 8
        color: appSettings.darkMode ? "#1e1e1e" : "#f0f0f0"
        border.color: "#ccc"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Label {
                text: quizInfo.question
                color: textColor
                font.bold: true
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }

            Repeater {
                model: quizInfo.options
                delegate: Button {
                    Layout.fillWidth: true
                    text: modelData
                    enabled: !answered
                    onClicked: {
                        if (modelData === quizInfo.correctAnswer) {
                            resultText = "✅ Correct! "
                            quizInfo.completed = true
                            answered = true
                            completed()
                        } else {
                            resultText = "❌ Incorrect. Try again!"
                        }
                    }
                    background: Rectangle {
                        radius: 4
                        color: parent.enabled ? accentColor : "#888"
                    }
                }
            }

            Label {
                text: resultText
                color: resultText.includes("Correct") ? correctColor : wrongColor
                visible: answered
                Layout.fillWidth: true
                font.bold: true
            }
        }
    }
}
