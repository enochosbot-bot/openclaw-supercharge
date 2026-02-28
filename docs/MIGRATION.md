# Migration Guide

How to adopt this setup if you already have OpenClaw running.

## Before You Start

**Backup everything:**
```bash
# Backup current workspace
cp -r ~/.openclaw/workspace ~/.openclaw/workspace-backup-$(date +%Y%m%d)

# Backup config
cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.backup
```

## Migration Paths

### Path A: Fresh Start (Recommended)

Best if your current setup is minimal or you want a clean slate.

1. **Stop gateway**
   ```bash
   openclaw gateway stop
   ```

2. **Archive old workspace**
   ```bash
   mv ~/.openclaw/workspace ~/.openclaw/workspace-old
   ```

3. **Clone this repo as new workspace**
   ```bash
   git clone https://github.com/YOUR_ORG/openclaw-supercharge ~/.openclaw/workspace
   ```

4. **Copy over any files you want to keep**
   ```bash
   # Example: keep your memory
   cp ~/.openclaw/workspace-old/MEMORY.md ~/.openclaw/workspace/
   ```

5. **Customize templates**
   - Fill in `USER.md` with your info
   - Fill in `IDENTITY.md` with your agent's identity
   - Update paths in scripts and crons

6. **Import crons**
   ```bash
   openclaw cron import ~/.openclaw/workspace/ops/cron-definitions.template.json
   ```

7. **Start gateway**
   ```bash
   openclaw gateway start
   ```

### Path B: Incremental Adoption

Best if you have significant customization you want to keep.

1. **Copy specific components**
   ```bash
   # Get the repo somewhere
   git clone https://github.com/YOUR_ORG/openclaw-supercharge /tmp/supercharge
   
   # Copy what you want
   cp /tmp/supercharge/ops/* ~/.openclaw/workspace/ops/
   cp /tmp/supercharge/security/* ~/.openclaw/workspace/security/
   cp -r /tmp/supercharge/skills/* ~/.openclaw/workspace/skills/
   ```

2. **Merge workspace files**
   
   Compare and merge:
   - `SOUL.md` — add rules you're missing
   - `AGENTS.md` — adopt dispatch loop if not using
   - `HEARTBEAT.md` — add health checks

3. **Add crons selectively**
   
   Review `ops/cron-definitions.template.json` and import only what you want:
   ```bash
   # Import single cron by copying JSON and using:
   openclaw cron create --from-json '<json>'
   ```

4. **Set up Obsidian structure**
   
   Follow `docs/OBSIDIAN-VAULT-TEMPLATE.md` to create the directory structure, then update your agent files to point to it.

## Key Files to Update

After migration, search and replace these tokens:

| Token | Replace With |
|-------|--------------|
| `YOUR_USERNAME` | Your system username |
| `YOUR_VAULT_PATH` | Absolute path to Obsidian vault |
| `YOUR_TELEGRAM_GROUP_ID` | Telegram supergroup ID |
| `YOUR_TELEGRAM_USER_ID` | Your Telegram user ID |
| `YOUR_NAME` | Your name |
| `YOUR_TIMEZONE` | e.g., `America/Chicago` |

```bash
# Find all files needing updates
grep -r "YOUR_" ~/.openclaw/workspace --include="*.md" --include="*.json" -l
```

## Cron Migration

### Export existing crons
```bash
openclaw cron list --json > my-crons-backup.json
```

### Compare with template
Review `ops/cron-definitions.template.json` against your current crons. Add any you're missing.

### Update existing crons
If you have similar crons but with different prompts/schedules, update them:
```bash
openclaw cron update <cron-id> --message "new prompt"
openclaw cron update <cron-id> --schedule "0 9 * * *"
```

## Agent Migration

If you have existing agents:

1. **Keep agent IDs consistent** — The templates use `main`, `researcher`, `scribe`, `coder`, `observer`, `basher`

2. **Update agent workspaces** — Point agents to appropriate workspace paths

3. **Add shared-context symlinks** — For isolated workspaces:
   ```bash
   ln -s ~/.openclaw/workspace/shared-context ~/.openclaw/workspace-scribe/shared-context
   ```

## Skill Migration

Skills from this package go in `~/.openclaw/workspace/skills/` or the OpenClaw skills directory.

```bash
# Copy skills
cp -r /path/to/supercharge/skills/* ~/.openclaw/workspace/skills/
```

No additional configuration needed — skills are auto-discovered.

## Verification Checklist

After migration, verify:

- [ ] `openclaw gateway status` shows healthy
- [ ] `openclaw cron list` shows expected jobs
- [ ] `openclaw sessions list` works
- [ ] Send a test message via Telegram
- [ ] Check one cron runs correctly
- [ ] Verify Obsidian path is accessible
- [ ] Test a sub-agent dispatch

## Rollback

If something breaks:

```bash
# Stop gateway
openclaw gateway stop

# Restore backup
rm -rf ~/.openclaw/workspace
mv ~/.openclaw/workspace-backup-YYYYMMDD ~/.openclaw/workspace
cp ~/.openclaw/openclaw.json.backup ~/.openclaw/openclaw.json

# Restart
openclaw gateway start
```
