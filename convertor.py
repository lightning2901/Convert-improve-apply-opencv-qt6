import cv2
import numpy as np


import sys
#para poder salir con sys.exit()
import os
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine 
from PySide6.QtCore import QObject, Slot, Signal  #QObject(MAYUSCULA LA Q y O)-> clase base para crear objetos que QML pueda usar
                                          #Slot-> webada para indicar "esta función" o modulo, este def(x) pues puede ser llamada desde el .qml



class Modulos(QObject):
    procesado = Signal(str)
    @Slot(str)# con slot el qml verá este modulo o gadjet o como una puesi, una función disponible para llamar
      # señal que envía un string al qml para más abajo decirle que ya se procesó la imagen
    def convertir(self, ruta):
        if ruta.startswith("file://"):
            ruta = ruta[7:]  # quitar el "file:// que retorna el FileDialog del qml"
        print("Imagen recibida, procesando")
        ####### Debajo d aqui el cv
        img = img = cv2.imread(ruta, cv2.IMREAD_COLOR)
        assert img is not None
        escala_grises = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        cv2.imshow('Imagen Original', img)
        cv2.imshow('Imagen en Escala de Grises', escala_grises)
        cv2.waitKey(0) # Waits indefinitely until a key is pressed
        cv2.destroyAllWindows() # Destroys all OpenCV windows
    
    

def main():
    # para evitar el bucle extraño o que se quede abierto el qt 6 se abre una nueva sesión.
    app = QGuiApplication(sys.argv)
    
    engine = QQmlApplicationEngine()
    #######################
    #Aqui seria bueno colocar mis modulos
    modulos = Modulos()
    engine.rootContext().setContextProperty("modulos", modulos)
    # Cargar QML desde el mismo directorio
    qml_file = os.path.join(os.path.dirname(__file__), "main.qml")
    engine.load(qml_file)
    
    if not engine.rootObjects():
        return -1
    
    return app.exec()



if __name__ == "__main__":
    sys.exit(main())
