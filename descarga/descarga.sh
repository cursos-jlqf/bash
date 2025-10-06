#!/usr/bin/bash

# Valores por defecto
URL_DEFAULT="cdn.mindmajix.com/blog/images/what-is-linux-120619.png"
LOGFILE_DEFAULT="./download.log"

VERBOSE=0
DIR=""
LOGFILE=""

usage() {
  #Similiar a echo, pero para varias lineas
  cat <<EOF
  -v, --verbose   Modo verbose (imprime mensajes en pantalla además de log)
  -h, --help      Mostrar esta ayuda
Si no se proporciona logfile, se usa: $LOGFILE_DEFAULT
EOF
}

# Parseo manual simple de opciones (no getopts)
for arg in "$@"; do
  case "$arg" in
    -v|--verbose)
      VERBOSE=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      # argumentos posicionales: primero directorio, luego url, luego logfile
      if [ -z "$DIR" ]; then
        DIR="$arg"
      elif [ -z "$LOGFILE" ]; then
        LOGFILE="$arg"
      else
        # ignorar argumentos extra
        :
      fi
      ;;
  esac
done

# Validar directorio (obligatorio)
if [ -z "$DIR" ]; then
  echo "Error: Debe indicar el nombre del directorio a utilizar." >&2
  usage
  exit 1
fi

# Rellenar valores por defecto
if [ -z "$URL_DEFAULT" ]; then
  echo "Error: Debe indicar la url a utilizar." >&2
  exit 1
fi

if [ -z "$LOGFILE" ]; then
  LOGFILE="$LOGFILE_DEFAULT"
fi

if [ -z "$LOGFILE" ]; then
  echo "Error: Debe indicar el archivo log." >&2
  exit 1
fi

# Función de log simple
log() {
  local msg="$1"
  local line
  line="$(date '+%F %T') - $msg"
  if [ "$VERBOSE" -eq 1 ]; then
    echo "$line" | tee -a "$LOGFILE"
  else
    echo "$line" >> "$LOGFILE"
  fi
}

log "Inicio: directorio='$DIR' logfile='$LOGFILE'"

# Crear el directorio si no existe
if [ -e "$DIR" ]; then
  log "Ok: existe el directorio: $DIR"
else
  mkdir -p "$DIR" 2>/dev/null
  if [ $? -eq 0 ]; then
    log "Creando el directorio: $DIR"
  else
    log "ERROR: No se pudo crear el directorio: $DIR"
    exit 2
  fi
fi

# Acceder al directorio
cd "$DIR" 2>/dev/null
if [ $? -ne 0 ]; then
  log "ERROR: No se pudo acceder al directorio: $DIR"
  exit 1
fi
log "Accediendo al directorio: $DIR"

# Nombre del archivo a guardar
FILE_NAME="$(basename "$URL_DEFAULT")"

# Descargar con wget (silencioso si no verbose)
if [ "$VERBOSE" -eq 1 ]; then
  log "Descargando (verbose): $URL_DEFAULT -> $FILE_NAME"
  wget "$URL_DEFAULT" -O "$FILE_NAME"
else
  log "Descargando: $URL_DEFAULT -> $FILE_NAME"
  wget -q "$URL_DEFAULT" -O "$FILE_NAME"
fi

WGET_EXIT=$?
if [ $WGET_EXIT -ne 0 ]; then
  log "ERROR: Archivo no descargado (wget exit=$WGET_EXIT): $URL_DEFAULT"
  # volver al directorio original (por claridad)
  cd - >/dev/null 2>&1
  exit $WGET_EXIT
else
  log "Archivo descargado correctamente: $(pwd)/$FILE_NAME"
fi

# Volver al directorio original (opcional)
cd - >/dev/null 2>&1

log "Fin del script."
exit 0

