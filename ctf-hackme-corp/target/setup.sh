#!/bin/bash
# ============================================================
# CTF Setup Script — Plants unique flags per student
# STUDENT_ID is set from GitHub username automatically
# ============================================================

SID=${STUDENT_ID:-"defaultstudent"}
# Sanitise: lowercase, no spaces
SID=$(echo "$SID" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr -cd '[:alnum:]_')

echo "[CTF] Starting setup for student: $SID"

# ─── Wait for MySQL to be ready ──────────────────────────────
service mysql start
sleep 3
until mysqladmin ping --silent 2>/dev/null; do
    echo "[CTF] Waiting for MySQL..."
    sleep 2
done
echo "[CTF] MySQL ready."

# ─── FLAG 4: SQL Injection — plant flag in database ──────────
mysql -u root <<SQL
CREATE DATABASE IF NOT EXISTS hackme;
USE hackme;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'user'
);

DROP TABLE IF EXISTS flags;
CREATE TABLE flags (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    flag VARCHAR(150) NOT NULL,
    note VARCHAR(100)
);

INSERT INTO users (username, password, role) VALUES
  ('admin',   'Adm!nP@ss2024',  'admin'),
  ('webdev',  'webdev123',       'user'),
  ('testuser','test',            'user');

INSERT INTO flags (flag, note) VALUES
  ('FLAG{${SID}_sql1_inj3ct}', 'SQL Injection Challenge Flag');

GRANT ALL PRIVILEGES ON hackme.* TO 'www-data'@'localhost' IDENTIFIED BY '';
FLUSH PRIVILEGES;
SQL

echo "[CTF] Database seeded."

# ─── FLAG 1: NMAP Banner — embed in Apache custom header ─────
cat >> /etc/apache2/conf-available/security.conf <<APACHECONF

# CTF Challenge 1 Header
Header always set X-CTF-Flag-1 "FLAG{${SID}_nmap_b4nner_scan}"
APACHECONF
a2enconf security 2>/dev/null || true
echo "[CTF] NMAP banner flag planted."

# ─── FLAG 2: SSH Weak Credentials — flag in home dir ─────────
echo "FLAG{${SID}_ssh_w3ak_cred5}" > /home/student/user.txt
chmod 644 /home/student/user.txt
chown student:student /home/student/user.txt

# Also plant a note so students know what to look for
cat > /home/student/README.txt <<NOTE
Welcome, you have successfully logged in via SSH!
Look around... there is a flag file here.
NOTE
echo "[CTF] SSH flag planted."

# ─── FLAG 3: Robots.txt — hidden admin portal ─────────────────
mkdir -p /var/www/html/admin-portal
echo "FLAG{${SID}_r0b0ts_h1dden_d1r}" > /var/www/html/admin-portal/flag.txt
cat > /var/www/html/admin-portal/index.html <<HTML
<html><body>
<h1>Admin Portal</h1>
<p>Flag: FLAG{${SID}_r0b0ts_h1dden_d1r}</p>
</body></html>
HTML

cat > /var/www/html/robots.txt <<ROBOTS
User-agent: *
Disallow: /admin-portal/
Disallow: /uploads/
Disallow: /backup/
ROBOTS
echo "[CTF] robots.txt flag planted."

# ─── FLAG 5: File Upload RCE ──────────────────────────────────
echo "FLAG{${SID}_rce_upl04d_shell}" > /var/www/flag.txt
chmod 644 /var/www/flag.txt
echo "[CTF] RCE flag planted."

# ─── FLAG 6: SUID Privilege Escalation ───────────────────────
echo "FLAG{${SID}_su1d_r00t_3scalat3}" > /root/root.txt
chmod 600 /root/root.txt

# Set SUID bit on 'find' — intentional CTF misconfiguration
chmod u+s /usr/bin/find

echo "[CTF] SUID flag planted (find has SUID bit)."

# ─── FTP anonymous share ──────────────────────────────────────
mkdir -p /srv/ftp/pub
cat > /srv/ftp/pub/welcome.txt <<FTP
Welcome to HackMe Corp FTP server.
This server contains company files.
All access is logged.
FTP
chown -R ftp:ftp /srv/ftp
echo "[CTF] FTP configured."

# ─── Create log folder ───────────────────────────────────────
mkdir -p /var/log/supervisor
mkdir -p /var/run

# ─── Print summary ────────────────────────────────────────────
echo ""
echo "======================================================"
echo "  CTF TARGET READY — Student: $SID"
echo "======================================================"
echo "  HTTP     → http://localhost:80"
echo "  SSH      → ssh student@localhost (password123)"
echo "  FTP      → ftp localhost (anonymous)"
echo "  MySQL    → localhost:3306"
echo "======================================================"
echo ""

# ─── Start all services via supervisor ───────────────────────
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/ctf.conf
