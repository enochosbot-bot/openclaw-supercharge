# Dispatch Protocol — Hard Rules

Every task dispatch follows this loop. No exceptions.

## Before Spawning

1. **Log it** → Add row to `ops/in-flight.md` Active table
   - Task name, agent, dispatched timestamp, expected close
2. **Brief includes closing block** → Agent must:
   - Ping completion to Telegram (or primary channel)
   - Update in-flight.md (move to Completed)
   - Update checkpoint to `status: completed`

## During Execution

3. **Agent writes checkpoint** before any long operation (>2 min or >1 model call)
4. **Agent refreshes checkpoint** every 3 tool calls during long operations
5. **On error/timeout** → Agent writes `recovery-next-step` to checkpoint

## After Completion

6. **Watch for close** → If no ping within expected window:
   - Check `sessions_history` for that agent
   - Surface status to user manually
7. **Never report done** until Telegram close ping is confirmed

---

## In-Flight Table Format

```markdown
| Task | Agent | Dispatched | Expected Close | Notes |
|------|-------|------------|----------------|-------|
| Build feature X | Bezzy | 2026-02-28T16:00Z | 2026-02-28T16:30Z | PR #42 |
```

## Checkpoint Format

```yaml
status: active | completed | blocked
active_task: What's being worked on
current_step: Where we are
next_step: What comes next
updated_at: ISO timestamp
critical_ids_paths:
  - relevant file paths
  - session keys
recovery_next_step: (only if interrupted)
```

---

## Why This Matters

Without this protocol:
- Tasks get started but never finished
- Stalled work goes undetected
- Status reports miss active jobs
- Context resets lose work in progress

With this protocol:
- Every task is tracked from dispatch to close
- Stalls are detected within 15-60 minutes
- Recovery is possible from any interruption
