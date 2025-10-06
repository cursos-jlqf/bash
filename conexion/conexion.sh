#!/bin/bash

# Configuracion basica
REMOTE_USER="so2025II"
REMOTE_HOST="pacifico.izt.uam.mx"
SSH_KEY="./so_llave"  # Clave privada específica del usuario
REMOTE_COMMAND="ls -l ~so2025II"         # Comando a ejecutar en el servidor remoto
OUTPUT_FILE="resultado.txt"                 # Archivo local donde se guardará el resultado

# Ejecutar comando remoto y guardar resultado usando la clave SSH especifica
ssh -i "${SSH_KEY}" -o IdentitiesOnly=yes "${REMOTE_USER}@${REMOTE_HOST}" "${REMOTE_COMMAND}" > "${OUTPUT_FILE}"

# Verificar si el comando remoto fue exitoso
if [ $? -eq 0 ]; then
    echo "Comando ejecutado exitosamente. Resultado guardado en ${OUTPUT_FILE}"
else
    echo "Error al ejecutar el comando en el servidor remoto."
fi
