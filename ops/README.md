# Operational Protocols

This folder contains the hard rules and protocols that keep the agent system running reliably.

## Core Protocols

| File | Purpose |
|------|---------|
| `dispatch-protocol.md` | **Required reading.** How to dispatch tasks, track them, close them. |
| `status-report-protocol.md` | Three-source check before reporting status. Never miss active work. |
| `dispatch-routing.md` | Which agent handles what. Routing rules. |
| `in-flight.md` | Live tracker for active dispatched tasks. |
| `verification-protocol.md` | How to verify work is actually done (not just "committed"). |

## Agent Management

| File | Purpose |
|------|---------|
| `agent-boundaries.md` | What each agent can/cannot do. Explicit limits. |
| `parallelization-rules.md` | When to use single agent vs parallel dispatch. |
| `notification-routing.md` | Where different message types go. |

## Cross-Network Collaboration

| File | Purpose |
|------|---------|
| `agent-network-cron.md` | **New.** Connect to shared GitHub task queue for multi-agent collaboration. |

## Content & Review

| File | Purpose |
|------|---------|
| `content-review-protocol.md` | How Solomon reviews content before publish. |
| `production-queue.md` | Content pipeline queue management. |

## Maintenance

| File | Purpose |
|------|---------|
| `pruning-protocol.md` | Session cleanup and log rotation. |
| `improvement-queue.md` | Tracked improvements and tech debt. |
| `tool-failure-log.md` | Log of tool failures for pattern detection. |
| `DEPRECATION-LOG.md` | Deprecated patterns and their replacements. |

## Templates

| File | Purpose |
|------|---------|
| `cron-definitions.template.json` | Example cron job definitions. |

---

## Quick Start

1. Read `dispatch-protocol.md` first — this is the foundation
2. Skim `status-report-protocol.md` — prevents missed work
3. If collaborating across agents/people: read `agent-network-cron.md`
