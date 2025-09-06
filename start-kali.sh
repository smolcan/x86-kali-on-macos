#!/bin/bash
# Script to start Colima + Kali-x86 container + pwndbg

CONTAINER_NAME="kali-x86"

# 0️⃣ Check required brew packages
check_command() {
    CMD=$1
    if ! command -v "$CMD" &>/dev/null; then
        echo "[!] Error: '$CMD' command not found. Please install it first."
        exit 1
    else
        echo "[*] '$CMD' found"
    fi
}

echo "[*] Checking required commands..."
check_command docker
check_command colima
check_command qemu-img

# 1️⃣ Start Colima
echo "[*] Starting Colima..."
colima start --arch x86_64 --memory 4 --cpu 4

# 2️⃣ Start container
echo "[*] Starting container..."
export UID=$(id -u)
export GID=$(id -g)
docker compose up -d

# 3️⃣ Install pwndbg (only if not installed yet)
echo "[*] Checking pwndbg..."
docker exec -it $CONTAINER_NAME bash -c '
if [ ! -f "/home/user/.gdbinit" ]; then
    echo "[*] ~/.gdbinit not found, running setup.sh..."
    if [ ! -d "/home/user/pwndbg" ]; then
        echo "[*] pwndbg directory not found, cloning repo..."
        git clone https://github.com/pwndbg/pwndbg /home/user/pwndbg
    fi
    cd /home/user/pwndbg
    ./setup.sh
else
    echo "[*] ~/.gdbinit exists, skipping pwndbg installation"
fi
'

# 4️⃣ Open interactive shell in container
echo "[*] Opening bash in container..."
docker exec -it $CONTAINER_NAME bash