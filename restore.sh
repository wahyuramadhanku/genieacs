#!/bin/bash
url_install='https://srv.ddns.my.id/genieacs/genieacs/'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
local_ip=$(hostname -I | awk '{print $1}')
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}=========== AAA   LL      IIIII     JJJ   AAA   YY   YY   AAA ==============${NC}"   
echo -e "${GREEN}========== AAAAA  LL       III      JJJ  AAAAA  YY   YY  AAAAA =============${NC}" 
echo -e "${GREEN}========= AA   AA LL       III      JJJ AA   AA  YYYYY  AA   AA ============${NC}"
echo -e "${GREEN}========= AAAAAAA LL       III  JJ  JJJ AAAAAAA   YYY   AAAAAAA ============${NC}"
echo -e "${GREEN}========= AA   AA LLLLLLL IIIII  JJJJJ  AA   AA   YYY   AA   AA ============${NC}"
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}========================= . Info 081-947-215-703 ===========================${NC}"
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}========================= RESTORE DATA BASE!!! =============================${NC}"
echo -e "${GREEN}Sebelum melanjutkan, silahkan baca terlebih dahulu. Apakah anda ingin melanjutkan? (y/n)${NC}"
read confirmation

if [ "$confirmation" != "y" ]; then
    echo -e "${GREEN}Install dibatalkan. Tidak ada perubahan dalam ubuntu server anda.${NC}"
            # restore database MongoDB
            sudo mongorestore --db genieacs --drop "genieacs-backup/genieacs"
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
        exit 1
