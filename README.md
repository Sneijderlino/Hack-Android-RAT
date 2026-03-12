# Ghost-ADB-ANDROID

![Menu Ghost-ADB](/img/view-adb.png)

_Contoh menu awal Ghost-ADB_

![Perintah Ghost-ADB](/img/Command.png)

**Skript kontrol ADB (Android Debug Bridge) berbasis Bash**

Repositori ini berisi `Ghost-Adb.sh`, sebuah skrip yang
memanfaatkan `adb` untuk mengendalikan dan mengumpulkan data dari
perangkat Android melalui koneksi USB ataupun TCP/IP. Fitur utamanya
termasuk dump SMS, riwayat panggilan, kontak, kontrol kamera dan
layar, hingga operasi sistem lanjutan.

> ⚠️ **Peringatan:** Semua fungsi dalam skrip ini memiliki potensi
> menyalahgunakan privasi. Gunakan hanya untuk pengujian keamanan
> sendiri atau dengan izin pemilik perangkat.

---

## 📌 Persyaratan Sistem

| Platform   | Keterangan                                                   |
| ---------- | ------------------------------------------------------------ |
| Kali Linux | Paket `android-tools-adb` (untuk `adb`), `scrcpy` (opsional) |
| Termux     | `adb` (via `pkg install adb`), `termux-api` (opsional)       |

> Pastikan `adb` ada dalam PATH. Untuk Termux, jalankan
> `termux-usb` dulu untuk mengaktifkan akses USB.

---

## 🧱 Instalasi

> Sebelum memulai, tinjau `requirements.txt` untuk daftar paket
> yang diperlukan.
>
> ```bash
> cat requirements.txt
> ```

### Kali Linux

1. Update daftar paket dan tingkatkan sistem:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```
2. Pasang paket yang tercantum dalam `requirements.txt`:
   ```bash
   sudo apt install $(grep -v '^#' requirements.txt) -y
   ```
3. Clone atau unduh repositori skrip:
   ```bash
   git clone https://github.com/youruser/Ghost-ADB.git    # gunakan alamat repositori Ghost-ADB Anda
   cd Ghost-ADB    # atau direktori tempat skrip berada
   chmod +x Ghost-Adb.sh                                   # berikan izin eksekusi
   ```
4. Jalankan skrip untuk mulai menggunakan:
   ```bash
   ./Ghost-Adb.sh
   ```

Untuk akses dari mana saja, tambahkan lokasi skrip ke PATH atau buat
symlink:

```bash
sudo ln -s $(pwd)/Ghost-Adb.sh /usr/local/bin/ghost-adb
```

### Termux

```bash
pkg update && pkg upgrade -y
pkg install adb termux-api -y
```

Kemudian clone repositori Ghost-ADB:

```bash
git clone https://github.com/youruser/Ghost-ADB.git
cd Ghost-ADB
chmod +x Ghost-Adb.sh
```

Lalu jalankan skrip di dalam Termux.

> Jika mendapat peringatan USB, jalankan:
>
> ```bash
> termux-usb -l
> ```
>
> untuk mendeteksi perangkat.

---

## 🚀 Cara Menggunakan

1. Aktifkan _USB debugging_ pada perangkat Android.
2. Sambungkan via USB atau gunakan pairing TCP/IP (menu 2 atau 6).
3. Jalankan skrip dan pilih opsi dari menu interaktif.
4. Loot (file/hasil dump) tersimpan ke folder `ADB_LOOT` di direktori
   skrip.

Contoh menjalankan (dari direktori skrip atau lewat symlink):

```bash
./Ghost-Adb.sh      # jika berada di folder skrip
# atau, jika sudah membuat symlink di /usr/local/bin:
ghost-adb             # panggil langsung dari PATH
```

Menu utama menampilkan berbagai kemampuan seperti pengambilan
lokasi GPS, dump kontak, kontrol layar, instal/uninstal APK, dan
shell manual.

---

## 🗂️ Struktur Repo

```
Ghost-Adb.sh   # skrip utama
README.md        # dokumentasi ini
.config_adb/     # cache IP & perangkat
ADB_LOOT/        # hasil dump/perintah
```

---

## 📝 Lisensi

Skrip ini dirilis tanpa lisensi formal; gunakan untuk tujuan
edukasi dan riset keamanan. Anda bertanggung jawab atas setiap
penggunaan.

---

## 🤝 Kontribusi

Fork repositori, lakukan perubahan, dan kirim pull request. Tambahkan
fitur, perbaiki bug, atau perjelas dokumentasi.

---

> ### 🔄 Pembaruan Terbaru
>
> - Skrip utama (`Ghost-Adb.sh`) telah diperbarui. Pastikan untuk
>   mengunduh versi terbaru atau menjalankan `git pull` jika Anda
>   menggunakan klon repositori.
> - Perubahan lain disertakan dalam catatan commit.
>
> _Terakhir diperbarui: 12 Maret 2026_

# Hack-Android-RAT
