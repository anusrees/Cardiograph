import QtQuick 2.4
import QtQuick.Controls.Styles 1.1
import QtQuick.Controls 1.3
import "qrc:/"

Item {
    property alias welcome: welcome
    property alias page: page

    SystemPalette {
        id: systemPalette
    }

    PageEntry {
        id: page
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: parent.height
        visible: false
        backButton.onClicked: {
            layout.visible = true
            page.visible = false
        }
    }

    Rectangle {
        id: layout
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: parent.height

        Image {
            id: main_image
            objectName: "entry"
            width: parent.width
            height: parent.height
            opacity: 0.5
            smooth: true
            source: "background/scenery.jpg"
        }

        Flow {
            id: flow
            anchors.fill: parent
            anchors.margins: 20
            layoutDirection: Qt.RightToLeft

            Calendar {
                width: parent.width * 0.5 - parent.spacing
                height: parent.height * 0.45 - parent.spacing
                frameVisible: true
                focus: true

                style: CalendarStyle {
                    dayDelegate: Item {
                        readonly property color sameMonthDateTextColor: "#444"
                        readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : systemPalette.highlight
                        readonly property color selectedDateTextColor: "white"
                        readonly property color differentMonthDateTextColor: "#bbb"
                        readonly property color invalidDatecolor: "#dddddd"

                        Rectangle {
                            anchors.fill: parent
                            border.color: "transparent"
                            color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "transparent"
                            anchors.margins: styleData.selected ? -1 : 0
                        }

                        Label {
                            id: year
                            text: 2000+styleData.date.getYear()-100
                            visible: false
                        }

                        Label {
                            id: month
                            text: styleData.date.getMonth()
                            visible: false
                        }

                        Label {
                            id: dayDelegateText
                            text: styleData.date.getDate()
                            anchors.centerIn: parent
                            color: {
                                var color = invalidDatecolor;
                                if (styleData.valid) {
                                    color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                                    if (styleData.selected) {
                                        color = selectedDateTextColor;
                                    }
                                }
                                color;
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                page.fileObj.source = dayDelegateText.text+"_"+month.text+"_"+year.text+".txt"
                                layout.visible = false
                                page.visible = true
                                page.fileObj.read()
                                page.textArea.text = page.fileObj.text
                            }
                        }
                    }
                }
            }
        }

        Text {
            id: welcome
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.2
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.1
            font.italic: true
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 40
            color: "#f4f9f5"
            font.family: "MV Boli"
            font.bold: true
            style: Text.Outline
        }
    }
}
