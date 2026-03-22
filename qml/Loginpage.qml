import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects


Page {
    // These properties are passed from the main application view
    property color bgColor
    property color accentColor
    property color textColor
    property bool isOnline
    property var onLoginSuccess // This is a function passed from Main.qml

    title: "Login"

    Rectangle {
        anchors.fill: parent
        color: bgColor
    }

    // Main content area
    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.85, 400)
        spacing: 20

        // Login Card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 320
            radius: 12
            color: Qt.darker(bgColor, 1.2)
            
            // Use DropShadow for the elevation effect
            DropShadow {
                anchors.fill: parent
                radius: 10
                samples: 16
                color: "#30000000"
                horizontalOffset: 0
                verticalOffset: 2
                source: parent
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 25
                spacing: 15

                Label {
                    text: "Sign In"
                    font.pixelSize: 26
                    font.bold: true
                    color: textColor
                    Layout.alignment: Qt.AlignHCenter
                }

                TextField {
                    id: emailField
                    placeholderText: "Username or Email"
                    Layout.fillWidth: true
                    leftPadding: 15
                    implicitHeight: 45
                    background: Rectangle {
                        color: Qt.darker(parent.bgColor, 1.1)
                        radius: 8
                        border.color: parent.hovered ? accentColor : "#666"
                    }
                    color: textColor
                }

                TextField {
                    id: passwordField
                    placeholderText: "Password"
                    echoMode: TextInput.Password
                    Layout.fillWidth: true
                    leftPadding: 15
                    implicitHeight: 45
                    background: Rectangle {
                        color: Qt.darker(parent.bgColor, 1.1)
                        radius: 8
                        border.color: parent.hovered ? accentColor : "#666"
                    }
                    color: textColor
                }

                Label {
                    id: loginError
                    text: ""
                    color: "red"
                    wrapMode: Text.WordWrap
                    visible: false
                    Layout.fillWidth: true
                }

                Button {
                    id: loginButton
                    text: "Login"
                    Layout.fillWidth: true
                    implicitHeight: 45
                    background: Rectangle {
                        radius: 8
                        color: loginButton.pressed ? Qt.darker(accentColor) : accentColor
                    }
                    contentItem: Label {
                        text: loginButton.text
                        font.bold: true
                        color: "#fff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        loginButton.enabled = false
                        loginButton.text = "Logging in..."
                        // Simulate network request
                        Qt.callLater(function() {
                            if (emailField.text === "testuser" && passwordField.text === "password") {
                                onLoginSuccess() // Call the function from Main.qml
                            } else {
                                loginError.text = "Invalid username or password."
                                loginError.visible = true
                                loginButton.text = "Login"
                                loginButton.enabled = true
                            }
                        })
                    }
                }
            }
        }
        
        Button {
            text: "Browse Offline"
            Layout.fillWidth: true
            visible: !isOnline
            implicitHeight: 45
            background: Rectangle {
                radius: 8
                color: "#666"
            }
            contentItem: Label {
                text: parent.text
                font.bold: true
                color: "#fff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: onLoginSuccess()
        }
    }
}

