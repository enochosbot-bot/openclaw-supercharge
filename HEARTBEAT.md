# HEARTBEAT.md — Proactive Session Tasks

Run these checks at the start of each main-agent session.

## 1. Stale Dispatch Check
Read `ops/in-flight.md`. Check the Active table.
- If any row has been open for **>60 minutes**: alert your human with the task name, agent, and elapsed time. Check sessions_history for that agent.
- If Active table is empty or all rows are recent (<60min): no action needed.
- Quiet hours apply (23:00–08:00 local time) — skip alert unless task has been stale >3 hours.

## 2. Checkpoint Continuity
Read `shared-context/checkpoints/session-checkpoint.md`.
- If `status: active` and `updated_at` is older than 15 minutes: ping your human that active work may be stalled and include `next_step`.
- If `status: completed`: no action needed.
- If file is missing fields: rewrite with current task state before continuing.

## 3. Context Pressure Self-Check
Before any long operation, estimate token cost and context load.
- If context feels bloated (many long tool outputs, repeated large file reads): suggest /compact.
- Copy critical state to a file before compacting. Fresh context > degraded context.

## 4. Gateway Health
If your human reports issues or if any tool call fails with a connection error:
```bash
openclaw gateway status
```
If unhealthy: restart with `openclaw gateway restart` and verify before resuming work.
