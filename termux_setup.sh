#!/data/data/com.termux/files/usr/bin/bash
# Installs dex2c (codehasan/dex2c) and its dependencies inside Termux.
# Builds the DEX->C native library on-device. This does NOT need Android
# Studio; it only needs storage space (NDK is a few hundred MB).
set -e

echo "[*] Updating packages"
pkg update -y
pkg install -y wget git python which

if ! command -v java >/dev/null 2>&1; then
  echo "[*] No Java found, installing openjdk-21"
  pkg install -y openjdk-21
else
  echo "[*] Using existing Java: $(java -version 2>&1 | head -1)"
fi

echo "[*] Cloning dex2c"
cd ~
if [ -d dex2c ]; then
  echo "[*] dex2c already cloned, pulling latest"
  (cd dex2c && git pull)
else
  git clone https://github.com/codehasan/dex2c
fi
cd dex2c

echo "[*] Installing Python requirements"
pip install -r requirements.txt

echo "[*] Running dex2c's own Termux installer (fetches NDK + apktool)"
wget -O termux_install.sh https://raw.githubusercontent.com/codehasan/dex2c/master/termux_install.sh
chmod +x termux_install.sh
./termux_install.sh

echo "[+] Done. dex2c is at ~/dex2c"
echo "    Put your APK in ~/dex2c, then: python3 dcc.py your.apk"
