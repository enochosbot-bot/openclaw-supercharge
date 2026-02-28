# Production Queue

Ready-to-ship work items. Mission Pulse pulls from here during idle cycles.

---

## Format

```markdown
### [ID] [Title]
**Priority:** P0/P1/P2
**Owner:** [agent]
**Status:** queued | in-progress | blocked | done
**Description:** [what needs to happen]
**Acceptance:** [how to know it's done]
**Notes:** [context, blockers, links]
```

---

## Queue

<!-- Add items below. Mission Pulse dispatches highest priority first. -->

_Queue is empty. Add items as they become ready._

---

## Rules

1. **Only ready work goes here** — if it needs research or decisions first, it's not ready
2. **One owner per item** — no "anyone can do this"
3. **Clear acceptance criteria** — vague items don't get done
4. **P0 = blocking something** — gets dispatched immediately
5. **Review weekly** — prune stale items, demote if not actually urgent

---

## Priority Definitions

| Priority | Meaning | Dispatch |
|----------|---------|----------|
| P0 | Blocking active work | Next Mission Pulse |
| P1 | Important, this week | When no P0s exist |
| P2 | Nice to have | When queue is light |

---

## Flow

```
Idea → Backlog (with research/planning)
         ↓
      Ready? → Production Queue (clear spec)
                    ↓
               Mission Pulse dispatches
                    ↓
               Agent executes
                    ↓
               QA validates → Done
```

---

## Adding Items

Before adding to production queue, verify:
- [ ] Task is fully specified (not vague)
- [ ] Acceptance criteria are testable
- [ ] Owner agent is clear
- [ ] Dependencies are resolved
- [ ] Estimated effort is reasonable for one dispatch
