# Penetration Test Walkthrough
**Student ID:** <!-- your GitHub username -->
**Date:**
**Target:** localhost (CTF HackMe Corp)
**Assessment:** Ethical Hacking & Penetration Testing

---

> ⚠️ Fill in every section. Blank sections = 0 marks.
> Include real terminal output or screenshots for every command.

---

## Executive Summary
<!-- 3-4 sentences: what did you find, what was compromised, overall risk level -->

---

## Challenge 1 — NMAP Service Banner (2 pts)

### Objective
Identify all running services and find a flag hidden in a service banner.

### Tools Used
```
nmap
```

### Commands Run
```bash
# Paste your exact commands here



```

### Terminal Output / Screenshot
```
# Paste the output here



```

### Flag Found
```
FLAG{...}
```

### Vulnerability Explanation
<!-- What is a service banner? Why is leaking version info dangerous? -->

### Remediation
<!-- How would you fix this? -->

---

## Challenge 2 — SSH Weak Credentials (3 pts)

### Objective
Gain access to the server via SSH using weak default credentials.

### Tools Used
```
ssh, hydra (optional)
```

### Commands Run
```bash
# Paste your exact commands here



```

### Terminal Output / Screenshot
```
# Paste the output here



```

### Flag Found
```
FLAG{...}
```

### Vulnerability Explanation
<!-- Why are weak/default passwords dangerous? What is a brute force attack? -->

### Remediation
<!-- How would you fix this? -->

---

## Challenge 3 — Hidden Web Directory (3 pts)

### Objective
Discover a hidden directory the web server does not want crawlers to index.

### Tools Used
```
curl, nikto, gobuster (your choice)
```

### Commands Run
```bash
# Paste your exact commands here



```

### Terminal Output / Screenshot
```
# Paste the output here



```

### Flag Found
```
FLAG{...}
```

### Vulnerability Explanation
<!-- What is robots.txt? Why is listing secrets in robots.txt a vulnerability? -->

### Remediation
<!-- How would you fix this? -->

---

## Challenge 4 — SQL Injection (4 pts)

### Objective
Exploit a vulnerable search page to dump database contents including a hidden flag.

### Tools Used
```
sqlmap or manual injection
```

### Commands Run
```bash
# Option A — Manual injection payload:
# Paste your payload in the search box and explain what it does



# Option B — sqlmap command:



```

### Injection Payload Explanation
<!-- Explain what your SQL payload does, step by step.
     Example: ' UNION SELECT flag,null,null FROM flags --
     Explain: what does UNION do? what is null? what does -- do? -->

### Terminal Output / Screenshot
```
# Paste the sqlmap output or browser result here



```

### Flag Found
```
FLAG{...}
```

### Vulnerability Explanation
<!-- What is SQL injection? Why is string concatenation in queries dangerous? -->

### Remediation
<!-- How would you fix this? (prepared statements, parameterised queries) -->

---

## Challenge 5 — File Upload + Remote Code Execution (4 pts)

### Objective
Upload a PHP webshell to the server and execute commands to read a protected file.

### Tools Used
```
curl, browser
```

### Webshell Used
```php
<!-- Paste the PHP webshell code you uploaded -->
```

### Commands Run
```bash
# Step 1 — Create the webshell file:


# Step 2 — Upload via curl:


# Step 3 — Execute command via webshell:


```

### Terminal Output / Screenshot
```
# Paste the output here



```

### Flag Found
```
FLAG{...}
```

### Vulnerability Explanation
<!-- What is RCE? Why is an unrestricted file upload dangerous?
     What is a webshell? -->

### Remediation
<!-- File type whitelisting, not storing uploads in web root, etc. -->

---

## Challenge 6 — SUID Privilege Escalation (4 pts)

### Objective
After gaining a shell on the server, escalate from a low-privilege user to root using a SUID misconfiguration.

### Tools Used
```
find, GTFOBins
```

### Commands Run
```bash
# Step 1 — SSH into the server:


# Step 2 — Find SUID binaries:


# Step 3 — Exploit the SUID binary:


# Step 4 — Read the root flag:


```

### Terminal Output / Screenshot
```
# Paste the output here



```

### Flag Found
```
FLAG{...}
```

### SUID Explanation
<!-- What does the SUID bit do? Why is SUID on 'find' dangerous?
     Walk through the GTFOBins technique you used. -->

### Remediation
<!-- How would you fix this? (chmod -s, principle of least privilege) -->

---

## Final Score Summary

| Challenge | Flag Submitted | Marks |
|-----------|---------------|-------|
| 1 — NMAP Banner | FLAG{...} | /2 |
| 2 — SSH Weak Creds | FLAG{...} | /3 |
| 3 — Hidden Directory | FLAG{...} | /3 |
| 4 — SQL Injection | FLAG{...} | /4 |
| 5 — File Upload RCE | FLAG{...} | /4 |
| 6 — SUID Privesc | FLAG{...} | /4 |
| **CTF Total** | | **/20** |
| Walkthrough Quality | | /5 |
| Viva | | /10 |
| **Grand Total** | | **/35** |

---

## Lessons Learned
<!-- What 3 things did you learn from this CTF? -->
1.
2.
3.

---

## References
<!-- List any tools, websites, or resources you used -->
-
-
-
