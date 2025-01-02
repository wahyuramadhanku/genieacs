#!/bin/bash
#sudo curl http://acs.wipoint.my.id/genieacs/update/update.sh -o /tmp/update.sh && sudo bash /tmp/update.sh
version="full201024"

url_config='http://acs.wipoint.my.id/genieacs/update/'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
local_ip=$(hostname -I | awk '{print $1}')
FILE_PATH="/opt/genieacs/.genieacs.app"
REQUIRED_STRING="GenieACS INSTALL@HR0838-3236-2616"
BACKUP_DIR="/opt/genieacs/.backup/before_$version"
DATABASE_NAME="genieacs"

if grep -q "$REQUIRED_STRING" "$FILE_PATH"; then

echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}========================== Script Update GenieACS ==========================${NC}"
echo -e "${GREEN}===================== By R-Tech. Info 62838-3236-2616 ======================${NC}"
echo -e "${GREEN}============================================================================${NC}"
echo -e "${RED}========================= Baca terlebih dahulu !!! =========================${NC}"
echo -e "${GREEN} ${NC}"
echo -e "${GREEN}  Script update GenieACS${NC}"
echo -e "${GREEN}  Config Update: $version${NC}"
echo -e "${GREEN}  Config sebelumnya akan terhapus dan tergantikan oleh config baru.${NC}"
echo -e "${GREEN}  Yang akan diupdate, yaitu:${NC}"
echo -e "${GREEN}   • Admin >> Preset${NC}"
echo -e "${GREEN}   • Admin >> Provosions${NC}"
echo -e "${GREEN}   • Admin >> Virtual Parameter${NC}"
echo -e "${GREEN}   • Admin >> Config${NC}"
echo -e "${GREEN}  Script/config tersebut akan terganti dengan yang baru${NC}"
echo -e "${GREEN} ${NC}"
echo -e "${GREEN}  Jika anda memiliki config/script custom buatan anda sendiri, silahkan backup terlebih dahulu, kemudian setelah update lakukan config manual lagi sesuai config custom anda.${NC}"
echo -e "${GREEN} ${NC}"
echo -e "${GREEN}  Device, user, permisions, tidak akan terpengaruh${NC}"
echo -e "${GREEN}  Bagi yang confignya error, akan ter-repair dengan script ini${NC}"
echo -e "${GREEN}  Anda masih bisa kembali ke konfigurasi sebelumnya dengan memilih restore.${NC}"
echo -e "${RED}${NC}"
echo -e "${GREEN}  Menerima jasa:${NC}"
echo -e "${GREEN}  - Configurasi linux server${NC}"
echo -e "${GREEN}     • DNS Server local${NC}"
echo -e "${GREEN}     • DNS Server Trust-NG Kominfo${NC}"
echo -e "${GREEN}     • Web Server${NC}"
echo -e "${GREEN}     • Speedtest Server local (Web Base)${NC}"
echo -e "${GREEN}     • Speedtest Server Online Ookla, nperf${NC}"
echo -e "${GREEN}     • Script autoregister ONU di OLT${NC}"
echo -e "${GREEN}     • DLL${NC}"
echo -e "${GREEN}  - Configurasi Perangkat Networking${NC}"
echo -e "${GREEN}     • Mikrotik${NC}"
echo -e "${GREEN}     • Cisco${NC}"
echo -e "${GREEN}     • OLT ZTE, HSGQ, VSOL, DLL.${NC}"
echo -e "${GREEN}     • Dan perangkat lainnya${NC}"
echo -e "${GREEN}  - Billing terintegrasi dengan GenieACS (termasuk whatsapp bot untuk client, dan telegram bot) segera hadir.${NC}"
echo -e "${RED}${NC}"
echo -e "${GREEN}Butuh bantuan? silahkan hubungi melalui Whatsapp 62838-3236-2616${NC}"
echo -e "${RED}${NC}"
echo -e "${GREEN}  Masukan pilihan:${NC}"
echo -e "${GREEN}   1. Lanjutkan update (Pastikan anda sudah membaca catatan diatas)${NC}"
echo -e "${GREEN}   2. Restore, hapus update dan kembalikan ke konfigurasi sebelumnya${NC}"
echo -e "${GREEN}   0. Keluar${NC}"

