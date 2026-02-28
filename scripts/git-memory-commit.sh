#!/bin/bash
# Git Memory Commit — auto-commits workspace changes
# Run nightly or after significant changes

WORKSPACE="$HOME/.openclaw/workspace"
cd "$WORKSPACE" || exit 1

# Check if there are changes
if git diff --quiet && git diff --cached --quiet; then
  echo "No changes to commit"
  exit 0
fi

# Stage all changes
git add -A

# Generate commit message based on what changed
COUNT=$(git diff --cached --name-only | wc -l | tr -d ' ')

if [ "$COUNT" -gt 10 ]; then
  MSG="chore: auto-commit $COUNT files ($(date '+%Y-%m-%d %H:%M'))"
else
  DIRS=$(git diff --cached --name-only | cut -d'/' -f1 | sort -u | tr '\n' ', ' | sed 's/,$//')
  MSG="chore: auto-commit changes to $DIRS ($(date '+%Y-%m-%d %H:%M'))"
fi

git commit -m "$MSG"
echo "Committed: $MSG"
echo "Files changed: $COUNT"
