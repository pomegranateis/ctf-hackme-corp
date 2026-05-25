#!/bin/bash
# ============================================================
# Install all CTF attack tools into the Codespace environment
# Runs once when the Codespace is first created
# ============================================================

set -e
echo ""
echo "╔══════════════════════════════════════╗"
echo "║  Installing CTF Attack Tools...      ║"
echo "╚══════════════════════════════════════╝"
echo ""

sudo apt-get update -qq

# Core tools
sudo apt-get install -y -qq \
    nmap \
    nikto \
    sqlmap \
    hydra \
    netcat-openbsd \
    curl \
    wget \
    ftp \
    openssh-client \
    python3 \
    python3-pip \
    john \
    hashcat \
    gobuster \
    dirb \
    whois \
    dnsutils \
    tcpdump \
    net-tools \
    iputils-ping \
    libimage-exiftool-perl \
    steghide \
    binwalk \
    xxd \
    strings \
    file \
    unzip \
    git \
    vim \
    jq 2>&1 | tail -5

# Python tools
pip3 install -q requests impacket 2>/dev/null || true

echo ""
echo "✓ All tools installed."
echo ""
echo "Available tools:"
echo "  nmap       — port scanning & service detection"
echo "  sqlmap     — automated SQL injection"
echo "  nikto      — web vulnerability scanner"
echo "  hydra      — brute force login attacks"
echo "  gobuster   — directory/file brute forcing"
echo "  nc         — netcat for reverse shells"
echo "  exiftool   — EXIF metadata extraction"
echo "  john       — password hash cracking"
echo "  hashcat    — GPU password cracking"
echo "  binwalk    — binary analysis"
echo "  steghide   — steganography"
echo ""
