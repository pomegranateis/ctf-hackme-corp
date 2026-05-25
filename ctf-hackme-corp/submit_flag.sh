#!/bin/bash
# ============================================================
# Flag Submission Script
# Usage: ./submit_flag.sh "FLAG{...}"
# ============================================================

FLAG=$1
PROGRESS_FILE="progress.log"
SCORE_FILE="score.json"

# ── Detect Student ID ───────────────────────────────────────
if [ -n "$GITHUB_USER" ]; then
    SID=$(echo "$GITHUB_USER" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
elif [ -n "$GITPOD_GIT_USER_NAME" ]; then
    SID=$(echo "$GITPOD_GIT_USER_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
else
    SID=${STUDENT_ID:-"defaultstudent"}
fi

# ── Usage check ─────────────────────────────────────────────
if [ -z "$FLAG" ]; then
    echo ""
    echo "Usage:  ./submit_flag.sh \"FLAG{...}\""
    echo "Example: ./submit_flag.sh \"FLAG{johndoe_nmap_b4nner_scan}\""
    echo ""
    exit 1
fi

# ── Challenge definitions ─────────────────────────────────
declare -A CHALLENGES=(
    ["nmap_b4nner_scan"]="Challenge 1: NMAP Service Banner|2"
    ["ssh_w3ak_cred5"]="Challenge 2: SSH Weak Credentials|3"
    ["r0b0ts_h1dden_d1r"]="Challenge 3: Hidden Web Directory|3"
    ["sql1_inj3ct"]="Challenge 4: SQL Injection|4"
    ["rce_upl04d_shell"]="Challenge 5: File Upload RCE|4"
    ["su1d_r00t_3scalat3"]="Challenge 6: SUID Privilege Escalation|4"
)

echo ""

# ── Check if already submitted ───────────────────────────────
if [ -f "$PROGRESS_FILE" ] && grep -q "^$FLAG|" "$PROGRESS_FILE" 2>/dev/null; then
    echo "ℹ  You already submitted this flag!"
    echo ""
    show_score
    exit 0
fi

# ── Validate flag format ─────────────────────────────────────
if ! echo "$FLAG" | grep -qE '^FLAG\{[a-z0-9_]+\}$'; then
    echo "✗  Invalid flag format."
    echo "   Flags look like: FLAG{yourusername_challenge_keyword}"
    echo ""
    exit 1
fi

# ── Match against known challenge keywords ───────────────────
MATCHED=false
MATCHED_NAME=""
MATCHED_PTS=0

for keyword in "${!CHALLENGES[@]}"; do
    EXPECTED="FLAG{${SID}_${keyword}}"
    if [ "$FLAG" = "$EXPECTED" ]; then
        IFS='|' read -r CNAME CPTS <<< "${CHALLENGES[$keyword]}"
        MATCHED=true
        MATCHED_NAME="$CNAME"
        MATCHED_PTS=$CPTS
        break
    fi
done

# ── Result ───────────────────────────────────────────────────
if [ "$MATCHED" = true ]; then
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$FLAG|$TIMESTAMP|$MATCHED_NAME|$MATCHED_PTS pts" >> "$PROGRESS_FILE"

    echo "┌─────────────────────────────────────────────────┐"
    echo "│  ✓  CORRECT FLAG!                               │"
    echo "├─────────────────────────────────────────────────┤"
    printf "│  %-47s │\n" "$MATCHED_NAME"
    printf "│  Points earned: %-31s │\n" "+${MATCHED_PTS} pts"
    printf "│  Time: %-39s │\n" "$TIMESTAMP"
    echo "└─────────────────────────────────────────────────┘"
else
    echo "✗  Incorrect flag."
    echo "   Make sure you are using your own student ID: $SID"
    echo "   Format: FLAG{${SID}_keyword}"
fi

echo ""

# ── Show current score ───────────────────────────────────────
if [ -f "$PROGRESS_FILE" ]; then
    TOTAL=$(awk -F'|' '{gsub(" pts","",$4); sum+=$4} END{print sum+0}' "$PROGRESS_FILE")
    COUNT=$(wc -l < "$PROGRESS_FILE" | tr -d ' ')
    echo "── Your Progress ─────────────────────────────────────"
    echo "   Flags captured : $COUNT / 6"
    echo "   Total score    : $TOTAL / 20"
    echo ""
    echo "── Captured flags ────────────────────────────────────"
    awk -F'|' '{printf "   ✓  %-35s %s\n", $3, $4}' "$PROGRESS_FILE"
    echo ""
fi
