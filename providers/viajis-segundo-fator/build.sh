#!/bin/sh
# Compila o módulo contra as bibliotecas do próprio Keycloak (a mesma versão da imagem) e gera viajis-segundo-fator.jar.
# Uso: build.sh <pasta das bibliotecas do Keycloak (/opt/keycloak/lib/lib/main)> <pasta de saída>
set -eu
LIBS="$1"; OUT="$2"; HERE="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$OUT/classes"
javac --release 21 -cp "$LIBS/*" -d "$OUT/classes" $(find "$HERE/src" -name '*.java')
cp -R "$HERE/src/META-INF" "$OUT/classes/META-INF"
jar cf "$OUT/viajis-segundo-fator.jar" -C "$OUT/classes" .
