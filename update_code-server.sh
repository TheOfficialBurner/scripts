#!/bin/bash

# update code-server
systemctl stop code-server.service
curl -Ls $(curl -s https://api.github.com/repos/coder/code-server/releases/latest | grep "browser_download_url.*.amd64.deb" | cut -d '"' -f 4) -O -J
mv code-server_*.deb code-server_update.deb
apt install code-server_update.deb -y
systemctl start code-server.service
rm code-server_update.deb

# Download and run update-script
# wget https://raw.githubusercontent.com/TheOfficialBurner/config-files/main/update_code-server.sh && chmod +x update_code-server.sh && ./update_code-server.sh
