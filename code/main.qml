import QtQuick 2.4
import QtQuick.Controls.Styles 1.1
import QtQuick.Controls 1.3
import "qrc:/"
import fileio 1.0
import profile 1.0

ApplicationWindow {
    visible: true
    width: maximumWidth
    height: maximumHeight
    visibility: "Maximized"
    title: qsTr("CardioGraph")

    Loader {
        id: load
    }

    Profile {
        id: profile
    }

    CalendarPage {
        id: calendar
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: parent.height
        visible: false
    }

    Rectangle
    {
        id: layout
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: parent.height

        Image {
            id: main_image
            width: parent.width
            height: parent.height
            opacity: 0.7
            smooth: true
            source: "background/coverpic.jpg"
        }

        Text {
            id: main_text
            width: 200
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2 - width/2
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.2
            color: "#f4f9f5"
            text: "CARDIOGRAPH"
            font.family: "MV Boli"
            font.bold: true
            style: Text.Outline
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 40
        }

        TextField {
            id: input
            width: 200
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2 - width/2 - 35
            anchors.top: parent.top
            anchors.topMargin: parent.height/2 - height/2
            echoMode: TextInput.Password
            font.pointSize: 10
        }

        Text {
            id: status
            anchors.top: input.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 0
            width: parent.width
            color: "#db0606"
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: invalid_pw
            color: "#f52310"
            anchors.left: input.left
            anchors.top: input.bottom
            anchors.topMargin: 6
            font.pointSize: 15
            style: Text.Outline
        }

        Button {
            id: deleteButton
            width: 280
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2 - 150
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            focus: true

            style: ButtonStyle {
                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    Image {
                        anchors.fill: parent
                        source: "background/surface.jpg"
                        opacity: control.pressed ? 0.85:0.9;
                    }
                }
                label: Text {
                    width: parent.width
                    height: parent.height
                    color: "#1c1c11"
                    font.bold: true
                    font.pointSize: 13
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: "CREATE NEW PROFILE"
                }
            }

            onClicked: {
                load.source = "ProfilePage.qml"
                close()
            }

            Keys.onEnterPressed: {
                load.source = "ProfilePage.qml"
                close()
            }
        }

        Button {
            id: inputButton
            width: 30
            height: 30
            anchors.left: input.right
            anchors.leftMargin: 10
            anchors.top: input.top
            focus: true

            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 15
                    gradient: Gradient {
                        GradientStop {
                            position: 0 ;
                            color: control.pressed ? "steelblue":"lightsteelblue"
                        }
                    }
                }
                label: Text {
                    width: parent.width
                    height: parent.height
                    color: "#1c1c11"
                    font.bold: true
                    font.pointSize: 13
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: "S"
                }
            }

            function matchPassword() {
                if(!profile.matchPassCode(input.text)) {
                    status.text = "Incorrect Password"
                }
                else {
                    calendar.welcome.text = "Welcome "+profile.name
                    calendar.page.fileObj.key = input.text
                    layout.visible = false
                    calendar.visible = true
                }
            }

            onClicked: {
                profile.readProfile()
                matchPassword()
            }

            Keys.onEnterPressed: {
                profile.readProfile()
                matchPassword()
            }
        }
    }
}
