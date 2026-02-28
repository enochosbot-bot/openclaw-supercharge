#!/bin/bash
# Pressure Guard — monitors context window size and gateway memory
# Triggers auto-save/reset/resume when thresholds are hit
# Run via cron every 2 hours

# CUSTOMIZE THESE
WORKSPACE="$HOME/.openclaw/workspace"
AGENTS_DIR="$HOME/.openclaw/agents"

# Thresholds
CONTEXT_THRESHOLD_MB=1.3       # Session JSONL size in MB
GATEWAY_RSS_THRESHOLD_MB=1400  # Gateway memory in MB

LOG="/tmp/pressure-guard.log"
HANDOFFS_DIR="$WORKSPACE/shared-context/handoffs"
CHANGELOG="$WORKSPACE/ops/changelog.md"

echo "[$(date)] Pressure guard starting" > "$LOG"

# Check session pressure (largest JSONL files)
PRESSURE_HIT=false
LARGEST=$(find "$AGENTS_DIR" -name '*.jsonl' -size +${CONTEXT_THRESHOLD_MB}M 2>/dev/null | head -1)

if [ -n "$LARGEST" ]; then
  SIZE=$(ls -lh "$LARGEST" | awk '{print $5}')
  echo "CONTEXT_PRESSURE: $LARGEST is $SIZE" >> "$LOG"
  PRESSURE_HIT=true
fi

# Check gateway memory
GATEWAY_RSS=$(openclaw gateway status 2>/dev/null | grep -i rss | grep -oE '[0-9]+' | head -1)
if [ -n "$GATEWAY_RSS" ] && [ "$GATEWAY_RSS" -gt "$GATEWAY_RSS_THRESHOLD_MB" ]; then
  echo "GATEWAY_PRESSURE: RSS is ${GATEWAY_RSS}MB" >> "$LOG"
  PRESSURE_HIT=true
fi

if [ "$PRESSURE_HIT" = true ]; then
  echo "[$(date)] Pressure detected — initiating recovery" >> "$LOG"
  
  # 1. Save handoffs from active agents
  mkdir -p "$HANDOFFS_DIR"
  # Note: Full implementation uses sessions_send to request handoffs
  # from each active agent before restart.
  
  # 2. Restart gateway
  echo "Restarting gateway..." >> "$LOG"
  openclaw gateway restart >> "$LOG" 2>&1
  sleep 5
  
  # 3. Verify gateway health
  STATUS=$(openclaw gateway status 2>/dev/null | head -1)
  echo "Gateway status after restart: $STATUS" >> "$LOG"
  
  # 4. Log to changelog
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
  echo "" >> "$CHANGELOG"
  echo "### [$TIMESTAMP] Pressure Guard Recovery" >> "$CHANGELOG"
  echo "- Trigger: ${LARGEST:-gateway RSS $GATEWAY_RSS MB}" >> "$CHANGELOG"
  echo "- Action: Gateway restart" >> "$CHANGELOG"
  echo "- Status: $STATUS" >> "$CHANGELOG"
  
  echo "[$(date)] Recovery complete" >> "$LOG"
else
  echo "[$(date)] No pressure detected. All clear." >> "$LOG"
fi
