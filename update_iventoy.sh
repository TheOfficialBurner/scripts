#!/bin/bash

# starte im root-verzeichnis
cd /

# Erstellen der Script-Verzeichnisse
mkdir -p /opt/update/archive

# setzen der benötigten Variablen
cd /opt/update
latest_iventoy_pro_archive=$(find /opt/update -name '*.tar.gz' -type f -printf '%f\n' | head -n 1)
latest_iventoy_pro_version=$(find /opt/update -name '*.tar.gz' -type f -printf '%f\n' | sed 's/-linux-pro.tar.gz$//' | head -n 1)

# aktuelle Werte
# latest_iventoy_pro_archive = iventoy-1.0.19-linux-pro.tar.gz
# latest_iventoy_pro_version = iventoy-1.0.19

# iVentoy stoppen
cd /opt/iventoy && ./iventoy.sh stop

# entpacken der neuen Version
tar xvfz /opt/update/$latest_iventoy_pro_archive -C /opt/

# config, lic und ISOs kopieren / verschieben
cp -v /opt/iventoy/data/config.dat /opt/$latest_iventoy_pro_version/data/
cp -v /opt/iventoy/data/iventoy.lic /opt/$latest_iventoy_pro_version/data/
mv -v /opt/iventoy/iso/* /opt/$latest_iventoy_pro_version/iso/

# iVentoy symlink anpassen
rm /opt/iventoy && ln -s /opt/$latest_iventoy_pro_version /opt/iventoy

# iVentoy starten
# cd /opt/iventoy && ./iventoy.sh -R start

# aktuelle Version ins archiv verschieben
mv -v /opt/update/$latest_iventoy_pro_archive /opt/update/archive/

# Neustart des Geräts
reboot
