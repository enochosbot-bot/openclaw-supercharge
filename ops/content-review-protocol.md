# ops/content-review-protocol.md — Content Review Protocol
Last Updated: YYYY-MM-DD
Owners: Ezra (scribe), Solomon (solomon)

## Purpose
All content must pass strategic review before publishing. Ezra writes, Solomon reviews, nothing ships without alignment.

---

## Flow

```
1. Content drafted (by Ezra, or dispatched to Ezra)
2. Ezra saves draft → shared-context/drafts/{slug}.md
3. Ezra hands off to Solomon via sessions_send (CONTENT_REVIEW)
4. Solomon reviews against criteria below
5. Solomon writes feedback → shared-context/feedback/{slug}-review.md
6. Solomon hands back to Ezra (REVIEW_VERDICT)
7. If REVISE → Ezra incorporates feedback, loops back to step 3 (max 1 revision)
8. If APPROVE → Ezra publishes (dispatch to Bezzy for website, or post via script)
9. If KILL → Ezra notifies human with reasoning
10. Routine approvals stay in scribe channel. Escalations (KILL, stuck reviews) go to ops topic.
```

---

## File Locations

| What | Path |
|------|------|
| Drafts | `shared-context/drafts/{slug}.md` |
| Review feedback | `shared-context/feedback/{slug}-review.md` |
| This protocol | `ops/content-review-protocol.md` |

### Slug Convention
Use lowercase, hyphenated: `linkedin-launch-week`, `blog-ai-automation`, `x-thread-tips`

---

## Ezra's Responsibilities (Pre-Review)

Before handing off to Solomon, save the draft with this frontmatter:

```markdown
---
title: [Post title]
platform: [linkedin | x | blog | website | newsletter]
audience: [who this is for]
goal: [what this should accomplish]
draft_version: 1
date: [YYYY-MM-DD]
---
```

Send CONTENT_REVIEW handoff:
```
HANDOFF: CONTENT_REVIEW
FROM: scribe
SLUG: {slug}
PLATFORM: {platform}
DRAFT_PATH: shared-context/drafts/{slug}.md
NOTES: [any context Solomon should know]
```

---

## Solomon's Review Criteria

### 1. Brand Alignment
- Does it sound like the human / their brand?
- Professional but human, not corporate

### 2. Strategic Fit
- Does this advance a current priority? (Check shared-context/priorities.md)
- Is this the right time to post this?

### 3. Factual Accuracy
- Is anything verifiably wrong?
- Is anything likely to age poorly?

### 4. Tone & Voice
- Consistent with prior published content?
- No hedging where conviction is called for?

### 5. Risk Assessment
- Anything that could embarrass, expose liability, or confuse the audience?

---

## Solomon's Verdict Format

```
VERDICT: APPROVE | REVISE | KILL
SLUG: {slug}
FEEDBACK: [specific notes if REVISE or KILL]
```
