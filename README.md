# ¿Qué es un script en Bash?

Un script en Bash es un archivo de texto que contiene comandos que pueden ejecutarse en sistemas Unix/Linux. Bash (Bourne Again SHell) es uno de los intérpretes de comandos más comunes.

#  Cómo crear el script

Puedes crear el script como un archivo .sh con el contenido:

```bash
#!/bin/bash 
echo "Hola mundo"
```
Lo pudes llmar hola.sh
#  Cómo darle permisos de ejecución
Para que el sistema permita ejecutar el script, necesitas darle permisos de ejecución. Abre la terminal y ejecuta:
```bash
chmod +x hola.sh
```
# Cómo ejecutar el script
Una vez que el archivo tiene permisos de ejecución, puedes correrlo desde la terminal con:
```bash
./hola
```
