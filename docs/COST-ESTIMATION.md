# Cost Estimation Guide

Realistic API costs for running this setup.

## Quick Reference

| Usage Level | Daily Cost | Monthly Cost |
|-------------|------------|--------------|
| Light (few interactions) | $2-5 | $60-150 |
| Medium (regular use) | $5-15 | $150-450 |
| Heavy (constant use + agents) | $15-30 | $450-900 |

## Cost Breakdown by Component

### Main Agent (Claude Opus)
- **Per interaction**: $0.01-0.05
- **Complex task**: $0.10-0.30
- This is your biggest cost driver

### Sub-Agents (Claude Sonnet)
- **Per interaction**: $0.002-0.01
- **Research task**: $0.05-0.15
- Much cheaper than Opus

### Coder Agent (Codex)
- **Cost**: FREE (during preview)
- Use Codex for code tasks to save money

### Nightly Crons
| Job | Estimated Cost |
|-----|----------------|
| Nightly Maintenance | $0.10-0.20 |
| Gideon Deep Audit | $0.15-0.25 |
| Abaddon Red Team | $0.15-0.25 |
| Morning Brief | $0.05-0.10 |
| **Total nightly** | **$0.50-1.00** |

### Daytime Crons
| Job | Estimated Cost |
|-----|----------------|
| Mission Pulse (5x/day) | $0.10-0.25 each |
| QA Sweep (3x/day) | $0.05-0.10 each |
| Quick Scan | $0.02-0.05 |
| **Total daytime** | **$0.75-1.50** |

## Cost Optimization Tips

### 1. Use the Right Model for the Job
- **Opus**: Orchestration, complex reasoning, sensitive comms
- **Sonnet**: Research, writing, analysis
- **Haiku**: Quick checks, simple crons
- **Codex**: All coding tasks (free)

### 2. Batch Operations
Don't make 10 API calls when 1 will do. Batch similar tasks.

### 3. Use Haiku for Crons
Most crons don't need Opus. Configure with `"model": "anthropic/claude-haiku-4-5"`.

### 4. Skip Silent Crons
Configure crons to stay silent when nothing needs attention. Don't generate output just to say "all clear."

### 5. Cache Context
Use `MEMORY.md` to keep key info readily available instead of searching every time.

## Monitoring Costs

### Anthropic Console
[console.anthropic.com](https://console.anthropic.com)
- Real-time usage graphs
- Per-model breakdown
- Set spend alerts

### OpenAI Dashboard
[platform.openai.com/usage](https://platform.openai.com/usage)
- Daily usage charts
- Cost by model
- Rate limit status

### In-App Tracking
Run the cost report script:
```bash
python3 scripts/cost-report.py
```

## Budget Alerts

Set up alerts in your provider dashboards:
- **Anthropic**: Settings → Usage → Set monthly limit
- **OpenAI**: Settings → Limits → Set hard/soft caps

Recommended:
- Soft limit at 80% of budget (warning)
- Hard limit at 100% (stops requests)

## Real-World Example

A typical workday:
```
Morning brief generation:        $0.08
3 research tasks (Sonnet):       $0.30
5 code changes (Codex):          $0.00
Main agent interactions (10):    $0.40
Mission Pulse runs (5):          $0.60
QA sweeps (3):                   $0.20
Evening wrap-up:                 $0.10
-----------------------------------
Day total:                       ~$1.70
```

Heavy day with complex work:
```
Morning brief:                   $0.10
Deep research project:           $0.80
Multiple sub-agent dispatches:   $0.60
Main agent (30 interactions):    $1.50
Code buildout (Codex):           $0.00
Content review pipeline:         $0.40
Security audit:                  $0.20
-----------------------------------
Day total:                       ~$3.60
```
