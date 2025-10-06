#!/bin/bash


if [ "$#" -ne 1 ]; then
  echo "Uso: $0 <nombre_dir>" >&2
  exit 1
fi

DIR="$1"
FILE="info.txt"

# 1) crear directorio si no existe
mkdir -p "$DIR" || { echo "No se pudo crear $DIR" >&2; exit 2; }
echo "Directorio creado/confirmado: $DIR"

# 2) entrar al directorio
cd "$DIR" || { echo "No se puede acceder a $DIR" >&2; exit 3; }

# 3) mostrar directorio actual
echo "Ahora en: $(pwd)"

# 4) crear un archivo simple con cat heredoc
cat > "$FILE" <<EOF
Este es el archivo $FILE
Creado por: $(whoami)
Ruta actual: $(pwd)
Fecha: $(date '+%F %T')
EOF

echo "Archivo creado: $FILE"

# 5) mostrar contenido con cat
echo
echo "Contenido de $FILE:"
cat "$FILE"

exit 0
