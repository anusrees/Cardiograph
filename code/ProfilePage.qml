import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import profile 1.0

ApplicationWindow {
    visible: true
    width: maximumWidth
    height: maximumHeight
    visibility: "Maximized"
    title: qsTr("CardioGraph")

    CalendarPage {
        id: calendar
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: parent.height
        visible: false
    }

    Rectangle {
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

        Label {
            id: name
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height*0.2
            anchors.leftMargin: parent.width*0.15
            text: "What Should I Call You?"
            color: "#f4f9f5"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 25
            font.family: "MV Boli"
            font.bold: true
            style: Text.Outline
        }

        TextField {
            id: name_field
            anchors.top: name.top
            anchors.left: name.right
            anchors.leftMargin: 70
            anchors.topMargin: 12
            width: 300
            height: 25
            focus: true
            onTextChanged: {
                if(text!="")
                    status.text = ""
            }
        }

        Label {
            id: pass
            anchors.top: name.bottom
            anchors.right: name.right
            anchors.topMargin: 10
            text: "Encrypt Your Diary"
            color: "#f4f9f5"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 25
            font.family: "MV Boli"
            font.bold: true
            style: Text.Outline
        }

        TextField {
            id: pass_field
            anchors.top: pass.top
            anchors.left: pass.right
            anchors.leftMargin: 70
            anchors.topMargin: 12
            width: 300
            height: 25
            echoMode: TextInput.Password
            onTextChanged: {
                if(text.length>=5)
                    status.text = ""
            }
        }

        Label {
            id: c_pass
            anchors.top: pass.bottom
            anchors.right: pass.right
            anchors.topMargin: 10
            text: "Retype Encryption Key"
            color: "#f4f9f5"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 25
            font.family: "MV Boli"
            font.bold: true
            style: Text.Outline
        }

        TextField {
            id: c_pass_field
            anchors.top: c_pass.top
            anchors.left: c_pass.right
            anchors.leftMargin: 70
            anchors.topMargin: 12
            width: 300
            height: 25
            echoMode: TextInput.Password
            onTextChanged: {
                if(text==pass_field.text)
                    status.text = ""
            }
        }

        Button {
            id: create
            width: 100
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2 - width/2
            anchors.top: c_pass_field.bottom
            anchors.topMargin: 60
            focus: true

            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    border.width: control.activeFocus ? 2 : 1
                    radius: 20
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "steelblue" : "lightsteelblue" }
                        GradientStop { position: 1 ; color: control.pressed ? "lightsteelblue" : "steelblue" }
                    }
                }
                label: Text {
                    width: parent.width
                    height: parent.height
                    text: "CREATE"
                    color: "#f5e7d3"
                    font.bold: true
                    style: Text.Outline
                    font.pointSize: 15
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            onClicked: checkStatus()

            Keys.onEnterPressed: {
                checkStatus()
            }
        }

        Text {
            id: status
            anchors.top: create.bottom
            anchors.left: parent.left
            anchors.topMargin: 30
            anchors.leftMargin: 0
            width: parent.width
            font.pointSize: 12
            color: "red"
            text: ""
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }


        Profile {
            id: profile
        }
    }

    function checkStatus() {
        if(name_field.text=="")
            status.text = "Please enter your name."
        else if(pass_field.text.length<5)
            status.text = "Password should be minimum 5 characters long."
        else if(pass_field.text!=c_pass_field.text)
            status.text = "Passwords don't match."
        else {
            profile.name = name_field.text
            profile.password = pass_field.text
            profile.generateProfile()
            calendar.welcome.text = "Welcome "+name_field.text
            calendar.page.fileObj.key = pass_field.text
            layout.visible = false
            calendar.visible = true
        }
    }
}
