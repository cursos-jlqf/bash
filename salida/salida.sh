#!/usr/bin/bash
# salida.sh — script BÁSICO para mostrar stdout vs stderr
#
# ./salida.sh                # muestra stdout y stderr en la terminal
# ./salida.sh > out.txt 2> err.txt    # stdout -> out.txt, stderr -> err.txt
# ./salida.sh &> all.txt               # (bash) stdout+stderr -> all.txt
#
# Contenido mínimo:

echo "Este es un mensaje por stdout"
echo "Este es un mensaje por stderr" >&2


