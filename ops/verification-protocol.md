# ops/verification-protocol.md — Verification Standards
Last Updated: YYYY-MM-DD
Owner: main agent

## Core Rule
**Never mark a task complete without verifying the actual deliverable, live.**
"File exists on disk" is not verification. "Sub-agent said done" is not verification.

---

## General Verification Standards

| Claim | Verification Required |
|-------|----------------------|
| File was created | `test -f <path>` AND read first 10 lines |
| Sub-agent completed | Check output token count (< 500 on complex task = likely fake success). Read the file. |
| Config change applied | Read the live config file, don't trust the announcement |
| Cron job works | `openclaw cron list` — confirm job exists with correct schedule |
| Git committed | `git log --oneline -1` — confirm hash exists |
| Deploy went live | HTTP 200 from production URL |

---

## Website Deployments (Critical)

After ANY website task:

**Step 1 — Verify file exists locally:**
```bash
test -f <local_path> && echo "EXISTS" || echo "MISSING"
```

**Step 2 — Verify it's deployed:**
```bash
curl -o /dev/null -s -w "%{http_code}" YOUR_SITE_URL/<path>
```
Must return `200`. Anything else = not live.

**Step 3 — If not live, deploy immediately:**
```bash
YOUR_DEPLOY_COMMAND
```

**Step 4 — Re-verify after deploy.**

---

## Sub-Agent Completion Checks

After every sub-agent run:
1. Output tokens < 500 on a complex task → assume nothing was written, verify manually
2. Read the primary deliverable file — don't trust the summary
3. For code tasks: does the thing actually run?
4. For deploy tasks: hit the live URL.
5. For config tasks: read the config file and confirm the change is there.

---

## Auth & Environment

After any session restart or compaction:
- Re-verify auth is active before running API calls
- Re-verify working directory is correct
- Re-verify required files exist before starting work

---

## "It was already done" Trap

Before reporting something as broken, check if a prior agent already fixed it.
Before reporting something as fixed, verify it live — don't trust the changelog alone.
