source ../config/env.sh
mkdir -p /opt/dcos-setup
cd /opt/dcos-setup

curl -O http://${BOOT_NODE_IP}:${BOOT_NODE_PORT}/dcos_install.sh
chmod +x dcos_install.sh
./dcos_install.sh slave
