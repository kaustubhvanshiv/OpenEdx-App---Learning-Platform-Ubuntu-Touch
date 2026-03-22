import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    anchors.fill: parent

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Available Quizzes"
            font.pixelSize: 24
            color: appWindow.textColor
            Layout.alignment: Qt.AlignHCenter
        }

        // Example quiz list
        Repeater {
            model: ["Python Basics", "JavaScript Essentials", "Machine Learning"]

            delegate: Frame {
                Layout.fillWidth: true
                width: parent.width * 0.8
                padding: 12
                background: Rectangle {
                    radius: 12
                    color: appWindow.backgroundColor === "black" ? "#333" : "#f0f0f0"
                }

                ColumnLayout {
                    spacing: 10

                    Text {
                        text: modelData
                        font.pixelSize: 20
                        color: appWindow.textColor
                    }

                    Button {
                        text: "Start"
                        background: Rectangle { radius: 4; color: accentColor }
                        onClicked: pageStack.push(quizPageComponent, {
                            quizTitle: modelData,
                            questions: [
                                {question: "Question 1 for " + modelData},
                                {question: "Question 2 for " + modelData},
                                {question: "Question 3 for " + modelData}
                            ]
                        })
                    }

                }
            }
        }
    }
}

