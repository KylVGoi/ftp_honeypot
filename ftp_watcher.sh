#!/bin/bash
WATCH_DIR="/home/vsftpd/upload"
CAPTURE_DIR="/captures/$(date +%F)"
WEBHOOK_URL="https://discord.com/api/webhooks/1372147285928181820/DwKmejZN8lJEWsXei9wsaMJca7ROv_6UEowrbovWnMXR2bLE2QYNfHf9BnuyxniMwr1z"

mkdir -p "$CAPTURE_DIR"

inotifywait -m "$WATCH_DIR" -e create -e moved_to |
while read path action file; do
    echo "[*] Fichier détecté : $file"
    cp "$WATCH_DIR/$file" "$CAPTURE_DIR/$file"
    sha256sum "$CAPTURE_DIR/$file" >> "$CAPTURE_DIR/hashes.log"
    clamscan "$CAPTURE_DIR/$file" >> "$CAPTURE_DIR/clamav_scan.log"
    python3 /alert_discord.py "$file"
    # Envoi vers CAPEv2
    curl -F "file=@$CAPTURE_DIR/$file" http://capev2:8000/tasks/create/file/ >> "$CAPTURE_DIR/cuckoo_submit.log"
done
