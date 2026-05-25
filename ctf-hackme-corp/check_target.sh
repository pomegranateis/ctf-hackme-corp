#!/bin/bash
# ============================================================
# Target Health Check — Run after start_ctf.sh
# ============================================================

echo ""
echo "Checking CTF target services..."
echo ""

check_service() {
    local name=$1
    local host=$2
    local port=$3
    nc -zw3 $host $port 2>/dev/null
    if [ $? -eq 0 ]; then
        printf "  ✓  %-8s port %-6s — UP\n" "$name" "$port"
    else
        printf "  ✗  %-8s port %-6s — DOWN (try: docker-compose restart)\n" "$name" "$port"
    fi
}

check_service "HTTP"  "localhost" "80"
check_service "SSH"   "localhost" "22"
check_service "FTP"   "localhost" "21"
check_service "MySQL" "localhost" "3306"

echo ""
echo "Quick connectivity tests:"
echo ""

# HTTP test
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80/ 2>/dev/null)
if [ "$HTTP_CODE" = "200" ]; then
    echo "  ✓  Web app responding (HTTP 200)"
else
    echo "  ✗  Web app not responding (got HTTP $HTTP_CODE)"
fi

# SSH banner
SSH_BANNER=$(timeout 3 ssh -o StrictHostKeyChecking=no -o ConnectTimeout=2 -o BatchMode=yes student@localhost echo test 2>&1)
if echo "$SSH_BANNER" | grep -q "test\|Permission denied"; then
    echo "  ✓  SSH accepting connections"
else
    echo "  ✗  SSH not responding yet"
fi

# FTP test
FTP_RESP=$(echo -e "user anonymous\npass\nquit" | timeout 5 ftp -n localhost 2>&1)
if echo "$FTP_RESP" | grep -q "230\|Login"; then
    echo "  ✓  FTP anonymous login works"
else
    echo "  ✗  FTP not responding yet"
fi

echo ""
echo "Target: localhost | Attacker tools: $(which nmap 2>/dev/null && echo 'installed' || echo 'run .devcontainer/install_tools.sh')"
echo ""
