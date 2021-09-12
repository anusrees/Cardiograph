import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import fileio 1.0

Item {
    property alias fileObj: file
    property alias textArea: entry
    property alias backButton: back

    FileIO {
        id: file
    }

    Image {
        id: main_image
        width: parent.width
        height: parent.height
        opacity: 0.8
        smooth: true
        source: "background/page1.jpg"
    }

    TextArea {
        id: entry
        objectName: "input_text"
        x: 280
        y: 75
        width: parent.width - 1.6*x
        height: parent.height*0.7
        font.pointSize: 14
        backgroundVisible: false
        frameVisible: false
        font.family: "Monotype Corsiva"
        style: TextAreaStyle {
            textColor: "#17377c"
        }
    }

    Button {
        id: back
        width: 75
        height: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2

        style: ButtonStyle {
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                border.width: control.activeFocus ? 2 : 1
                radius: 14
                gradient: Gradient {
                    GradientStop { position: 0 ; color: control.pressed ? "red" : "pink" }
                    GradientStop { position: 1 ; color: control.pressed ? "pink" : "red" }
                }
            }
            label: Text {
                width: parent.width
                height: parent.height
                color: "#f5e7d3"
                font.bold: true
                style: Text.Outline
                font.pointSize: 13
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: "BACK"
            }
        }
    }

    Button {
        id: save
        width: 75
        height: 30
        anchors.right: back.left
        anchors.rightMargin: 6
        anchors.bottom: back.bottom

        style: ButtonStyle {
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                border.width: control.activeFocus ? 2 : 1
                radius: 14
                gradient: Gradient {
                    GradientStop { position: 0 ; color: control.pressed ? "red" : "pink" }
                    GradientStop { position: 1 ; color: control.pressed ? "pink" : "red" }
                }
            }
            label: Text {
                width: parent.width
                height: parent.height
                color: "#f5e7d3"
                font.bold: true
                style: Text.Outline
                font.pointSize: 13
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: "SAVE"
            }
        }

        onClicked: {
            file.text = entry.text
            file.write()
        }
    }
}
