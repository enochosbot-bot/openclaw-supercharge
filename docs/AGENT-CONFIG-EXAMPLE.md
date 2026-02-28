# Multi-Agent Configuration Example

How to configure multiple agents in `~/.openclaw/openclaw.json`.

## Basic Structure

```json
{
  "agents": {
    "main": {
      "name": "YourMainAgent",
      "model": "anthropic/claude-opus-4-5",
      "workspace": "~/.openclaw/workspace"
    },
    "researcher": {
      "name": "Researcher",
      "model": "anthropic/claude-sonnet-4-6",
      "workspace": "~/.openclaw/workspace-researcher"
    },
    "scribe": {
      "name": "Scribe", 
      "model": "anthropic/claude-sonnet-4-6",
      "workspace": "~/.openclaw/workspace-scribe"
    },
    "coder": {
      "name": "Coder",
      "model": "gpt-5.3-codex",
      "workspace": "~/.openclaw/workspace-coder"
    },
    "observer": {
      "name": "Observer",
      "model": "gpt-5.3-codex",
      "workspace": "~/.openclaw/agents/observer/workspace"
    },
    "basher": {
      "name": "QA",
      "model": "anthropic/claude-sonnet-4-6",
      "workspace": "~/.openclaw/workspace"
    }
  }
}
```

## Agent Roles

| Agent ID | Role | Model Choice | Why |
|----------|------|--------------|-----|
| `main` | Command center, orchestration | Opus | Best reasoning for coordination |
| `researcher` | Deep research, analysis | Sonnet | Good balance of capability/cost |
| `scribe` | Writing, content | Sonnet | Strong writing ability |
| `coder` | Code, scripts, builds | Codex | Free, good at code |
| `observer` | Security audits | Codex | Systematic checking |
| `basher` | QA, testing | Sonnet | Thorough validation |

## Workspace Isolation

Each agent can have its own workspace:
- **Shared workspace**: Agents collaborate on same files
- **Isolated workspace**: Agent has own space, uses `shared-context/` for handoffs

Recommended pattern:
- Main agent: shared workspace (sees everything)
- Sub-agents: isolated workspaces with symlink to `shared-context/`

```bash
# Create isolated workspace with shared context link
mkdir -p ~/.openclaw/workspace-scribe
ln -s ~/.openclaw/workspace/shared-context ~/.openclaw/workspace-scribe/shared-context
```

## Telegram Topic Routing

Route different agents to different forum topics:

```json
{
  "channels": {
    "telegram": {
      "enabled": true,
      "token": "YOUR_BOT_TOKEN",
      "allowedUsers": ["YOUR_USER_ID"],
      "topics": {
        "main": "1",
        "researcher": "65",
        "observer": "3061",
        "creative": "75"
      }
    }
  }
}
```

## Subagent Allowlists

Control which agents can spawn which sub-agents:

```json
{
  "agents": {
    "main": {
      "subagents": {
        "allowed": ["researcher", "scribe", "coder", "observer", "basher"]
      }
    },
    "researcher": {
      "subagents": {
        "allowed": []
      }
    }
  }
}
```

## Model Aliases

Define shortcuts for model names:

```json
{
  "modelAliases": {
    "opus": "anthropic/claude-opus-4-5",
    "sonnet": "anthropic/claude-sonnet-4-6",
    "haiku": "anthropic/claude-haiku-4-5",
    "codex": "gpt-5.3-codex"
  }
}
```
