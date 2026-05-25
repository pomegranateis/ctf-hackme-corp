FROM gitpod/workspace-full

USER root
RUN apt-get update && apt-get install -y \
    nmap nikto sqlmap hydra netcat-openbsd \
    ftp libimage-exiftool-perl steghide binwalk \
    gobuster dirb john hashcat net-tools \
    && rm -rf /var/lib/apt/lists/*

USER gitpod
