# Tool Failure Log

Track dead ends so agents don't retry them.

---

## Format

```
DATE | TOOL | WHAT FAILED | WHY | AVOID NEXT TIME
```

---

## Log

<!-- Add failures below as they occur -->

| Date | Tool | What Failed | Why | Avoid |
|------|------|-------------|-----|-------|
| _example_ | web_search | Site X blocked | Cloudflare bot detection | Use different source |

---

## Categories

### API Failures
- Rate limits hit
- Auth expired
- Endpoint deprecated
- Service down

### Structural Limitations
- Tool can't do X (design limitation)
- Format not supported
- Size limits exceeded

### External Blocks
- Site blocks scraping
- API rejects requests
- Firewall/network issues

---

## Rules

1. **Log immediately** — when a tool fails in a new way
2. **Be specific** — "API failed" is useless; "OpenAI returned 429 after 50 requests/min" is useful
3. **Include the fix** — what to do differently next time
4. **Check before retrying** — scan this log before attempting something that might be a known dead end
5. **Prune monthly** — remove entries for issues that have been fixed

---

## Common Patterns

### Rate Limits
- **Symptom:** 429 errors, "too many requests"
- **Fix:** Add delays, batch requests, use different times

### Auth Expiry
- **Symptom:** 401/403 errors that used to work
- **Fix:** Refresh token, re-authenticate

### Blocked Scraping
- **Symptom:** Cloudflare challenge, empty responses
- **Fix:** Use official API, different source, or agent-browser with stealth

### Deprecated Endpoints
- **Symptom:** 404 or "endpoint not found"
- **Fix:** Check docs for new endpoint, update tool config
