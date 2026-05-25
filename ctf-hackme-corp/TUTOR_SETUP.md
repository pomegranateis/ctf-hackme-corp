# Tutor Setup Guide — CTF on GitHub

This is your private setup guide. Follow every step once to create the GitHub repo.
Students then fork it and solve in Codespaces.

---

## Step 1 — Create a GitHub Repository

1. Go to https://github.com/new
2. Repository name: `ctf-hackme-corp`
3. Set to **Public** (students need to fork it)
4. Do NOT initialise with README
5. Click **Create repository**

---

## Step 2 — Upload All Files via Git

On your machine (or any terminal), run these commands:

```bash
# Clone the downloaded zip / folder first, then:
cd ctf-hackme-corp

# Initialise git
git init
git add .
git commit -m "Initial CTF lab setup"

# Connect to your GitHub repo (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/ctf-hackme-corp.git
git branch -M main
git push -u origin main
```

---

## Step 3 — Keep SOLUTIONS.md Private

SOLUTIONS.md is in `.gitignore` so it will NOT be pushed to GitHub.
Store it separately on your local machine.

If you accidentally pushed it:
```bash
git rm --cached SOLUTIONS.md
git commit -m "Remove solutions"
git push
```

---

## Step 4 — Enable GitHub Codespaces

1. In your repo → Settings → Codespaces
2. Set Access to: "Members of my organization" OR keep default
3. Codespace Machine Type: 2-core (free tier is fine)

Students get 60 hours/month free on GitHub Codespaces.

---

## Step 5 — Brief Students

Send students this message:

---
**To Students:**

1. Go to: `https://github.com/YOUR_USERNAME/ctf-hackme-corp`
2. Click **Fork** → Create fork (under your own account)
3. In your fork, click **Code** → **Codespaces** → **Create codespace on main**
4. Wait ~2 minutes for setup
5. In the terminal, run: `./start_ctf.sh`
6. Attack target at `localhost`
7. Submit flags: `./submit_flag.sh "FLAG{...}"`
8. Fill in `WALKTHROUGH_TEMPLATE.md`
9. Push your completed walkthrough: `git add . && git commit -m "Walkthrough" && git push`

---

## Step 6 — Collect Student Work

Students submit by pushing to their forks. To view their work:
1. Go to their forked repo on GitHub
2. Check `progress.log` to verify flags
3. Read `WALKTHROUGH_TEMPLATE.md` for report marks
4. Conduct viva using `ASSESSMENT_RUBRIC.md`

---

## Step 7 — Verify Flags Are Unique

Each flag contains the student's GitHub username. If Student A submits:
`FLAG{student_b_nmap_b4nner_scan}` — they copied from Student B.

The `submit_flag.sh` script automatically rejects flags with the wrong username.

---

## Troubleshooting for Students

| Issue | Solution |
|-------|----------|
| "Docker not found" | Codespace not fully loaded — wait 30 more seconds |
| "Port already in use" | `docker-compose down` then `./start_ctf.sh` |
| "Connection refused" | `docker ps` to check container, then `docker logs ctf-target` |
| Tools missing | `bash .devcontainer/install_tools.sh` |
| Target unresponsive | `docker-compose restart` |

---

## Assessment Timeline Suggestion

| Week | Activity |
|------|----------|
| Week 11 | Release repo, brief students |
| Week 12 (Day 1–5) | CTF open — students work individually |
| Week 12 (Day 7) | Walkthrough submission deadline (push to GitHub) |
| Week 13 | Viva sessions (10–15 min per student) |
