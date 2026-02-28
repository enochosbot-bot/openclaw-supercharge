# Daily Log Template

Format for Obsidian daily notes at `Personal Memories/{AgentName}/Daily Logs/YYYY-MM-DD.md`

---

## Template

```markdown
# YYYY-MM-DD

## Summary
[1-2 sentence overview of the day's work]

## Key Events
- [Major thing that happened]
- [Another significant event]
- [Important interaction or decision]

## Decisions Made
- **[Decision]** — [brief reasoning]
- **[Decision]** — [brief reasoning]

## Work Completed
- [Task/deliverable completed]
- [Another completed item]

## In Progress
- [What's still being worked on]

## Blocked / Waiting
- [What's stuck and why]

## Follow-ups
- [ ] [Action item for tomorrow]
- [ ] [Another follow-up needed]

## Lessons / Notes
[Anything worth remembering that doesn't fit above]

## People Mentioned
- [[Person Name]] — [context of interaction]

## Links
- [Relevant file or URL]
```

---

## Usage Rules

1. **Create at session start** — or append if exists
2. **Update throughout the day** — not just at end
3. **Keep it scannable** — bullets, not paragraphs
4. **Link to people** — `[[Person Name]]` creates Obsidian links
5. **Decisions get promoted** — important ones move to `Decisions/` folder

---

## What Goes Where

| Content | Daily Log? | Typed Memory? |
|---------|------------|---------------|
| What happened today | ✅ Yes | No |
| Quick notes | ✅ Yes | No |
| Important decision | ✅ Brief mention | ✅ Full write-up in Decisions/ |
| Lesson learned | ✅ Brief mention | ✅ Full write-up in Lessons/ |
| Person context | ✅ Brief mention | ✅ Full note in People/ |
| Project status | ✅ Brief mention | ✅ Update in Projects/ |

---

## Retention

- **Daily logs older than 30 days** → Archive folder
- **Important content** → Promoted to typed memory before archiving
- **Nightly maintenance cron** handles archiving automatically
