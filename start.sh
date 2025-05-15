#!/bin/bash
vsftpd /etc/vsftpd.conf &
/bin/bash /ftp_watcher.sh
