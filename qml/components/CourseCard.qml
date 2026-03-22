import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Rectangle {
    id: card
    radius: 12
    color: "white"
    implicitHeight: 380
    implicitWidth: 300

    // Custom signal to notify when "Learn More" is clicked
    signal learnMoreClicked(string courseTitle)

    // Dynamic property: data passed from parent
    property var courseData

    // Hover state for interactive effects
    states: [
        State {
            name: "hovered"
            when: mouseArea.containsMouse
            PropertyChanges { target: card; y: -8; z: 1 }
            PropertyChanges { target: learnMoreOverlay; opacity: 1; visible: true }
        }
    ]

    // Transitions for smooth animations
    transitions: Transition {
        from: "*"
        to: "hovered"
        reversible: true
        NumberAnimation { property: "y"; duration: 200 }
        NumberAnimation { property: "opacity"; duration: 200 }
    }

    // Elevation (shadow)
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 2
        radius: 10
        color: "#10000000"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Course image
        Image {
            source: courseData.image
            sourceSize.width: 400
            sourceSize.height: 250
            fillMode: Image.PreserveAspectCrop
            Layout.fillWidth: true
            Layout.preferredHeight: 250
            clip: true

            Rectangle {
                anchors.fill: parent
                radius: 12
                color: "transparent"

                // Mask for rounded corners
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: parent.width
                        height: parent.height
                        radius: 12
                    }
                }
            }
        }

        // Text content
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 24
            Layout.bottomMargin: 24
            Layout.leftMargin: 24
            Layout.rightMargin: 24
            spacing: 4

            Label {
                text: courseData.provider
                font.pixelSize: 14
                color: "#6b7280"
            }

            Label {
                text: courseData.courseCode
                font.pixelSize: 14
                color: "#6b7280"
                Layout.bottomMargin: 8
            }

            Label {
                text: courseData.title
                font.pixelSize: 20
                font.bold: true
                color: "#1e40af"
                wrapMode: Label.Wrap
            }

            Item { Layout.fillHeight: true }

            Label {
                text: "Starts: " + courseData.date
                font.pixelSize: 14
                color: "#4b5563"
            }
        }
    }

    // Hover overlay with button
    Rectangle {
        id: learnMoreOverlay
        anchors.fill: parent
        color: "#000000"
        opacity: 0
        radius: 12
        visible: false

        Button {
            text: "LEARN MORE"
            anchors.centerIn: parent
            font.pixelSize: 16
            font.bold: true
            background: Rectangle {
                color: "#2563eb"
                radius: 8
                implicitWidth: 160
                implicitHeight: 48
            }
            contentItem: Text {
                text: parent.text
                font: parent.font
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: card.learnMoreClicked(courseData.title)
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}

