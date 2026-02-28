# scripts/ — Helper Scripts

These are template scripts. **Review and customize before running.**

No secrets are stored here. Any script that needs API keys or IDs reads them from environment variables.

## Scripts

| Script | Purpose |
|--------|---------|
| `pressure-guard.sh` | Context + gateway pressure detection and recovery |

## Adding Your Scripts

If you have custom automation scripts, add them here. Conventions:
- Shebang line required
- Use `set -euo pipefail` for bash scripts
- Read secrets from env, never hardcode
- Log to stdout; let the calling agent capture output
- Exit 0 on success, non-zero on failure
