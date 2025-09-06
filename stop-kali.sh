#!/bin/bash
# Script to stop the container + Colima

CONTAINER_NAME="kali-x86"

echo "[*] Stopping container $CONTAINER_NAME..."
docker compose stop

echo "[*] Stopping Colima..."
colima stop

echo "[*] Done. Container and Colima are stopped."