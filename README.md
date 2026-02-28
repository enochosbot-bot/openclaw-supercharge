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
- **63 production skills** included (full loadout — see below)

---

## Included Skills (63)

| Category | Skills |
|----------|--------|
| **Productivity** | 1password, apple-notes, apple-reminders, bear-notes, things-mac, notion, trello, obsidian |
| **Communication** | himalaya (email), imsg, discord, slack, bluebubbles, wacli |
| **Research** | summarize, oracle, gemini, xurl, blogwatcher, goplaces, weather |
| **GitHub/Dev** | github, gh-issues, coding-agent, clawhub, mcporter |
| **Media** | video-frames, openai-whisper, openai-whisper-api, nano-banana-2, nano-banana-pro, openai-image-gen, gifgrep, camsnap, canvas |
| **Smart Home** | openhue, sonoscli, blucli, eightctl |
| **Content** | ai-humanizer, sag (TTS), sherpa-onnx-tts, voice-call, spotify-player, songsee, youtube-upload |
| **Documents** | nano-pdf, docx, peekaboo |
| **Meta/Ops** | enoch-tuning, task-observer, skill-creator, dogfood, agent-browser, healthcheck, session-logs, model-usage |
| **Other** | gog (Google), meta-ads, ordercli, tmux, openclaw-antigravity-sync |

See `skills/README.md` for descriptions and `skills/<name>/SKILL.md` for each skill's documentation.

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

---

## Documentation

| Doc | Purpose |
|-----|---------|
| [ENV-CHECKLIST.md](docs/ENV-CHECKLIST.md) | Required and optional environment variables |
| [AGENT-CONFIG-EXAMPLE.md](docs/AGENT-CONFIG-EXAMPLE.md) | Multi-agent configuration in openclaw.json |
| [OBSIDIAN-VAULT-TEMPLATE.md](docs/OBSIDIAN-VAULT-TEMPLATE.md) | Obsidian directory structure setup |
| [COST-ESTIMATION.md](docs/COST-ESTIMATION.md) | Realistic API costs by usage level |
| [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) | Common issues and fixes |
| [MIGRATION.md](docs/MIGRATION.md) | Adopting this setup on existing OpenClaw |
