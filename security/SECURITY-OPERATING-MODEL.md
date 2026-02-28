# SECURITY-OPERATING-MODEL.md — How Gideon + Abaddon Fit Together

## Overview

OpenClaw Supercharge ships with a two-layer security model that runs automatically every night. You don't need to think about it — but you should understand what it's doing.

```
3:00 AM — Nightly Maintenance (memory, cost reports, workspace cleanup)
3:30 AM — Gideon (defensive audit — four-perspective review)
3:45 AM — Abaddon (red team — adversarial attack surface scan)
8:00 AM — Morning Brief (includes security grades from both)
```

---

## Gideon vs. Abaddon

| | Gideon | Abaddon |
|--|--------|---------|
| Mode | Defensive | Offensive (red team) |
| Question | "Are our defenses holding?" | "How would an attacker get in?" |
| Approach | Compliance check, config review | Active scanning, attack vector identification |
| Output | Letter grade A–F, finding list | Letter grade A–F, attack surface map |
| Escalation | CRITICAL → immediate Telegram | F or D grade → immediate Telegram |

Both write to `memory/audits/`. Both append to `ops/morning-brief-data.md`.

---

## Delivery Model

### Silent Mode (A or B grade)
- Audit file written to `memory/audits/`
- Grade + one-liner appended to morning brief data
- No Telegram noise

### Alert Mode (C grade)
- Summary posted to Security topic at next opportunity
- Findings listed with remediation steps

### Emergency Mode (D/F grade or CRITICAL finding)
- Immediate Telegram alert to personal chat
- Immediate post to Security topic
- Morning brief flags it prominently

---

## Manual Triggers

You can trigger either audit on demand:

```
# Trigger Gideon manually
Tell the main agent: "Run Gideon audit now"
→ main agent spawns observer agent in isolated session with audit prompt

# Trigger Abaddon manually
Tell the main agent: "Run Abaddon red team scan"
→ same pattern
```

---

## Responding to Findings

### For CRITICAL or D/F findings:
1. Main agent alerts you immediately via Telegram
2. You read the audit file at `memory/audits/YYYY-MM-DD.md`
3. You instruct main agent to dispatch fix (usually to Bezzy)
4. Bezzy implements fix, Nehemiah verifies, Gideon re-runs to confirm

### For routine findings (A/B/C):
1. Morning brief includes grade and top finding
2. You decide at morning review whether to act
3. Backlog the fix: add to `shared-context/backlog.md` if not urgent

---

## What's NOT Covered

- Abaddon and Gideon audit the **local system and OpenClaw gateway**. They do not audit:
  - External services (Telegram, Anthropic API, OpenAI API)
  - Your Obsidian vault contents (for content-level security)
  - Network-level threats beyond your local interface

For those, you need separate tooling (1Password for credentials, Cloudflare for WAF, etc.).

---

## Audit History

Audits accumulate in `memory/audits/`. Monthly, the nightly maintenance job reviews trends and flags any finding that has appeared 3+ times as systemic.

Use this to track improvement over time:
```bash
grep "^Grade:" memory/audits/*.md | sort
```
