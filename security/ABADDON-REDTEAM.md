# ABADDON-REDTEAM.md — Offensive Red Team Mode

## Purpose
Abaddon runs as an adversarial counterpart to Gideon. Where Gideon audits from a defensive posture, Abaddon actively tries to find breach vectors — thinking like an attacker with access to the local system.

Named for Abaddon the destroyer — methodical, thorough, without mercy toward weak configurations.

---

## Schedule
- **Nightly: 3:45 AM local time** (15 minutes after Gideon)
- Gideon runs first to establish the defensive baseline. Abaddon then challenges it.

---

## Red Team Checks

### 1. Exposed Ports & Listeners
```bash
# Find all listening sockets
ss -tlnp 2>/dev/null || netstat -tlnp 2>/dev/null
lsof -iTCP -sTCP:LISTEN -n -P
```
Flag any listener not on loopback (127.0.0.1 / ::1) that wasn't explicitly approved.

### 2. Credential Leaks
```bash
# Scan temp files, logs, env for credentials
grep -r "api_key\|API_KEY\|password\|token\|secret" /tmp/ --include="*.log" --include="*.txt" -l 2>/dev/null
grep -r "api_key\|password\|secret" /var/log/ -l 2>/dev/null | head -20
env | grep -iE "key|token|secret|pass" | grep -v "^PATH="
```

### 3. Suspicious Processes
```bash
ps aux | grep -v grep | grep -iE "nc |ncat|socat|ngrok|reverse|beacon"
# Also check for crypto miners or unusual CPU usage
ps aux --sort=-%cpu | head -10
```

### 4. File Permission Anomalies
```bash
# World-writable files in sensitive locations
find /etc /home /root -maxdepth 3 -perm -o+w -type f 2>/dev/null
# SUID binaries (unexpected ones)
find / -perm -4000 -type f 2>/dev/null | grep -v "^/usr/bin\|^/bin\|^/usr/sbin"
```

### 5. Unauthorized SSH Keys
```bash
cat ~/.ssh/authorized_keys 2>/dev/null
ls -la ~/.ssh/
# Check for new entries since last audit
```

### 6. Unauthorized Cron / LaunchAgents
```bash
crontab -l 2>/dev/null
ls -la ~/Library/LaunchAgents/ 2>/dev/null  # macOS
ls -la /etc/cron.d/ 2>/dev/null              # Linux
```
Compare against known-good list. Flag any entry not in your cron-definitions.template.json.

### 7. Audit Log Anomalies
```bash
# Review exec-audit.log for unusual commands
tail -100 ops/exec-audit.log | grep -iE "curl|wget|nc |eval|base64|/tmp"
# Review identity-change-audit.log
tail -50 ops/identity-change-audit.log
```

### 8. Gateway Loopback Check
```bash
openclaw gateway status
# Must show loopback binding (127.0.0.1 or localhost), NOT 0.0.0.0
```

---

## Output

Write to: `memory/audits/abaddon-YYYY-MM-DD.md`

### Format
```
ABADDON RED TEAM REPORT
Date: YYYY-MM-DD
Grade: A-F

## Findings
#1 [CRITICAL|HIGH|MEDIUM|LOW] Title
Vector: how an attacker would exploit this
Impact: what they could do
Fix: exact remediation

## Attack Surface Summary
- Listening services: N
- World-readable sensitive files: N
- Credential leaks found: N
- Unauthorized cron/launch entries: N
```

---

## Grading Rubric

| Grade | Criteria |
|-------|---------|
| A | No exploitable vectors. Surface area is minimal. |
| B | Minor hardening opportunities. No active breach vectors. |
| C | 1–2 medium issues. Could be exploited with insider access. |
| D | High-severity vector exists. Fix within 24h. |
| F | Active breach vector or credential leak. Fix immediately. |

---

## Escalation

- **F or D grade:** Immediate Telegram alert to personal chat (`YOUR_TELEGRAM_USER_ID`) AND Security topic
- **C grade:** Post to Security topic in nightly summary
- **A or B grade:** Append grade to morning brief only

---

## Constraints

- Abaddon **does not** exfiltrate or exploit. It identifies and reports only.
- Abaddon **does not** change any files or configs. It is read-only.
- All findings go to the audit file. Escalations go to Telegram per the escalation table above.
- Abaddon **never** logs credentials it finds — it flags their location only.
