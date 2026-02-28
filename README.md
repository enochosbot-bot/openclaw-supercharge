# OpenClaw Supercharge — Production Template

> A battle-tested, production-grade OpenClaw configuration template. Clone, customize, and run a fully operational AI chief-of-staff system with parallel agents, automated security audits, Obsidian-backed memory, and Telegram command interface.

---

## What This Is

OpenClaw Supercharge is a complete operational template for running a multi-agent AI system on your own hardware. It includes:

- **Named agents** with clear roles and routing rules
- **Nightly automation** (security audits, memory consolidation, cost reports)
- **Context pressure + gateway watchdog** with automated recovery
- **Obsidian as single source of truth** for all memory and research
- **Telegram topic architecture** for organized multi-topic command interface
- **Parallel agent orchestration** with dependency-sorted work packages
- **Approval workflows** and in-flight task tracking
- **Security protocols**: Gideon (defensive audit) + Abaddon (red-team offensive)
- **14 production skills** included (browser automation, AI humanizer, QA dogfooding, task observer, image gen, and more)

---

## Included Skills

| Skill | Purpose |
|-------|---------|
| agent-browser | Browser automation, scraping, form filling, screenshots |
| ai-humanizer | Detect and remove AI patterns from text |
| dogfood | Systematic QA testing — finds bugs, produces structured reports |
| enoch-tuning | Pre-wired production setup (identity, memory, security, automation) |
| task-observer | Monitors execution for skill improvement opportunities |
| skill-creator | Guide for building new skills |
| nano-banana-2 | Gemini 3.1 Flash image generation |
| meta-ads | Meta/Facebook Ads management |
| youtube-upload | YouTube video upload automation |
| openclaw-antigravity-sync | Sync workflows |

See `skills/README.md` for full list and installation.

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    Telegram Interface                        │
│  DMs / Forum Topics (Security, Ops, Briefs, Creative, QA)  │
└──────────────────────────┬──────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────┐
│                   Enoch (main agent)                        │
│         Command center · Orchestration · Memory             │
└──┬──────────┬──────────┬──────────┬──────────┬─────────────┘
   │          │          │          │          │
 Bezzy     Berean      Ezra     Gideon    Solomon
 Coder    Research   Scribe   Security   Judgment
   │
 Nehemiah   Selah
   QA      Creative
```

### Memory Architecture

**Obsidian is the single source of truth. No exceptions.**

```
YOUR_VAULT_PATH/
├── Daily Logs/           ← primary daily memory
├── People/               ← contact notes
├── Decisions/            ← logged decisions
├── Lessons/              ← lessons learned
├── Preferences/          ← preferences the AI should know
├── Projects/             ← project status
├── Commitments/          ← tracked commitments
├── Research/             ← all research output
└── VAULT_INDEX.md        ← scan first before deep search

workspace/                ← operational layer (staging only)
├── shared-context/       ← handoffs, drafts, checkpoints
├── ops/                  ← routing, protocols, cron registry
└── MEMORY.md             ← injected operational summary (lean)
```

---

## Quickstart

### 1. Prerequisites

- OpenClaw installed and running
- Telegram bot created via BotFather
- Obsidian vault initialized
- API keys: Anthropic (required), OpenAI (optional)

### 2. Clone & Customize

```bash
git clone https://github.com/YOUR_ORG/openclaw-supercharge.git ~/openclaw-workspace
cd ~/openclaw-workspace
grep -r "YOUR_" . --include="*.md" --include="*.json" -l
```

| Token | Replace With |
|-------|-------------|
| `YOUR_USERNAME` | System username |
| `YOUR_VAULT_PATH` | Absolute path to Obsidian vault |
| `YOUR_TELEGRAM_GROUP_ID` | Telegram supergroup ID (negative number) |
| `YOUR_TELEGRAM_USER_ID` | Your personal Telegram user ID |
| `YOUR_NAME` | What agents call you |
| `YOUR_TIMEZONE` | e.g. `America/Chicago` |
| `YOUR_SITE_URL` | Website URL |

### 3. Initialize Cron Jobs

```bash
openclaw cron import ops/cron-definitions.template.json
openclaw cron list
```

### 4. First Run Checks

```bash
openclaw gateway status
openclaw sessions list
openclaw cron list
```

---

## Security Model

- **Gideon** (3:30 AM nightly): Defensive audit. Four perspectives. Letter grade A–F.
- **Abaddon** (3:45 AM nightly): Red-team offensive scan. Breach posture, exposed ports, credential leaks.

See `security/` for full protocols.
