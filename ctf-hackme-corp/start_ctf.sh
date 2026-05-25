#!/bin/bash
# ============================================================
# CTF Lab Launcher
# Run this inside your Codespace to start the target machine
# ============================================================

clear
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║           HackMe Corp — CTF Lab                         ║"
echo "║           Ethical Hacking & Penetration Testing          ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ── Detect Student ID ────────────────────────────────────────
if [ -n "$GITHUB_USER" ]; then
    export STUDENT_ID=$(echo "$GITHUB_USER" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
elif [ -n "$GITPOD_GIT_USER_NAME" ]; then
    export STUDENT_ID=$(echo "$GITPOD_GIT_USER_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
else
    echo "⚠  Could not auto-detect your GitHub username."
    read -p "Enter your student ID (GitHub username): " STUDENT_ID
    export STUDENT_ID
fi

echo "  Student ID : $STUDENT_ID"
echo "  Target IP  : localhost (127.0.0.1)"
echo ""

# ── Build and start the target container ────────────────────
echo "Building target machine (first run may take 2-3 minutes)..."
STUDENT_ID=$STUDENT_ID docker-compose up -d --build

if [ $? -ne 0 ]; then
    echo ""
    echo "✗ Failed to start. Try: docker-compose down && ./start_ctf.sh"
    exit 1
fi

echo ""
echo "Waiting for all services to start..."
sleep 8

# ── Health checks ─────────────────────────────────────────
HTTP_OK=false
SSH_OK=false
FTP_OK=false

curl -s http://localhost:80 > /dev/null 2>&1 && HTTP_OK=true
nc -zw2 localhost 22 2>/dev/null && SSH_OK=true
nc -zw2 localhost 21 2>/dev/null && FTP_OK=true

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Service Status                                          ║"
echo "╠══════════════════════════════════════════════════════════╣"
$HTTP_OK && echo "║  ✓ HTTP (80)    — http://localhost         [UP]          ║" || \
            echo "║  ✗ HTTP (80)    — Web server starting...   [STARTING]    ║"
$SSH_OK  && echo "║  ✓ SSH  (22)    — ssh student@localhost    [UP]          ║" || \
            echo "║  ✗ SSH  (22)    — SSH starting...          [STARTING]    ║"
$FTP_OK  && echo "║  ✓ FTP  (21)    — ftp localhost            [UP]          ║" || \
            echo "║  ✗ FTP  (21)    — FTP starting...          [STARTING]    ║"
echo "║  • MySQL(3306)  — localhost:3306                         ║"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║  SSH Credentials: student / password123                  ║"
echo "║  FTP: anonymous login (blank password)                   ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "  Start hacking: run ./check_target.sh to verify"
echo "  Submit flags:  ./submit_flag.sh \"FLAG{...}\""
echo "  Reset target:  docker-compose down && ./start_ctf.sh"
echo ""
echo "  Good luck, $STUDENT_ID! 🎯"
echo ""
