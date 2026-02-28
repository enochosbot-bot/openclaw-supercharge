# Pruning Protocol

How to keep the workspace clean and prevent stale content from polluting exports or confusing agents.

---

## Principles

1. **Stale content misleads** — old patterns get copied, deprecated names get referenced
2. **History is different from active docs** — changelog.md is history (keep it), AGENTS.md is active (clean it)
3. **Prune or annotate** — either remove stale content or mark it clearly as deprecated
4. **Regular cadence** — pruning happens on schedule, not just when problems appear

---

## Weekly Pruning (Sunday, part of Memory Hygiene cron)

### 1. Deprecated Terms Scan
```bash
grep -ri "arnold\|xalt\|core.3" *.md ops/*.md shared-context/*.md
```
- **In changelog.md:** Leave it (history)
- **In active docs:** Remove or update
- **In templates:** Must be removed

### 2. Stale Pattern Scan
```bash
grep -ri "5.*minute.*silence\|afk.*poll\|continuous.*poll"
```
- Remove references to deprecated patterns
- Update to current approach (e.g., Mission Pulse)

### 3. Old File Scan
```bash
find . -name "*.md" -mtime +30 -not -path "./research/*"
```
- Review files not modified in 30+ days
- Archive or delete if no longer relevant
- Update if still needed but stale

### 4. Deprecation Log Update
- Add any new deprecations found
- Verify existing entries are still accurate
- Check that deprecated items aren't being referenced in new work

---

## Before Export (client packages, GitHub pushes)

### 1. Full Deprecated Terms Scan
```bash
grep -ri "arnold\|xalt\|core.3\|5.*min.*afk" --include="*.md" --include="*.json"
```
- **Zero tolerance** in exported packages
- Fix or remove any hits

### 2. Template Validation
- All templates should use `YOUR_` placeholders
- No hardcoded paths, IDs, or secrets
- No references to deprecated patterns

### 3. README Accuracy
- Features listed actually exist
- Links work
- Instructions are current

---

## Monthly Deep Clean

### 1. Orphaned Files
Files that exist but aren't referenced anywhere:
```bash
# Find .md files
find . -name "*.md" -type f > /tmp/all-files.txt
# Check which aren't linked/referenced
```

### 2. Superseded Content
Content where a newer version exists:
- Old versions of protocols
- Outdated agent rosters
- Stale research that's been updated

### 3. Test/Demo Artifacts
Files created during testing that weren't cleaned up:
- `notes/` demo files
- `test-*` files
- Temporary project folders

---

## What to Keep vs. Prune

### Keep (History)
- `ops/changelog.md` — even with old names
- Old audit reports — they're the record
- Archived daily logs — reference material

### Prune (Active Docs)
- Agent definitions with wrong names
- Protocols with deprecated patterns
- Templates with stale examples

### Annotate (When Unsure)
Add a deprecation notice at the top:
```markdown
> ⚠️ DEPRECATED: This file references outdated patterns. See [new-file.md] for current approach.
```

---

## Deprecation Log

Maintain `ops/DEPRECATION-LOG.md` with:
- What was deprecated
- When
- What replaced it
- Why

Check this log before referencing old content.

---

## Automation

The Weekly Memory Hygiene cron should include:
```
1. Run deprecated terms scan
2. Flag any hits in active docs
3. Update DEPRECATION-LOG.md if new items found
4. Report findings (or stay silent if clean)
```
