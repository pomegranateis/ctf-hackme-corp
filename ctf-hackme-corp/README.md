# 🏴 CTF — HackMe Corp | Penetration Testing Lab

> **Assessment:** Ethical Hacking & Penetration Testing
> **Total Marks:** 35 &nbsp;|&nbsp; CTF: 20 &nbsp;|&nbsp; Walkthrough Report: 5 &nbsp;|&nbsp; Viva: 10

---

## 📋 Assessment Breakdown

| Component | Marks | Details |
|-----------|-------|---------|
| CTF Challenges (6 flags) | 20 | Capture flags by exploiting vulnerabilities |
| Walkthrough Report | 5 | Document every step — tools, commands, screenshots |
| Viva / Q&A | 10 | Live questions based on your walkthrough |
| **Total** | **35** | |

---

## 🚀 How to Start — GitHub Codespaces (Recommended)

### Step 1 — Fork this repository
Click **Fork** (top-right of this page) → Create your own copy under your GitHub account.

### Step 2 — Open in GitHub Codespaces
In **your forked repo**, click:
```
Code → Codespaces → Create codespace on main
```
Wait ~2 minutes for setup to complete automatically.

### Step 3 — Start the CTF target
Once the Codespace terminal opens, run:
```bash
./start_ctf.sh
```
This builds and starts the vulnerable target machine. Your student ID (GitHub username) is automatically set — your flags are unique to you.

### Step 4 — Verify target is running
```bash
./check_target.sh
```
You should see all 4 services: HTTP (80), SSH (22), MySQL (3306), FTP (21).

---

## 🎯 Challenges — 20 Marks Total

| # | Challenge | Skill | Marks | Hint |
|---|-----------|-------|-------|------|
| 1 | NMAP Service Banner | Reconnaissance | 2 | Scan all ports with version detection |
| 2 | SSH Weak Credentials | Authentication Attack | 3 | Try default/common credentials |
| 3 | Hidden Web Directory | Web Recon | 3 | Check what the web server does not want you to see |
| 4 | SQL Injection | Web Exploitation | 4 | The search box trusts user input too much |
| 5 | File Upload + RCE | Web Exploitation | 4 | Upload something the server will execute |
| 6 | SUID Privilege Escalation | Post-Exploitation | 4 | Find binaries with special permissions |

---

## 🔐 Submitting Flags

Every flag looks like:
```
FLAG{yourgithubusername_challenge_keyword}
```

Submit each flag by running:
```bash
./submit_flag.sh "FLAG{...}"
```

Your progress is saved in `progress.log` — include this in your walkthrough.

---

## 📝 Walkthrough Report (5 Marks)

After completing the challenges, fill in `WALKTHROUGH_TEMPLATE.md` and push it to your fork. See `ASSESSMENT_RUBRIC.md` for marking criteria.

**Requirements:**
- Screenshot or terminal output for every step
- Every command you ran, in order
- What vulnerability was exploited and why it exists
- How to fix/remediate each vulnerability

---

## 🔧 Tools Available in Codespace

All tools are pre-installed:

```bash
nmap        # port scanning
sqlmap      # SQL injection automation
nikto       # web vulnerability scanner
curl        # HTTP requests
hydra       # brute force
netcat (nc) # network connections
python3     # scripting
ssh         # remote login
ftp         # FTP client
```

---

## ⚠️ Rules

1. Attack **only** `localhost` (your own target container)
2. Do not attempt to attack any other student's Codespace
3. Document everything — undocumented flags earn 0 marks
4. Flag sharing = academic misconduct (every student's flags are unique)

---

## 📂 Repository Structure

```
ctf-hackme-corp/
├── README.md               ← You are here
├── start_ctf.sh            ← Run this first
├── check_target.sh         ← Verify target is up
├── submit_flag.sh          ← Submit your flags
├── progress.log            ← Auto-generated score log
├── target/                 ← Vulnerable machine (do not peek!)
│   ├── Dockerfile
│   ├── setup.sh
│   └── web/
├── .devcontainer/          ← Codespace configuration
├── WALKTHROUGH_TEMPLATE.md ← Fill this in
└── ASSESSMENT_RUBRIC.md    ← Marking guide
```

---

## 🆘 Troubleshooting

| Problem | Fix |
|---------|-----|
| Target not responding | `docker-compose restart` |
| Port conflict | `docker ps` then `docker stop <id>` |
| Tools missing | `sudo apt install <tool> -y` |
| Reset target | `docker-compose down && ./start_ctf.sh` |

---

*Good luck. Hack responsibly.* 🎯
