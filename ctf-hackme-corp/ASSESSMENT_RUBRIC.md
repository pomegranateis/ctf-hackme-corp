# Assessment Rubric — Ethical Hacking CTF
**Tutor Reference Document**
**Total: 35 Marks**

---

## Part A — CTF Challenges (20 Marks)

### Marking: Binary (Flag correct = full marks, incorrect/missing = 0)
Verify flags from student's `progress.log` — each flag contains their GitHub username, making copying impossible.

| # | Challenge | Max | Flag Keyword | Solution Summary |
|---|-----------|-----|--------------|-----------------|
| 1 | NMAP Service Banner | 2 | `nmap_b4nner_scan` | `nmap -sV localhost` → read `X-CTF-Flag-1` header |
| 2 | SSH Weak Credentials | 3 | `ssh_w3ak_cred5` | `ssh student@localhost` password: `password123` → `cat user.txt` |
| 3 | Hidden Web Directory | 3 | `r0b0ts_h1dden_d1r` | `curl localhost/robots.txt` → access `/admin-portal/flag.txt` |
| 4 | SQL Injection | 4 | `sql1_inj3ct` | `sqlmap -u "http://localhost/search.php?q=a" --dump` |
| 5 | File Upload RCE | 4 | `rce_upl04d_shell` | Upload `shell.php`, execute `?c=cat+/var/www/flag.txt` |
| 6 | SUID Privesc | 4 | `su1d_r00t_3scalat3` | SSH in → `find / -perm -4000` → `find . -exec /bin/sh -p \;` → `cat /root/root.txt` |

---

## Part B — Walkthrough Report (5 Marks)

Award marks holistically across the entire document:

| Band | Marks | Criteria |
|------|-------|----------|
| Excellent | 5 | Every challenge documented. All commands present with real output. Vulnerability clearly explained with correct terminology. Remediation is specific and technically accurate. Well-structured and clearly written. |
| Good | 4 | All attempted challenges documented. Most commands present. Good explanation of vulnerabilities. Minor gaps in remediation or structure. |
| Satisfactory | 3 | Major challenges documented. Commands present but some missing. Basic explanation of what happened, limited technical depth. |
| Partial | 2 | Incomplete documentation. Some commands present. Minimal vulnerability explanation. |
| Poor | 1 | Very sparse. Commands or output largely missing. No remediation. |
| Not submitted | 0 | Walkthrough not submitted or empty template. |

**Deduct 1 mark if:**
- Student uses another student's flag (academic misconduct — also escalate)
- Walkthrough is clearly AI-generated without real evidence of work

---

## Part C — Viva / Q&A (10 Marks)

Conduct a 10–15 minute oral Q&A per student. Ask questions from their walkthrough.

### Question Bank

**Conceptual (2 marks each — ask 2):**
1. What is the difference between active and passive reconnaissance?
2. Explain what SQL injection is in your own words. Why do prepared statements prevent it?
3. What is a reverse shell? How does it differ from a bind shell?
4. Explain the SUID bit. What does `chmod +s` do and why is it dangerous?
5. What is the purpose of `robots.txt`? Why is listing secret paths in it a security mistake?
6. What is Remote Code Execution? How did the file upload lead to RCE?

**Technical (1 mark each — ask 2):**
1. What does the `-sV` flag in nmap do?
2. What is the difference between `UNION SELECT` and a regular `SELECT` in SQL injection?
3. What does `-p -4000` mean in the `find` command for SUID discovery?
4. Why did you use a `.php` extension for the webshell?
5. What is the `--dump` flag in sqlmap?

**Scenario (2 marks — ask 1):**
1. If this were a real company, what would you include in your penetration test report?
2. You find a web app with file upload. What 3 checks would you do to test for vulnerabilities?
3. The company asks you to harden their SSH configuration. What changes would you make?

### Viva Marking

| Band | Marks | Criteria |
|------|-------|----------|
| Excellent | 9–10 | Answers all questions with confidence and technical accuracy. Explains concepts clearly. Shows deep understanding beyond the lab. |
| Good | 7–8 | Answers most questions accurately. Minor gaps or requires prompting. Good understanding of exploits performed. |
| Satisfactory | 5–6 | Answers basic questions. Some confusion on technical details. Can explain what they did but not always why. |
| Partial | 3–4 | Struggles with most questions. Answers vague or incorrect. Likely followed steps without understanding. |
| Poor | 1–2 | Cannot answer basic questions. Likely did not do the work themselves. |
| No Show / Not Attempted | 0 | Did not attend viva or submitted nothing. |

---

## Final Grade Sheet

| Student | CTF /20 | Walkthrough /5 | Viva /10 | Total /35 | Grade |
|---------|---------|---------------|----------|-----------|-------|
| | | | | | |
| | | | | | |
| | | | | | |
| | | | | | |

### Grade Boundaries
| Total | Grade |
|-------|-------|
| 32–35 | HD (High Distinction) |
| 28–31 | D (Distinction) |
| 22–27 | C (Credit) |
| 18–21 | P (Pass) |
| 0–17  | F (Fail) |

---

## Academic Integrity

Each student's flags contain their GitHub username. Cross-check:
1. `progress.log` flags match the student's GitHub username
2. Walkthrough shows real terminal output (not screenshots of someone else's screen)
3. Viva answers align with the walkthrough

Flag format: `FLAG{githubusername_challenge_keyword}` — sharing flags between students is immediately detectable.
