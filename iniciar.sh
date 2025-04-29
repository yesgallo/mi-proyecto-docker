#!/bin/bash

IMAGE_NAME="mi-imagen-debian"
CONTAINER_NAME="mi-contenedor-debian"

function clean_build() {
    echo "🚀 Descargando imagen base de Debian..."
    docker pull debian:latest

    echo "🔧 Construyendo imagen personalizada..."
    docker build -t $IMAGE_NAME .

    echo "🧹 Eliminando contenedor previo si existe..."
    docker rm -f $CONTAINER_NAME 2>/dev/null

    echo "🏃‍♂️ Ejecutando nuevo contenedor..."
    docker run -dit --name $CONTAINER_NAME $IMAGE_NAME

    echo "✅ Entrando al contenedor..."
    docker exec -it $CONTAINER_NAME bash
}

function start_container() {
    echo "📦 Iniciando contenedor existente..."
    docker start -ai $CONTAINER_NAME
}

function reset_all() {
    echo "🧨 Eliminando contenedor..."
    docker rm -f $CONTAINER_NAME 2>/dev/null

    echo "🧼 Eliminando imagen..."
    docker rmi $IMAGE_NAME 2>/dev/null

    echo "♻️ Reset completado."
}

function show_status() {
    echo "📦 Contenedores (todos):"
    docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
    echo ""
    echo "📸 Imágenes locales:"
    docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"
    echo ""
    echo "🚀 Contenedores en ejecución:"
    docker ps --format "table {{.Names}}\t{{.Status}}"
    echo ""
}

# Bucle interactivo
while true; do
    echo ""
    echo "🧭 Menú de acciones:"
    echo "1) 🔨 Clean build (recompilar y ejecutar)"
    echo "2) 🚀 Ejecutar contenedor existente"
    echo "3) 💣 Reset total (borrar imagen y contenedor)"
    echo "4) 🔍 Ver estado actual del proyecto"
    echo "0) ❌ Salir"
    echo ""

    read -p "Elegí una opción: " opcion

    case $opcion in
        1) clean_build ;;
        2) start_container ;;
        3) reset_all ;;
        4) show_status ;;
        0) echo "👋 Saliste del menú"; exit 0 ;;
        *) echo "❌ Opción inválida";;
    esac
done
