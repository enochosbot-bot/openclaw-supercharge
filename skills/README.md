# Skills (63 total)

Full production skill loadout. Each skill provides specialized instructions for specific tasks.

## Categories

### Productivity & Notes
| Skill | Purpose |
|-------|---------|
| 1password | 1Password CLI integration for secrets management |
| apple-notes | Manage Apple Notes via `memo` CLI |
| apple-reminders | Manage Apple Reminders via `remindctl` CLI |
| bear-notes | Create, search, manage Bear notes via `grizzly` CLI |
| things-mac | Manage Things 3 tasks via `things` CLI |
| notion | Notion integration |
| trello | Trello board management |
| obsidian | Obsidian vault operations |

### Communication
| Skill | Purpose |
|-------|---------|
| himalaya | CLI email via IMAP/SMTP |
| imsg | iMessage integration |
| discord | Discord bot operations |
| slack | Slack integration |
| bluebubbles | BlueBubbles iMessage server |
| wacli | WhatsApp CLI |

### Research & Information
| Skill | Purpose |
|-------|---------|
| summarize | Summarize URLs, podcasts, local files |
| oracle | Prompt + file bundling for LLM queries |
| gemini | Gemini CLI for Q&A, summaries, generation |
| xurl | URL expansion and metadata |
| blogwatcher | Monitor blogs/RSS for updates |
| goplaces | Google Places API queries |
| weather | Weather via wttr.in or Open-Meteo |

### GitHub & Development
| Skill | Purpose |
|-------|---------|
| github | GitHub operations via `gh` CLI |
| gh-issues | Fetch issues, spawn agents for fixes, open PRs |
| coding-agent | Delegate to Codex/Claude Code/Pi agents |
| clawhub | Search, install, publish skills from clawhub.com |
| mcporter | MCP server management and tool calling |

### Media & Images
| Skill | Purpose |
|-------|---------|
| video-frames | Extract frames/clips from videos via ffmpeg |
| openai-whisper | Local speech-to-text (no API) |
| openai-whisper-api | Transcribe via OpenAI Whisper API |
| nano-banana-2 | Gemini 3.1 Flash image generation |
| nano-banana-pro | Gemini 3 Pro image generation |
| openai-image-gen | Batch image generation via OpenAI |
| gifgrep | Search and create GIFs |
| camsnap | Capture from RTSP/ONVIF cameras |
| canvas | Control node canvases |

### Smart Home
| Skill | Purpose |
|-------|---------|
| openhue | Control Philips Hue lights/scenes |
| sonoscli | Control Sonos speakers |
| blucli | BluOS speaker control |
| eightctl | Eight Sleep pod control |

### Content & Audio
| Skill | Purpose |
|-------|---------|
| ai-humanizer | Remove AI patterns from text |
| sag | ElevenLabs TTS |
| sherpa-onnx-tts | Local TTS via Sherpa-ONNX |
| voice-call | Voice call handling |
| spotify-player | Spotify playback control |
| songsee | Song identification |
| youtube-upload | YouTube video uploads |

### Documents
| Skill | Purpose |
|-------|---------|
| nano-pdf | Edit PDFs with natural language |
| docx | Document handling |
| peekaboo | Capture/automate macOS UI |

### Meta & Operations
| Skill | Purpose |
|-------|---------|
| enoch-tuning | Pre-wired production OpenClaw setup |
| task-observer | Monitor tasks for skill opportunities |
| skill-creator | Guide for creating new skills |
| dogfood | Systematic QA/bug hunting |
| agent-browser | Browser automation |
| healthcheck | Host security hardening |
| session-logs | Search/analyze session logs |
| model-usage | Per-model usage/cost summaries |

### Other
| Skill | Purpose |
|-------|---------|
| gog | Google Workspace (Gmail, Calendar, Drive, etc.) |
| meta-ads | Meta/Facebook Ads management |
| meta-ads-manager | Extended Meta Ads capabilities |
| ordercli | Order management |
| tmux | Terminal multiplexer operations |
| openclaw-antigravity-sync | Sync workflows |

## Installation

Skills in this folder are automatically available. The agent loads the relevant `SKILL.md` when a task matches.

## Adding More Skills

```bash
# From ClawHub
clawhub install <skill-name>

# Manual
cp -r /path/to/skill skills/
```
