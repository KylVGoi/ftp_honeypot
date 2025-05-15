FROM debian:bullseye

# Installer les dépendances
RUN apt-get update && \
    apt-get install -y vsftpd inotify-tools python3 python3-pip clamav curl && \
    pip3 install requests

# Configuration vsftpd
COPY vsftpd.conf /etc/vsftpd.conf

# Scripts
COPY start.sh /start.sh
COPY ftp_watcher.sh /ftp_watcher.sh
COPY alert_discord.py /alert_discord.py

RUN chmod +x /start.sh /ftp_watcher.sh

# Créer les répertoires nécessaires
RUN mkdir -p /home/vsftpd/upload && \
    chmod 733 /home/vsftpd/upload

EXPOSE 21

CMD ["/start.sh"]
