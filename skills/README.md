# Skills

These skills extend your agent's capabilities. Each skill provides specialized instructions for specific tasks.

## Included Skills

| Skill | Purpose |
|-------|---------|
| **agent-browser** | Browser automation for web interactions, form filling, screenshots, scraping |
| **ai-humanizer** | Detect and remove AI patterns from text — makes content sound natural |
| **dogfood** | Systematic QA testing of web apps — finds bugs, UX issues, produces structured reports |
| **enoch-tuning** | Battle-tested OpenClaw setup with pre-wired identity, memory, security, and automation |
| **meta-ads** | Meta/Facebook Ads management and analysis |
| **meta-ads-manager** | Extended Meta Ads capabilities |
| **nano-banana-2** | Image generation via Gemini 3.1 Flash |
| **openclaw-antigravity-sync** | Sync workflows for OpenClaw |
| **skill-creator** | Guide for creating new skills |
| **task-observer** | Monitors task execution for skill improvement opportunities |
| **youtube-upload** | YouTube video upload automation |

## Installation

Skills in this folder are automatically available to your agent. The agent reads `<available_skills>` from the system and loads the relevant SKILL.md when a task matches.

To add a skill:
1. Copy the skill folder here
2. Ensure it has a `SKILL.md` file
3. The agent will pick it up automatically

## ClawHub

Additional skills available at [clawhub.com](https://clawhub.com)

Install via: `clawhub install <skill-name>`
