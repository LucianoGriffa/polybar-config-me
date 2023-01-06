#!/bin/bash
if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)
# Instalando Requerimientos para la polybar
sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libuv1-dev libnl-genl-3-dev
# Creando carpeta de Reposistorios
mkdir ~/github
# Descargar Repositorios Necesarios
cd ~/github
git clone --recursive https://github.com/polybar/polybar
# Instalando Polybar
cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
# Instalando Fuentes de Polybar
sudo cp -v $ruta/polybar/fonts/* /usr/share/fonts/truetype/
# Eliminando y Copiando Archivos de Configuración
rm -r ~/.config/polybar/
cd ~/.config
mkdir polybar
cp -rv $ruta/polybar/* ~/.config/polybar/
# Asignamos Permisos al Scritp
chmod +x ~/.config/polybar/launch.sh
# Mensaje de Instalado
notify-send "POLYBAR SETUP COMPLETED"