read confirmation
if [ "$confirmation" != "1" ]; then
    if [ "$confirmation" = "2" ]; then
        if grep -q "$REQUIRED_STRING" "$FILE_PATH"; then
        if [ -d "$BACKUP_DIR/genieacs" ] && [ "$(ls -A $BACKUP_DIR/genieacs)" ]; then
            echo -e "${GREEN}============================================================================${NC}"
            echo -e "${GREEN}============================ Merestore genieACS. ============================${NC}"
            # estore database MongoDB
            sudo mongorestore --db genieacs --drop "$BACKUP_DIR/genieacs"
            clear
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}============================ Restore Berhasil. =============================${NC}"
            else
                clear
                echo -e "${GREEN}============================== Restore Gagal. ==============================${NC}"
            fi
        else
            clear
            echo -e "${GREEN}========================= Backup tidak ditemukan. =========================${NC}"
        fi
        else
            clear
            echo -e "${GREEN}========================= Backup tidak ditemukan. =========================${NC}"
        fi
        sudo rm /tmp/update.sh
        exit 1
    else
        echo -e "${GREEN}Update dibatalkan. Tidak ada perubahan dalam genieACS anda.${NC}"
        sudo rm /tmp/update.sh
        exit 1
    fi
fi


echo -e "${GREEN}Sebelum melanjutkan, silahkan baca terlebih dahulu. Apakah anda ingin melanjutkan? (y/n)${NC}"
read confirmation
if [ "$confirmation" != "y" ]; then
    echo -e "${GREEN}Update dibatalkan. Tidak ada perubahan dalam ubuntu server anda.${NC}"
    sudo rm /tmp/update.sh
    exit 1
fi
for ((i = 10; i >= 1; i--)); do
	sleep 1
    echo "Melanjutkan dalam $i. Tekan ctrl+c untuk membatalkan"
done

if [ ! -d "$BACKUP_DIR" ]; then
sudo mongodump --db genieacs --out $BACKUP_DIR
fi
clear

if ! sudo systemctl is-active --quiet genieacs-{cwmp,ui,nbi}; then
    echo -e "${RED}============================================================================${NC}"
    echo -e "${RED}============================================================================${NC}"
    echo -e "${RED}==== GenieACS Tidak running. INSTALASI TIDAK BISA DILANJUTKAN. ====${NC}"
    echo -e "${RED}============================================================================${NC}"
    exit 1
fi

# config

curl ${url_config}conf.sh | sudo bash
clear
if ! sudo systemctl is-active --quiet genieacs-{cwmp,ui,nbi}; then
    echo -e "${RED}============================================================================${NC}"
    echo -e "${RED}================ Update gagal. GenieACS tidak bisa running. ================${NC}"
    echo -e "${RED}============================================================================${NC}"
    exit 1
fi

echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}======================== Mengkonfigurasi Provosions ========================${NC}"
echo -e "${GREEN}============================================================================${NC}"
for ((i = 20; i >= 1; i--)); do
	sleep 1
    echo "Melanjutkan dalam $i detik..."
done

#Provosions
curl ${url_config}provos.sh | sudo bash

clear
echo -e "${GREEN}============================== Update Berhasil =============================${NC}"
echo -e "${GREEN}================== ACS URL di ONT: http://${local_ip}:7547 =================${NC}"
echo -e "${GREEN}Jika anda menggunakan ACS URL berbeda, silahkan edit di Admin >> Provosions >> inform${NC}"
echo -e "${GREEN}=================== Informasi: Whatsapp 0838-3236-2616 =====================${NC}"
echo -e "${GREEN}============================================================================${NC}"
sudo rm /tmp/update.sh
else
curl ${url_config}noupdate.sh | sudo bash
clear
echo -e "${RED}============================================================================${NC}"
echo -e "${RED}===== Update tidak dapat dilanjutkan. Config bukan berasal dari HR-Tech ====${NC}"
echo -e "${RED}============================================================================${NC}"
echo -e "${RED}============================ Info 62838-3236-2616 ===========================${NC}"
sleep 1
sudo rm /tmp/update.sh
exit 1
fi