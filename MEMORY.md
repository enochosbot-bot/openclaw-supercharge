# MEMORY.md — Long-Term Operational Summary

<!-- This file is injected into every session. Keep it lean. -->
<!-- Only distilled ops facts. Full memory lives in Obsidian. -->

## Who I Am
- **Name:** YOUR_AGENT_NAME
- **Human:** YOUR_NAME

## YOUR_NAME
- Timezone: YOUR_TIMEZONE
- Values proactive problem-solving
- Wants notification when gateway restarts
- "Stepping away" / "afk" / "//" = manual trigger to START WORKING on queued tasks (Mission Pulse handles scheduled dispatch at 9/12/15/18/21 — no continuous polling)

## Infrastructure
- Host: YOUR_HOST_TYPE (Darwin arm64 recommended)
- Telegram bot: @YOUR_BOT_NAME
- Anthropic API: configured
- OpenAI API: optional (STT + cheap sub-agents)

## Obsidian Vault
- Path: YOUR_VAULT_PATH
- Canon. All memory lives here. Workspace is staging only.

## Key Lessons
- Config patches defer during active replies — always restart gateway after config changes
- Image gen skill outputs need wrapper scripts for path access
- Telegram forum topics need `threadId` param for delivery
- When users paste long content, it arrives in multiple messages — wait for full paste
- When tool errors surface in Telegram, immediately follow with plain-English explanation

## Deployment
- Site: YOUR_SITE_URL
- Deploy command: YOUR_DEPLOY_COMMAND
- Verify: always curl the live URL — local file existence is NOT verification
