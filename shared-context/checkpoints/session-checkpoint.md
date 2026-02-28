# session-checkpoint.md — Active Task Checkpoint

<!-- Main agent writes/updates this before and during any long operation. -->
<!-- Goal: any future session can resume without loss. -->

---

status: idle
updated_at: YYYY-MM-DDTHH:MM:SSZ

## Active Task
_(none)_

## Current Step
_(none)_

## Next Step
_(none)_

## Critical IDs / Paths
_(none)_

## Recovery Next Step
_(if interrupted, what should the next session do first?)_

---

## Checkpoint Format Reference

When updating this file during active work:

```markdown
status: active
updated_at: 2026-01-15T14:32:00Z

## Active Task
Build landing page for product X

## Current Step
Step 3/5 — Bezzy is writing the hero section. Output path: shared-context/drafts/landing-page.html

## Next Step
Step 4 — Solomon reviews draft (CONTENT_REVIEW handoff)

## Critical IDs / Paths
- Draft: shared-context/drafts/landing-page.html
- In-flight row: "Build landing page" | Bezzy | dispatched 14:15Z
- Session: coder agent, session ID: abc-123

## Recovery Next Step
If interrupted: read draft at above path, check if complete. If complete, proceed to Solomon review handoff.
```
