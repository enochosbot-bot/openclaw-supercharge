# Notification Routing Rules

**Principle: Single source per workflow. No duplicate notifications across channels.**

---

## Why This Matters

Early mistake: Agent completes a task and notifies:
- The requesting channel
- The Security/Ops topic
- The user's DM

Result: 3 notifications for the same thing. Noise.

**Rule: Pick ONE channel for each workflow. Escalations only go elsewhere.**

---

## Routing by Workflow Type

### Content Review
- **Primary channel:** Scribe's topic (where drafts live)
- **Escalations only:** Security/Ops (for KILL verdicts or stuck reviews)
- **Never:** DM for routine approvals

### Code/Deploy Tasks
- **Primary channel:** Coder's topic or the requesting channel
- **Escalations only:** Security/Ops (for deploy failures)
- **Verification:** Main agent confirms before reporting to user

### Security Audits
- **Primary channel:** Security/Ops topic
- **Escalations only:** DM for CRITICAL findings
- **Routine:** Stay in topic, no DM for clean audits

### Research Tasks
- **Primary channel:** Research topic or requesting channel
- **Escalations only:** None (research doesn't usually escalate)

### Cron Jobs
- **Primary channel:** Configured delivery target (usually Security/Ops or none)
- **Rule:** Silent unless something needs attention
- **Never:** Multiple channels for same cron output

---

## Escalation Triggers

Only escalate to additional channels when:
1. **CRITICAL security finding** → DM immediately
2. **Blocked >24h** → DM to unblock
3. **KILL verdict** on content → Security/Ops + DM
4. **Deploy failure** → Security/Ops
5. **User explicitly asked** for notification elsewhere

---

## Anti-Patterns

❌ **Don't:** Post completion to topic AND DM AND Ops
❌ **Don't:** Send "all clear" to multiple channels
❌ **Don't:** Create notification for every cron run
❌ **Don't:** CC the user on internal agent handoffs

✅ **Do:** Pick one channel, stick to it
✅ **Do:** Stay silent when nothing needs attention
✅ **Do:** Escalate only when criteria are met
✅ **Do:** Let the user pull status when they want it

---

## Configuration

Set delivery targets in cron definitions:
```json
{
  "delivery": {
    "mode": "announce",
    "channel": "telegram",
    "to": "GROUP_ID:topic:THREAD_ID"
  }
}
```

For silent crons:
```json
{
  "delivery": {
    "mode": "none"
  }
}
```
