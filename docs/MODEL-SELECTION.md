# Model Selection Guide

Which model to use for which task.

## Quick Reference

| Task Type | Recommended Model | Why |
|-----------|------------------|-----|
| Orchestration, complex reasoning | Claude Opus | Best reasoning, worth the cost for coordination |
| Research, analysis, writing | Claude Sonnet | Good balance of quality and cost |
| Simple crons, quick checks | Claude Haiku | Cheap and fast, good enough for routine tasks |
| All coding tasks | Codex | Free during preview, optimized for code |
| Image analysis | GPT-4o | Strong vision capabilities |

## Cost vs Capability

```
Capability
    ↑
    │  ┌─────────┐
    │  │  Opus   │  $$$$ (best reasoning)
    │  └─────────┘
    │     ┌─────────┐
    │     │ Sonnet  │  $$ (good all-around)
    │     └─────────┘
    │        ┌─────────┐
    │        │ Haiku   │  $ (fast + cheap)
    │        └─────────┘
    │           ┌─────────┐
    │           │ Codex   │  FREE (code only)
    │           └─────────┘
    └──────────────────────────→ Cost
```

## Agent-Model Mapping

| Agent | Model | Rationale |
|-------|-------|-----------|
| Main (orchestrator) | Opus | Needs best reasoning for coordination |
| Researcher | Sonnet | Balances depth with cost |
| Scribe (writer) | Sonnet | Good writing quality |
| Coder | Codex | Free, code-optimized |
| Observer (security) | Codex or Sonnet | Systematic checks don't need Opus |
| QA | Sonnet | Needs good judgment for validation |

## Cron Model Selection

Most crons don't need expensive models:

| Cron Type | Model | Why |
|-----------|-------|-----|
| Session watchdog | Haiku | Simple file checks |
| Pressure guard | Haiku | Threshold checks |
| Quick security scan | Sonnet | Needs some judgment |
| Deep security audit | Sonnet | Thorough but not complex |
| Morning brief | Sonnet | Summarization task |
| Mission Pulse | Sonnet | Dispatch decisions |
| Nightly maintenance | Haiku | Routine cleanup |

## When to Upgrade

Use a more expensive model when:
- Task requires multi-step reasoning
- Errors are costly (external comms, deployments)
- Quality is user-facing (content, reports)
- Coordination across multiple agents

## When to Downgrade

Use a cheaper model when:
- Task is routine/repetitive
- Output is internal only
- Simple yes/no decisions
- File operations and checks

## Overriding Models

### Per-agent (openclaw.json)
```json
{
  "agents": {
    "main": { "model": "anthropic/claude-opus-4-5" },
    "coder": { "model": "gpt-5.3-codex" }
  }
}
```

### Per-cron
```json
{
  "payload": {
    "model": "anthropic/claude-haiku-4-5"
  }
}
```

### Per-session
In chat: `/model sonnet`
