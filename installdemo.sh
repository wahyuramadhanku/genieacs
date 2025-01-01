#!/bin/bash
#sudo curl -s https://srv.ddns.my.id/genieacs/genieacs/install.sh -o /tmp/install.sh && sudo bash /tmp/install.sh
url_install='https://srv.ddns.my.id/genieacs/genieacs/'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
local_ip=$(hostname -I | awk '{print $1}')
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}==================== Script Install GenieACS All In One. ===================${NC}"
echo -e "${GREEN}======================== NodeJS, MongoDB, GenieACS, ========================${NC}"
echo -e "${GREEN}========================= . Info 081-947-215-703 ===========================${NC}"
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}${NC}"
echo -e "${GREEN}Autoinstall GenieACS.${NC}"
echo -e "${GREEN}- Ini adalah script untuk auto install genieACS beserta nodeJS dan MongoDB${NC}"
echo -e "${GREEN}- Script ini bisa digunakan baik yang sudah terisntall nodeJS dan mongoDB maupun yang belum${NC}"
echo -e "${GREEN}- Jika nodeJS dan mongoDB belum terinstall, maka akan terinstall versi:${NC}"
echo -e "${GREEN}   • NodeJS: 16.x atau 18.x, otomatis memilih tergantung support dari OS nya${NC}"
echo -e "${GREEN}   • mongodb: 4.4 atau 7.0, otomatis memilih tergantung support dari OS nya${NC}"
echo -e "${GREEN}=> TESTED ubuntu server 18 (Bionic), 20 (Focal), 22 (Jammy), 23 (Mantic), dan 24 (Noble)${NC}"
echo -e "${GREEN}=> UNTESTED armbian, and other OS${NC}"
echo -e "${GREEN}Untuk konfigurasi, technical support, integrasi API, Hubungi whatsapp 0838-3236-2616 atau telegram https://t.me/Pwrrp${NC}"
echo -e "${GREEN}${NC}"
echo -e "${GREEN}======================================================================================${NC}"
echo -e "${RED}${NC}"
echo -e "${GREEN}Sebelum melanjutkan, silahkan baca terlebih dahulu. Apakah anda ingin melanjutkan? (y/n)${NC}"
read confirmation

if [ "$confirmation" != "y" ]; then
    echo -e "${GREEN}Install dibatalkan. Tidak ada perubahan dalam ubuntu server anda.${NC}"
    /tmp/install.sh
    exit 1
fi
for ((i = 5; i >= 1; i--)); do
	sleep 1
    echo "Melanjutkan dalam $i. Tekan ctrl+c untuk membatalkan"
done

#MongoDB
if ! sudo systemctl is-active --quiet mongod; then
    curl -s \
${url_install}\
mongod.sh | \
sudo bash
else
    echo -e "${GREEN}============================================================================${NC}"
    echo -e "${GREEN}=================== mongodb sudah terinstall sebelumnya. ===================${NC}"
fi
sleep 3
if ! sudo systemctl is-active --quiet mongod; then
    sudo rm /genieacs/install.sh
    exit 1
fi

#NodeJS Install
check_node_version() {
    if command -v node > /dev/null 2>&1; then
        NODE_VERSION=$(node -v | cut -d 'v' -f 2)
        NODE_MAJOR_VERSION=$(echo $NODE_VERSION | cut -d '.' -f 1)
        NODE_MINOR_VERSION=$(echo $NODE_VERSION | cut -d '.' -f 2)

        if [ "$NODE_MAJOR_VERSION" -lt 12 ] || { [ "$NODE_MAJOR_VERSION" -eq 12 ] && [ "$NODE_MINOR_VERSION" -lt 13 ]; } || [ "$NODE_MAJOR_VERSION" -gt 22 ]; then
            return 1
        else
            return 0
        fi
    else
        return 1
    fi
}

if ! check_node_version; then
    curl -s \
${url_install}\
nodejs.sh | \
sudo bash
else
    NODE_VERSION=$(node -v | cut -d 'v' -f 2)
    echo -e "${GREEN}============================================================================${NC}"
    echo -e "${GREEN}============== NodeJS sudah terinstall versi ${NODE_VERSION}. ==============${NC}"
    echo -e "${GREEN}========================= Lanjut install GenieACS ==========================${NC}"

fi
if ! check_node_version; then
    sudo rm /genieacs/install.sh
    exit 1
fi

#APP
if ! sudo systemctl is-active --quiet genieacs-{cwmp,fs,ui,nbi}; then
    curl -s \
${url_install}\
app.sh | \
sudo bash
    sleep 3
    if ! sudo systemctl is-active --quiet genieacs-{cwmp,fs,ui,nbi}; then
        echo -e "${RED}============================================================================${NC}"
        echo -e "${RED}======================= INSTALASI TIDAK BISA DILANJUTKAN. ==================${NC}"
        echo -e "${GREEN}=================== Informasi: Whatsapp 081-947-215-703 ==================${NC}"
        echo -e "${RED}============================================================================${NC}"
        sudo rm /genieacs/install.sh
        exit 1
    fi

else
    echo -e "${GREEN}============================================================================${NC}"
    echo -e "${GREEN}=================== GenieACS sudah terinstall sebelumnya. ==================${NC}"
fi


sleep 3

if ! sudo systemctl is-active --quiet genieacs-{cwmp,fs,ui,nbi}; then
    sudo rm /genieacs/install.sh
    exit 1
fi

echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}========== GenieACS UI akses port 3000. : http://$local_ip:3000 ============${NC}"
echo -e "${GREEN}=================== Informasi: Whatsapp 081-947-215-703 ====================${NC}"
echo -e "${GREEN}============================================================================${NC}"
sudo rm /genieacs/install.sh