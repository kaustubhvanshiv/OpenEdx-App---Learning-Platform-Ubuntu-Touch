import QtQuick 2.7
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "js/api.js" as API
import "js/auth.js" as Auth
import "js/storage.js" as Storage
import "components"

ApplicationWindow {
    id: root
    objectName: "mainView"
    title: "openedx.com.kaustubh"
    visible: true

    width: 420
    height: 720

    // Dark mode toggle saved in settings
    Settings {
        id: appSettings
        property bool darkMode: false
    }

    // Apply dark/light theme
    property color bgColor: appSettings.darkMode ? "#121212" : "#ffffff"
    property color cardColor: appSettings.darkMode ? "#1e1e1e" : "#f0f0f0"
    property color textColor: appSettings.darkMode ? "#f5f5f5" : "#222222"
    property color accentColor: "#3b82f6"
    property color secondaryTextColor: appSettings.darkMode ? "#b0b0b0" : "#888888"

    Rectangle {
        anchors.fill: parent
        color: bgColor
    }

    property bool isOnline: true
    property bool isAuthenticated: false
    property var currentUser: null

    StackView {
        id: pageStack
        anchors.fill: parent
        anchors.bottomMargin: 60 // Make space for the bottom navigation bar
    }

    // New: Bottom Navigation Bar
    RowLayout {
        id: navBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60
        spacing: 0
        z: 1
        visible: isAuthenticated // Only show navigation when logged in

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: appSettings.darkMode ? "#222" : "#f5f5f5"
            border.color: appSettings.darkMode ? "#333" : "#ddd"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                ToolButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    contentItem: ColumnLayout {
                        spacing: 2
                        Label {
                            text: "📚"
                            font.pixelSize: 24
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "Courses"
                            font.pixelSize: 12
                            color: textColor
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    onClicked: root.showMainPage()
                }

                ToolButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    contentItem: ColumnLayout {
                        spacing: 2
                        Label {
                            text: "📝"
                            font.pixelSize: 24
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "Quizzes"
                            font.pixelSize: 12
                            color: textColor
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    onClicked: pageStack.push(quizzesComponent)
                }

                ToolButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    contentItem: ColumnLayout {
                        spacing: 2
                        Label {
                            text: "👤"
                            font.pixelSize: 24
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "Profile"
                            font.pixelSize: 12
                            color: textColor
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    onClicked: pageStack.push(profileComponent)
                }

                ToolButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    contentItem: ColumnLayout {
                        spacing: 2
                        Label {
                            text: "⚙️"
                            font.pixelSize: 24
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "Settings"
                            font.pixelSize: 12
                            color: textColor
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    onClicked: pageStack.push(settingsComponent)
                }
            }
        }
    }

    Component.onCompleted: {
        isAuthenticated = true
        currentUser = { "username": "Guest" }
        showMainPage()
        checkNetworkStatus()
    }

    function checkNetworkStatus() {
        var xhr = new XMLHttpRequest()
        xhr.timeout = 5000
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                isOnline = (xhr.status === 200)
                if (isOnline && isAuthenticated) syncOfflineData()
            }
        }
        xhr.open("GET", "https://httpbin.org/status/200")
        try { xhr.send() } catch(e) { isOnline = false }
    }

    function syncOfflineData() {
        var pending = Storage.getPendingSyncItems()
        for (var i=0; i<pending.length; ++i) {
            var item = pending[i]
            console.log("Syncing:", item)
            Storage.removeSyncItem(item.id)
        }
    }


    function showLoginPage() {
        pageStack.clear()
        pageStack.push(loginPageComponent)
    }

    function showMainPage() {
        pageStack.clear()
        pageStack.push(courseListComponent)
    }

    // ---------------- Login Page ----------------
    Component {
        id: loginPageComponent
        Page {
            title: "Login"

            ColumnLayout {
                anchors.centerIn: parent
                width: Math.min(parent.width * 0.85, 340)
                spacing: 18

                Image {
                    source: "assets/openedx_logo.png"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 140
                    Layout.preferredHeight: 140
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    text: "Open edX Mobile"
                    font.pixelSize: 22
                    font.bold: true
                    color: textColor
                    Layout.alignment: Qt.AlignHCenter
                }

                TextField {
                    id: emailField
                    placeholderText: "Email"
                    Layout.fillWidth: true
                }

                TextField {
                    id: passwordField
                    placeholderText: "Password"
                    echoMode: TextInput.Password
                    Layout.fillWidth: true
                }

                Button {
                    id: loginButton
                    text: "Login"
                    Layout.fillWidth: true
                    background: Rectangle {
                        radius: 6
                        color: accentColor
                    }
                    onClicked: {
                        loginButton.enabled = false
                        loginButton.text = "Logging in..."
                        Qt.callLater(function() {
                            loginButton.text = "Login"
                            loginButton.enabled = true
                        })
                    }
                }

                Label {
                    id: loginError
                    text: ""
                    color: "red"
                    wrapMode: Text.WordWrap
                    visible: false
                    Layout.fillWidth: true
                }

                Item { Layout.fillHeight: true }

                Button {
                    text: "Browse Offline"
                    Layout.fillWidth: true
                    visible: !root.isOnline
                    background: Rectangle { radius: 6; color: "#666" }
                    onClicked: root.showMainPage()
                }
            }
        }
    }

    // ---------------- Course List Page ----------------
    Component {
        id: courseListComponent
        Page {
            header: ToolBar {
                RowLayout {
                    anchors.fill: parent
                    ToolButton {
                        text: "⬅"
                        visible: pageStack.depth > 1
                        onClicked: pageStack.pop()
                    }
                    Label {
                        text: "Explore Courses"
                        font.bold: true
                        color: textColor
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Item { Layout.fillWidth: true }
                }
            }

            ListModel { id: courseModel }

            ColumnLayout {
                anchors.fill: parent
                spacing: 8

                TextField {
                    id: searchField
                    placeholderText: "Search courses..."
                    Layout.fillWidth: true
                    onTextChanged: filterCourses()
                }

                GridView {
                    id: courseGridView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    cellWidth: (parent.width - 24) / 2
                    cellHeight: 180
                    model: courseModel

                    delegate: Rectangle {
                        width: courseGridView.cellWidth
                        height: courseGridView.cellHeight
                        radius: 12
                        color: cardColor
                        border.color: accentColor
                        border.width: 1
                        // Use a subtle shadow for a modern look
                        layer.enabled: true
                        layer.effect: DropShadow {
                            color: "#000000"
                            radius: 4
                            opacity: 0.2
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: pageStack.push(coursePageComponent, {"course": model})
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 0

                            // Placeholder for course image
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 100
                                color: model.cardColor
                                radius: 10
                            }

                            Item { Layout.fillHeight: true }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Label {
                                    text: model.title
                                    color: textColor
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                }
                                ProgressBar {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 8
                                    Layout.topMargin: 5
                                    value: model.progress
                                    background: Rectangle {
                                        radius: 4
                                        color: "#e0e0e0"
                                    }
                                }
                            }
                        }
                    }
                }
            }

            function filterCourses() {
                courseModel.clear()
                var all = allCourses()
                for (var i=0; i<all.length; ++i) {
                    if (all[i].name.toLowerCase().indexOf(searchField.text.toLowerCase()) !== -1) {
                        courseModel.append({
                            title: all[i].name,
                            id: all[i].course_id,
                            progress: all[i].progress,
                            cardColor: all[i].cardColor
                        })
                    }
                }
            }

            function allCourses() {
                return [
                    { name: "Introduction to Python", course_id: "course-v1:demo+python+2025", progress: 0.65, cardColor: "#a3e635" },
                    { name: "Web Development Basics", course_id: "course-v1:demo+webdev+2025", progress: 0.82, cardColor: "#fde047" },
                    { name: "Data Science 101", course_id: "course-v1:demo+datasci+2025", progress: 0.40, cardColor: "#38bdf8" },
                    { name: "Machine Learning Foundations", course_id: "course-v1:demo+ml+2025", progress: 0.95, cardColor: "#c084fc" },
                    { name: "Deep Learning with TensorFlow", course_id: "course-v1:demo+dl+2025", progress: 0.15, cardColor: "#fb7185" },
                    { name: "Cloud Computing Essentials", course_id: "course-v1:demo+cloud+2025", progress: 0.70, cardColor: "#10b981" },
                    { name: "Cybersecurity Basics", course_id: "course-v1:demo+cyber+2025", progress: 0.33, cardColor: "#67e8f9" },
                    { name: "C++ for Beginners", course_id: "course-v1:demo+cpp+2025", progress: 0.50, cardColor: "#c4b5fd" },
                    { name: "Mobile App Development", course_id: "course-v1:demo+mobile+2025", progress: 0.75, cardColor: "#fca5a5" },
                    { name: "Java Programming Mastery", course_id: "course-v1:demo+java+2025", progress: 0.25, cardColor: "#d946ef" }
                ]
            }

            Component.onCompleted: filterCourses()
        }
    }

    // ---------------- Quizzes Page ----------------
    Component {
        id: quizzesComponent
        Page {
            header: ToolBar {
                RowLayout {
                    anchors.fill: parent
                    ToolButton { text: "⬅"; onClicked: pageStack.pop() }
                    Label {
                        text: "Quizzes"
                        font.bold: true
                        color: textColor
                        Layout.alignment: Qt.AlignVCenter
                    }
                }
            }

            ListModel { id: quizModel }

            Component.onCompleted: {
                quizModel.append({ "title": "Python Basics Quiz", "course": "Introduction to Python" })
                quizModel.append({ "title": "HTML & CSS Quiz", "course": "Web Development Basics" })
                quizModel.append({ "title": "Data Types Quiz", "course": "Data Science 101" })
            }

            ListView {
                anchors.fill: parent
                anchors.margins: 8
                clip: true
                spacing: 6
                model: quizModel
                delegate: Rectangle {
                    width: parent.width
                    height: 60
                    radius: 8
                    color: cardColor
                    border.color: "#ccc"
                    border.width: 1
                    RowLayout {
                        anchors.fill: parent
                        Label {
                            text: model.title
                            color: textColor
                            font.bold: true
                            Layout.fillWidth: true
                        }
                        Button {
                            text: "Start"
                            background: Rectangle { radius: 4; color: accentColor }
                            onClicked: {
                                // Create 3 sample questions for now
                                var sampleQuestions = [
                                    {
                                        question: "Question 1 for " + model.title,
                                        options: ["A", "B", "C"],
                                        answer: 0
                                    },
                                    {
                                        question: "Question 2 for " + model.title,
                                        options: ["X", "Y", "Z"],
                                        answer: 1
                                    },
                                    {
                                        question: "Question 3 for " + model.title,
                                        options: ["Yes", "No", "Maybe"],
                                        answer: 2
                                    }
                                ]
                                pageStack.push(quizPageComponent, {
                                    quizTitle: model.title,
                                    questions: sampleQuestions
                                })
                            }
                        }
                    }
                }
            }
        }
    }

    // ---------------- New: Profile Page ----------------
    Component {
        id: profileComponent
        Page {
            header: ToolBar {
                RowLayout {
                    anchors.fill: parent
                    ToolButton { text: "⬅"; onClicked: pageStack.pop() }
                    Label {
                        text: "Profile"
                        font.bold: true
                        color: textColor
                        Layout.alignment: Qt.AlignVCenter
                    }
                }
            }

            ColumnLayout {
                anchors.centerIn: parent
                width: parent.width * 0.8
                spacing: 20
                Layout.alignment: Qt.AlignHCenter

                Image {
                    source: "https://placehold.co/100x100/3b82f6/ffffff?text=U"
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100
                    Layout.alignment: Qt.AlignHCenter
                    clip: true
                }

                Label {
                    text: root.currentUser.username
                    font.pixelSize: 24
                    font.bold: true
                    color: textColor
                    Layout.alignment: Qt.AlignHCenter
                }

                Label {
                    text: "Welcome to your profile. Here you can see your achievements and course statistics."
                    color: secondaryTextColor
                    wrapMode: Text.WordWrap
                    font.pixelSize: 14
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }

    // ---------------- Settings Page ----------------
    Component {
        id: settingsComponent
        Page {
            header: ToolBar {
                RowLayout {
                    anchors.fill: parent
                    ToolButton { text: "⬅"; onClicked: pageStack.pop() }
                    Label {
                        text: "Settings"
                        font.bold: true
                        color: textColor
                        Layout.alignment: Qt.AlignVCenter
                    }
                }
            }

            ColumnLayout {
                anchors.margins: 20
                anchors.fill: parent
                spacing: 20

                RowLayout {
                    Label { text: "Dark Mode"; color: textColor; Layout.fillWidth: true }
                    Switch {
                        checked: appSettings.darkMode
                        onCheckedChanged: appSettings.darkMode = checked
                    }
                }

                RowLayout {
                    Label { text: "Notifications"; color: textColor; Layout.fillWidth: true }
                    Switch { checked: true }
                }

                Button {
                    text: "Clear Cache"
                    Layout.fillWidth: true
                    background: Rectangle { radius: 6; color: "#e11d48" }
                    onClicked: console.log("Cache cleared")
                }
            }
        }
    }

    // ---------------- Course Page ----------------
    Component {
        id: coursePageComponent
        Page {
            property var course

            header: ToolBar {
                RowLayout {
                    anchors.fill: parent
                    ToolButton { text: "⬅"; onClicked: pageStack.pop() }
                    Label { text: course.title; color: textColor }
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                // Removed the video player components
                Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Video playback is not available."
                    font.pixelSize: 18
                    font.bold: true
                    color: textColor
                    wrapMode: Text.WordWrap
                }

                // Video List
                Label {
                    text: "Videos"
                    font.pixelSize: 18
                    font.bold: true
                    color: textColor
                    Layout.topMargin: 20
                }

                ListModel {
                    id: videoModel
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: 8
                    model: videoModel

                    delegate: Rectangle {
                        width: parent.width
                        height: 50
                        radius: 8
                        color: cardColor
                        border.color: accentColor
                        border.width: 1

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("Video selected:", model.title)
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            spacing: 10
                            Label {
                                text: model.title
                                color: textColor
                                Layout.fillWidth: true
                                Layout.leftMargin: 10
                            }
                        }
                    }
                }
            }
            Component.onCompleted: {
                videoModel.append({ "title": "Welcome to the Course" })
                videoModel.append({ "title": "Module 1: Getting Started" })
                videoModel.append({ "title": "Module 2: Advanced Topics" })
            }
        }
    }


    // ---------------- Quiz Page ----------------
    Component {
        id: quizPageComponent
        Page {
            property string quizTitle
            property var questions

            header: ToolBar {
                RowLayout {
                    anchors.fill: parent
                    ToolButton { text: "⬅"; onClicked: pageStack.pop() }
                    Label { text: quizTitle; font.bold: true; color: textColor }
                }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 12

                Repeater {
                    model: questions
                    delegate: Rectangle {
                        width: parent.width
                        height: 60
                        radius: 8
                        color: cardColor
                        RowLayout {
                            anchors.fill: parent
                            Label {
                                text: modelData.question   // <-- use modelData, not model.question
                                color: textColor
                                font.pixelSize: 18
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }
        }
    }
}
