import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform
import QtQuick.Controls.Material



ApplicationWindow {
    visible: true
    width: 1024
    height: 768
    title: "Convertidor a Escala de Grises"
    Material.theme: Material.Light
    Material.accent: Material.Lime

    ColumnLayout {
        anchors.fill: parent
	spacing : 20

        Text {
            id: text
            text: "Hola Chicuelo, bienvenido al convertidor a escala de grises arrastra una imagen o da click en el botón para comenzar."
            Layout.alignment: Qt.AlignHCenter
	    font.pixelSize: 20
            font.bold: true
        }

        Button {
            text: "Dame un click para comenzar"
            Layout.alignment: Qt.AlignHCenter
            onClicked: buscadorArchivos.open()
        }
	//
	Rectangle {
            id: dropZone
            width: 300
            height: 300
            radius: 12
            color: "lightgray"
            border.color: "darkgray"
            border.width: 2
	    Layout.alignment: Qt.AlignHCenter

            Text {
                anchors.centerIn: parent
                text: "Suelta la imagen aquí"
                color: "black"
            }
	    DropArea {
                anchors.fill: parent
                onDropped: {
                    if (drop.hasUrls) {
                        let url = drop.urls[0];   //imagen soltada, aparentemente puede con más d una pero de momento solo una.
                        console.log("Archivo soltado:", url)
                        img.source = url
			modulos.convertir(url)
                    }
                }
            }
	    Image {
            id: img
            width: 400
            height: 300
            fillMode: Image.PreserveAspectFit
        }
        }




    }

    FileDialog {
        id: buscadorArchivos
        title: "Busca y selecciona la imagen plis"
        nameFilters: ["Imágenes (*.png *.jpg *.jpeg)"]//aqui creo que van los .algo q voy a permitir que vea el usuario
        onAccepted: {
            console.log("Seleccionaste-> ", buscadorArchivos.file)
            modulos.convertir(buscadorArchivos.file)
        }
    }

    Connections {
        target: modulos
        function onProcesado(msj) {
            mensaje.text = msj
        }
    }
}
 
