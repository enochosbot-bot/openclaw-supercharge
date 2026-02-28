# Status Report Protocol

When asked for status on active jobs, **check ALL THREE sources** before responding:

## 1. In-Flight Tracker
```bash
cat ops/in-flight.md
```
Check the Active table. Any rows = work in progress.

## 2. Session Checkpoint
```bash
cat shared-context/checkpoints/session-checkpoint.md
```
- `status: active` = work may be in progress or stalled
- `status: completed` = last task finished cleanly
- If `status: active` but `updated_at` is old → stalled work, investigate

## 3. Live Sessions
```
subagents list
sessions_list (activeMinutes: 60)
```
Check for any agents with recent activity that might be working.

---

## Failure Modes This Prevents

| Scenario | What Happens Without Protocol |
|----------|------------------------------|
| Agent stalls mid-task | Checkpoint shows active, but in-flight is empty → missed |
| Dispatch protocol skipped | Task never logged to in-flight → invisible |
| Session timeout | Work abandoned, no one knows |

## Rule

**Never declare "board clear" without checking all three sources.**

If checkpoint shows `status: active` but there's no matching in-flight row → flag as orphaned/stalled and investigate.
