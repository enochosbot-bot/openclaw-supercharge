# TOOLS.md — Environment-Specific Tool Notes

Skills define _how_ tools work. This file is for _your_ specifics.

## What Goes Here

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Any installed skills + their status

## Examples

```markdown
### Cameras
- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH
- home-server → 192.168.1.100, user: admin

### TTS
- Preferred voice: "Onyx" (deep, clear)
```

## Terminal Security (Recommended)
If you're running on macOS with zsh, consider installing Tirith for homograph attack + ANSI injection protection:
```bash
brew install sheeki03/tap/tirith
echo 'eval "$(tirith init)"' >> ~/.zshrc
```
Note: Tirith only protects interactive terminal sessions. OpenClaw exec calls run via Node.js and have separate security settings (`tools.exec.security`, `approvals.exec`).

## Local Search (Recommended)
QMD for hybrid semantic search over your workspace:
```bash
npm install -g qmd
qmd index  # index workspace
qmd search "your query"
```

## Why Separate From Skills?
Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.
