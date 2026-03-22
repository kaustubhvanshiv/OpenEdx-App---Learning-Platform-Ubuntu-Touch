import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
	id: quizPage
	property string courseName: ""
	property int currentQuestion: 0
	property int score: 0
	property var quizData: allQuizzes[courseName] || []

	// Quiz questions per course
	property var allQuizzes: {
		"Python Basics": [
			{ question: "What keyword is used to define a function in Python?",
			  options: ["func", "def", "function"], answer: 1 },
			{ question: "Which of these is a Python data type?",
			  options: ["int", "integer", "num"], answer: 0 },
			{ question: "What is the output of: print(len('AI'))?",
			  options: ["1", "2", "Error"], answer: 1 }
		],
		"JavaScript Essentials": [
			{ question: "Which symbol is used for comments in JavaScript?",
			  options: ["//", "#", "<!-- -->"], answer: 0 },
			{ question: "Which company developed JavaScript?",
			  options: ["Microsoft", "Netscape", "Google"], answer: 1 },
			{ question: "What does '===' mean in JavaScript?",
			  options: ["Equals", "Strict Equality", "Assignment"], answer: 1 }
		],
		"Machine Learning": [
			{ question: "Which library is commonly used for ML in Python?",
			  options: ["Scikit-learn", "React", "Qt"], answer: 0 },
			{ question: "What is supervised learning?",
			  options: ["Learning with labeled data", "Learning without data", "Unsupervised clustering"], answer: 0 },
			{ question: "Which algorithm is used for classification?",
			  options: ["Linear Regression", "KNN", "DFS"], answer: 1 }
		]
	}

	ColumnLayout {
		anchors.centerIn: parent
		spacing: 20

		// Progress indicator
		Text {
			text: quizData.length > 0 ? "Question " + (quizPage.currentQuestion + 1) + " / " + quizData.length : ""
			font.pixelSize: 16
			color: "#666666"
			Layout.alignment: Qt.AlignHCenter
		}

		// Question card
		Rectangle {
			width: parent.width * 0.9
			color: "#f0f0f0"
			radius: 12
			border.color: "#cccccc"
			border.width: 1
			Layout.alignment: Qt.AlignHCenter
			height: 100

			Text {
				anchors.centerIn: parent
				text: quizData.length > 0 ? quizData[currentQuestion].question : "No questions available"
				font.pixelSize: 22
				wrapMode: Text.WordWrap
				color: "#333333"
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				padding: 10
			}
		}

		// Options
		Repeater {
			model: quizData.length > 0 ? quizData[currentQuestion].options : []
			delegate: Button {
				text: modelData
				width: parent.width * 0.8
				height: 50
				font.pixelSize: 18
				background: Rectangle {
					color: pressed ? "#4CAF50" : "#2196F3"
					radius: 8
				}
				onClicked: {
					if (index === quizData[currentQuestion].answer) {
						quizPage.score++
					}

					if (quizPage.currentQuestion < quizData.length - 1) {
						quizPage.currentQuestion++
					} else {
						stackView.push("qrc:/qml/components/QuizResultPage.qml",
									   { score: quizPage.score,
										 total: quizData.length })
					}
				}
			}
		}
	}
}
