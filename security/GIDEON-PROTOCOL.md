# GIDEON-PROTOCOL.md — Defensive Security Audit Framework

## Purpose
Gideon runs nightly to audit the system from a defensive posture. It catches misconfigurations, exposed surfaces, stale credentials, and operational drift before attackers do.

Named for Gideon the judge — tests carefully, acts decisively.

---

## Schedule
- **Nightly: 3:30 AM local time**
- **Weekly additions (Sunday):** Broader scope, dependency review
- **Monthly additions (1st of month):** Full audit history review, trend analysis

---

## Audit Scope (Four Perspectives)

### 1. Offensive Thinking (how would an attacker get in?)
- Open ports and listeners beyond expected services
- Exposed admin interfaces (SSH, RPC, web UI) without auth
- Services running as root unnecessarily
- World-readable config files with credentials

### 2. Defensive Posture (are the walls standing?)
- Firewall rules active and correct
- SSH hardened (no password auth, no root login)
- Auto-updates enabled (OS + critical packages)
- Backups running and recent
- OpenClaw gateway bound to loopback only (not 0.0.0.0)

### 3. Data Privacy
- No sensitive data in plaintext logs or temp files
- No credentials in environment variables that shouldn't be there
- Obsidian vault not exposed over network
- Telegram bot token not in world-readable files

### 4. Operational Realism
- Are cron jobs actually running? Check `ops/task-ledger.md`
- Are any jobs failing silently? (consecutiveErrors > 0)
- Memory growth trends — is anything bloating unexpectedly?
- Is the gateway healthy? (`openclaw gateway status`)

---

## Audit Output

Write findings to: `memory/audits/YYYY-MM-DD.md`

### Finding Format
```
#N [SEVERITY] Short title
Status: NEW | RECURRING | RESOLVED
Details: what was found
Risk: what could happen
Remediation: exact command or action to fix
```

Severity levels: CRITICAL | HIGH | MEDIUM | LOW | INFO

---

## Escalation

| Finding | Action |
|---------|--------|
| CRITICAL | Immediate Telegram alert to human's personal chat + Security topic |
| HIGH | Post to Security topic at next cycle |
| MEDIUM | Include in nightly summary |
| LOW / INFO | Include in audit file, omit from Telegram unless requested |

### Telegram Delivery
```
target: YOUR_TELEGRAM_GROUP_ID
threadId: YOUR_SECURITY_THREAD_ID
```
CRITICAL findings also go direct to: `YOUR_TELEGRAM_USER_ID`

---

## Letter Grade

End every audit with a letter grade: **A / B / C / D / F**

| Grade | Meaning |
|-------|---------|
| A | Clean. No findings above INFO. |
| B | Minor issues. Nothing exploitable. |
| C | Medium findings need attention within 48h. |
| D | High findings. Action required today. |
| F | Critical findings. Stop everything and fix. |

Append grade + top finding to `ops/morning-brief-data.md` under `## Security`.

---

## Cadence Details

**Daily (every run):**
- Port scan (loopback + LAN interfaces)
- SSH config check
- Gateway loopback binding check
- Cron health check
- Temp file scan for credentials
- World-readable sensitive files

**Weekly (Sundays only):**
- Full dependency audit (brew, npm, pip outdated packages)
- Review LaunchAgents / cron for unauthorized entries
- Review SSH authorized_keys
- Review ops/exec-audit.log for anomalies

**Monthly (1st of month):**
- Trend analysis: audit grade history
- Summarize recurring findings that haven't been fixed
- Flag any finding that has appeared 3+ times as a systemic issue

---

## Integration With Morning Brief

After the audit, append to `ops/morning-brief-data.md`:
```
## Security
Grade: B
Top finding: [one line]
Gideon: [YYYY-MM-DD audit complete]
Abaddon: [pending / grade]
```
