#!/bin/bash

# Ruta del archivo a monitorear
FILE_PATH="/ruta/al/archivo.txt"
# Dirección de correo electrónico del destinatario
EMAIL="destinatario@correo.com"
# Asunto y cuerpo del correo electrónico
SUBJECT="Archivo detectado"
BODY="El archivo $FILE_PATH ha sido detectado en el sistema."

# Monitoreo continuo del archivo
while true; do
    # Verifica si el archivo existe
    if [ -f "$FILE_PATH" ]; then
        # Envia el correo electrónico
        echo "$BODY" | mail -s "$SUBJECT" "$EMAIL"
        echo "Correo enviado a $EMAIL por la detección de $FILE_PATH"

        # Espera una hora antes de volver a enviar el correo si el archivo sigue existiendo
        sleep 1h
    else
        # Si el archivo no existe, revisa cada 5 minutos
        sleep 5m
    fi
done
