# Environment Variables Checklist

Required and optional environment variables for a full OpenClaw setup.

## Required

| Variable | Purpose | Where to Get |
|----------|---------|--------------|
| `ANTHROPIC_API_KEY` | Claude models (main agent) | [console.anthropic.com](https://console.anthropic.com) |

## Recommended

| Variable | Purpose | Where to Get |
|----------|---------|--------------|
| `OPENAI_API_KEY` | GPT models, Whisper, TTS, DALL-E | [platform.openai.com](https://platform.openai.com) |
| `TELEGRAM_BOT_TOKEN` | Telegram bot interface | [@BotFather](https://t.me/BotFather) |

## Optional (by feature)

### Voice & Audio
| Variable | Purpose |
|----------|---------|
| `ELEVENLABS_API_KEY` | ElevenLabs TTS |
| `DEEPGRAM_API_KEY` | Deepgram STT |

### Image Generation
| Variable | Purpose |
|----------|---------|
| `GOOGLE_API_KEY` | Gemini image generation (nano-banana) |

### Smart Home
| Variable | Purpose |
|----------|---------|
| `HUE_BRIDGE_IP` | Philips Hue control |
| `EIGHT_SLEEP_EMAIL` | Eight Sleep pod |
| `EIGHT_SLEEP_PASSWORD` | Eight Sleep pod |

### Development
| Variable | Purpose |
|----------|---------|
| `GITHUB_TOKEN` | GitHub CLI operations |

### Communication
| Variable | Purpose |
|----------|---------|
| `SLACK_BOT_TOKEN` | Slack integration |
| `DISCORD_BOT_TOKEN` | Discord integration |

## Setup

Add to your shell profile (`~/.zshrc` or `~/.bashrc`):

```bash
# Required
export ANTHROPIC_API_KEY="sk-ant-..."

# Recommended
export OPENAI_API_KEY="sk-..."
export TELEGRAM_BOT_TOKEN="123456:ABC..."

# Optional
export ELEVENLABS_API_KEY="..."
export GOOGLE_API_KEY="..."
```

Then reload: `source ~/.zshrc`

## Security Notes

- Never commit API keys to git
- Use a secrets manager for production (1Password CLI, etc.)
- Rotate keys periodically
- Monitor usage dashboards for anomalies
