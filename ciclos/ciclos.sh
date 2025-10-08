#!/bin/bash
# Demostración de estructuras de repetición en Bash
set -euo pipefail

#-e
#Sale del script si un comando devuelve distinto de 0 (error). (errexit)
#-u
#Trata como error usar una variable no definida. (nounset)
#-o pipefail
#Hace que una pipeline falle si cualquier comando dentro falla (no sólo el último)



# --- Configuración inicial ---
MAX="${1:-6}"            # Máximo por defecto (puede pasarse como argumento)



# 1) while: contador ascendente 
echo "while (contador ascendente)"
n=1
while [ "$n" -le "$MAX" ]; do
    printf "while: %d\n" "$n"
    ((n++))
done

# 2) until: contador descendente (ejecuta hasta que la condición sea verdadera)
echo "until (contador descendente)"
m=$MAX
until [ "$m" -le 0 ]; do
    printf "until: %d\n" "$m"
    ((m--))
done

# 3) for clásico (estilo C): índices y uso de continue/break
echo "for (( ... )) — con continue y break"
for ((i=1; i<=MAX; i++)); do
    if (( i % 2 == 0 )); then
        echo "for: $i (par) — continue"
        continue     # salta la impresión siguiente para números pares
    fi
    if (( i == 5 )); then
        echo "for: $i — alcanzado 5, break"
        break        # corta el ciclo cuando i == 5
    fi
    echo "for: $i (impar)"
done


# 4) ciclo anidado: tabla de multiplicar pequeña
echo "Ciclo anidado: tabla de multiplicar 1..5"
for ((r=1; r<=5; r++)); do
    for ((c=1; c<=5; c++)); do
        printf "%2d " $((r*c))
    done
    printf "\n"
done


