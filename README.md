# genieacs
================install genieacs otomatis================

# GACS-Ubuntu-22.04
This is autoinstall GenieACS For ubuntu version 22.04 (Jammy)

# Usage
```
sudo su
```
```
git clone https://github.com/safrinnetwork/GACS-Ubuntu-22.04
```
```
cd GACS-Ubuntu-22.04
```
```
chmod +x GACS-Jammy.sh
```
```
sudo apt-get install dos2unix
```
```
dos2unix GACS-Jammy.sh
```
```
bash GACS-Jammy.sh
```

# Full Tutorial
- https://youtu.be/p_UNuq0rfg0
============= INFO 081947215703 ==============

======================= Baca terlebih dahulu !!! ========================

#=== Script update GenieACS ====#

Config sebelumnya akan terhapus dan tergantikan oleh config baru

Yang akan diupdate, yaitu:

   • Admin >> Preset <br>
   • Admin >> Provosions <br>
   • Admin >> Virtual Parameter<br>
   • Admin >> Config<br>
   
#===Script/config tersebut akan terganti dengan yang baru ====#

Jika anda memiliki config/script custom buatan anda sendiri,<br> 
silahkan backup terlebih dahulu, kemudian setelah update lakukan config manual lagi sesuai config custom anda.<br>

Device, user, permisions, tidak akan terpengaruh<br>
Bagi yang confignya error, akan ter-repair dengan script ini<br>
Anda masih bisa kembali ke konfigurasi sebelumnya dengan memilih restore<br>
============= CARA RESTORE ================= <br>
cd<br>
sudo mongorestore --db=genieacs --drop genieacs-backup/genieacs



