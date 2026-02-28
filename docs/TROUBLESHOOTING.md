# Troubleshooting Guide

Common issues and how to fix them.

## Gateway Issues

### Gateway won't start
```bash
# Check status
openclaw gateway status

# Check if port is in use
lsof -i :3000

# Kill orphaned process and restart
openclaw gateway stop
pkill -f "openclaw"
openclaw gateway start
```

### Gateway eating memory
Symptoms: Slow responses, high RSS in `openclaw gateway status`

Fix:
```bash
# Restart gateway
openclaw gateway restart

# If persistent, check for bloated sessions
find ~/.openclaw/agents -name "*.jsonl" -size +1M
```

### "Gateway not responding" errors
```bash
# Check if running
openclaw gateway status

# Check logs
tail -100 ~/.openclaw/logs/gateway.log

# Nuclear option: full restart
openclaw gateway stop
sleep 2
openclaw gateway start
```

## Session Issues

### Context getting stale/confused
```bash
# Compact current session
# In chat: /compact

# Or start fresh
# In chat: /new
```

### Session files growing too large
The watchdog cron handles this automatically. Manual fix:
```bash
# Archive large sessions
find ~/.openclaw/agents/*/sessions -name "*.jsonl" -size +500k -exec mv {} {}.archive \;
```

### Agent not responding
```bash
# Check if session exists
openclaw sessions list

# Force new session
openclaw sessions reset --agent main
```

## Telegram Issues

### Bot not responding
1. Check bot token is valid
2. Verify bot is added to chat/group
3. Check `openclaw gateway status` shows Telegram connected

```bash
# Test Telegram connection
openclaw channels test telegram
```

### Messages not delivering to topics
- Ensure group is in forum mode
- Verify topic IDs in config match actual thread IDs
- Check bot has permission to post in topics

### Duplicate messages
Usually caused by `streaming: partial` setting. Fix:
```json
{
  "channels": {
    "telegram": {
      "streaming": "off"
    }
  }
}
```

## Cron Issues

### Crons not running
```bash
# List crons and check status
openclaw cron list

# Check for errors
openclaw cron list --verbose | grep -i error

# Re-enable a disabled cron
openclaw cron enable <cron-id>
```

### Cron running but no output
Check the cron's delivery mode:
```bash
openclaw cron show <cron-id>
```
- `mode: none` = silent unless errors
- `mode: announce` = posts to channel

### Cron timing wrong
Verify timezone in cron definition matches your system:
```json
{
  "schedule": {
    "tz": "America/Chicago"
  }
}
```

## API Issues

### "Insufficient credits" / rate limits
- Check provider dashboard for current usage
- Verify API key is valid and has credits
- Consider switching to cheaper model for that task

### Auth errors after restart
Environment variables may not be loaded:
```bash
# Reload shell config
source ~/.zshrc

# Or restart gateway (picks up env)
openclaw gateway restart
```

### Wrong model being used
Check model override in:
1. Agent config in `openclaw.json`
2. Cron job definition
3. Session-level override (`/model` command)

## Obsidian Issues

### Agent not finding memory
1. Verify vault path in agent's workspace files
2. Check path is absolute, not relative
3. Ensure agent has read permissions

### Research not syncing to Obsidian
The agent should copy research to Obsidian automatically. If not:
1. Check `SOUL.md` has the Obsidian canon rule
2. Verify Obsidian path in workspace files
3. Manually trigger: "Copy recent research to Obsidian"

## Performance Issues

### Slow responses
1. Check model — Opus is slower than Sonnet
2. Check context size — large sessions slow things down
3. Check gateway memory — restart if high RSS

### High costs
1. Review which model each agent uses
2. Check cron frequency — reduce if too often
3. Use Haiku for simple tasks

## Nuclear Options

### Full reset (keeps config)
```bash
openclaw gateway stop
rm -rf ~/.openclaw/agents/*/sessions/*.jsonl
openclaw gateway start
```

### Complete reinstall (loses sessions)
```bash
openclaw gateway stop
rm -rf ~/.openclaw/agents/*/sessions/
openclaw gateway start
```

## Getting Help

1. Check logs: `~/.openclaw/logs/`
2. Run diagnostics: `openclaw status`
3. Discord: [discord.com/invite/clawd](https://discord.com/invite/clawd)
4. Docs: [docs.openclaw.ai](https://docs.openclaw.ai)
