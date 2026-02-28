# ops/dispatch-routing.md — Task Dispatch Protocol
Last Updated: YYYY-MM-DD
Owner: main agent

## Core Rule
All coding, config, and build tasks → Bezzy (coder agent).
Never attempt code changes from chat. Never override an agent's completed work.

---

## Task → Agent Routing

| Task Type | Agent | Notes |
|-----------|-------|-------|
| Code (new features, fixes, scripts) | Bezzy | Always |
| Website changes | Bezzy | Must include deploy + live URL check |
| Config changes (openclaw.json, cron) | Bezzy | Never from chat |
| Gateway/model changes | Bezzy | Outage risk — never from chat |
| Security audits | Gideon | Nightly auto, or manual trigger |
| Research tasks | Berean | Web search, synthesis, daily briefs |
| Strategy questions | Solomon | On-demand + daily cron |
| Content/writing | Ezra | Blog posts, social copy, docs |
| Image generation | Selah | Creative output |
| QA / testing | Nehemiah | After Bezzy ships |
| Everything else | main | Handle directly |

---

## Bezzy Brief Requirements (mandatory)

Every Bezzy dispatch MUST include:

1. **Context** — relevant file paths, current state, what exists
2. **Explicit task list** — numbered, unambiguous
3. **Verification step** — exact commands to confirm it worked
4. **Deploy step (for site tasks)** — deploy command + curl check for HTTP 200
5. **Changelog** — append to `ops/changelog.md`

---

## Mandatory Dispatch Protocol (ALL agents, every task)

### Before dispatching
1. Add a row to `ops/in-flight.md` → Active table (task name, agent, timestamp, expected window)
2. Include the Closing Block in every brief (see below)

### Closing Block (paste verbatim at end of every brief)
```
## Mandatory Close (do not skip)
When your work is fully done:
1. Update ops/in-flight.md — move your row from Active to Completed with result summary
2. Send a Telegram message to confirm completion:
   - channel: telegram
   - target: YOUR_TELEGRAM_GROUP_ID
   - threadId: "YOUR_OPS_THREAD_ID"
   - message: "✅ [task name] — done. [1-sentence summary]"
3. Do NOT mark done until both steps above are complete.
```

### After close
- Verify the Telegram ping arrived
- If agent went silent >60min: check sessions_history, then notify your human manually with status

---

## Oversight (after any site task)

Before telling your human it's done:
1. Check the live URL returns 200
2. If not — deploy it, flag that the agent missed the step
3. Never report "live" based on local file existence alone
