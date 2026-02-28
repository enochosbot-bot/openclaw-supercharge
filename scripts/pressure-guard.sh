#!/usr/bin/env bash
# pressure-guard.sh — Context + Gateway Pressure Guard
# Runs as part of Session Auto-Prune cron job
# Thresholds: CONTEXT >= 1.3MB session file, GATEWAY >= 1400MB RSS

set -euo pipefail

HANDOFF_DIR="$(dirname "$0")/../shared-context/handoffs"
CHANGELOG="$(dirname "$0")/../ops/changelog.md"

CONTEXT_THRESHOLD_KB=1331  # 1.3MB in KB
GATEWAY_THRESHOLD_MB=1400

CONTEXT_PRESSURE=false
GATEWAY_PRESSURE=false

# --- Check context pressure ---
echo "[pressure-guard] Checking session file sizes..."
while IFS= read -r line; do
    size_kb=$(echo "$line" | awk '{print $1}')
    path=$(echo "$line" | awk '{print $2}')
    if [ "$size_kb" -ge "$CONTEXT_THRESHOLD_KB" ]; then
        echo "[pressure-guard] CONTEXT_PRESSURE: $path is ${size_kb}KB"
        CONTEXT_PRESSURE=true
    fi
done < <(find ~/.openclaw/agents/*/sessions/ -name '*.jsonl' -exec du -k {} \; 2>/dev/null | sort -n)

# --- Check gateway pressure ---
echo "[pressure-guard] Checking gateway RSS..."
GATEWAY_RSS=$(openclaw gateway status 2>/dev/null | grep -i "rss\|memory" | grep -o '[0-9]*' | head -1 || echo "0")
if [ "${GATEWAY_RSS:-0}" -ge "$GATEWAY_THRESHOLD_MB" ]; then
    echo "[pressure-guard] GATEWAY_PRESSURE: Gateway RSS is ${GATEWAY_RSS}MB"
    GATEWAY_PRESSURE=true
fi

# --- If no pressure, exit silently ---
if [ "$CONTEXT_PRESSURE" = false ] && [ "$GATEWAY_PRESSURE" = false ]; then
    echo "[pressure-guard] All clear. Exiting."
    exit 0
fi

echo "[pressure-guard] Pressure detected. Starting recovery..."

# --- Save handoffs before reset ---
# (The agent running this script will handle sessions_send handoffs via its LLM context)
# This script handles the mechanical parts; the agent handles inter-agent communication.
mkdir -p "$HANDOFF_DIR"
echo "[pressure-guard] Handoff dir ready: $HANDOFF_DIR"

# --- Restart gateway ---
echo "[pressure-guard] Restarting gateway..."
openclaw gateway restart
sleep 5
openclaw gateway status

# --- Log incident ---
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
cat >> "$CHANGELOG" << LOGEOF

---
## Pressure Guard Incident — $TIMESTAMP
- Context pressure: $CONTEXT_PRESSURE
- Gateway pressure: $GATEWAY_PRESSURE
- Action: Gateway restarted
- Handoffs saved to: $HANDOFF_DIR
LOGEOF

echo "[pressure-guard] Recovery complete. Check $HANDOFF_DIR for agent handoffs."
