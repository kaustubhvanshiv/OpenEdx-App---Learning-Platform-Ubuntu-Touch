// qml/components/SectionDelegate.qml
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import Qt5Compat.GraphicalEffects


ColumnLayout {
    property var section: ({})
    property bool expanded: false
    
    signal itemCompleted()

    Settings { id: appSettings }
    property color textColor: appSettings.darkMode ? "#f5f5f5" : "#222222"
    property color accentColor: "#3b82f6"

    Rectangle {
        Layout.fillWidth: true
        height: 50
        radius: 8
        color: appSettings.darkMode ? "#1e1e1e" : "#f0f0f0"
        border.color: "#ccc"
        
        // ... (rest of the code for the delegate) ...
    }
}
