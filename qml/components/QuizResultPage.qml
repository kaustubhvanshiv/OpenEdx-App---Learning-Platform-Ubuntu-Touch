import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property int score: 0
    property int total: 0

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 15

        Text {
            text: "🏆 You did great!"
            font.pixelSize: 26
            color: appWindow.textColor
        }

        Text {
            text: "Your Score: " + score + " / " + total
            font.pixelSize: 20
            color: appWindow.textColor
        }

        Text {
            text: "Keep this consistency! 🚀"
            font.pixelSize: 18
            color: appWindow.textColor
        }

        Button {
            text: "Back to Quizzes"
            onClicked: stackView.pop()
        }
    }
}

