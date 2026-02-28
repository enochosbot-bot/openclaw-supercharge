# Obsidian Vault Structure

The canonical memory structure. **Obsidian is the single source of truth.**

## Directory Structure

Create this structure in your Obsidian vault:

```
~/Documents/Brain/                    # Your vault root (customize path)
├── Personal Memories/
│   └── {AgentName}/                  # e.g., "Enoch" or your agent's name
│       ├── Daily Logs/               # YYYY-MM-DD.md files
│       ├── Decisions/                # Logged decisions with context
│       ├── Lessons/                  # Lessons learned
│       ├── People/                   # Contact notes, relationship context
│       ├── Commitments/              # Tracked promises/todos
│       ├── Preferences/              # User preferences the AI should know
│       ├── Projects/                 # Project status and notes
│       └── VAULT_INDEX.md            # Quick reference index
│
└── Research/                         # All research output lands here
    ├── {topic}/                      # Topic-specific folders
    └── ...
```

## Setup Commands

```bash
# Create the structure
VAULT="$HOME/Documents/Brain"
AGENT="YourAgentName"

mkdir -p "$VAULT/Personal Memories/$AGENT/Daily Logs"
mkdir -p "$VAULT/Personal Memories/$AGENT/Decisions"
mkdir -p "$VAULT/Personal Memories/$AGENT/Lessons"
mkdir -p "$VAULT/Personal Memories/$AGENT/People"
mkdir -p "$VAULT/Personal Memories/$AGENT/Commitments"
mkdir -p "$VAULT/Personal Memories/$AGENT/Preferences"
mkdir -p "$VAULT/Personal Memories/$AGENT/Projects"
mkdir -p "$VAULT/Research"

# Create index file
cat > "$VAULT/Personal Memories/$AGENT/VAULT_INDEX.md" << 'EOF'
# Vault Index

Quick reference for memory locations.

## Folders
- **Daily Logs/** — Session notes by date
- **Decisions/** — Logged decisions with reasoning
- **Lessons/** — What we've learned
- **People/** — Contact notes and context
- **Commitments/** — Promises and tracked todos
- **Preferences/** — How you like things done
- **Projects/** — Active and archived projects

## Usage
- Agent scans this index before deep searching
- Keep entries brief with links to full notes
- Update when new important items are added
EOF
```

## Daily Log Format

`Daily Logs/YYYY-MM-DD.md`:

```markdown
# YYYY-MM-DD

## Summary
[1-2 sentence overview of the day]

## Key Events
- [Event 1]
- [Event 2]

## Decisions Made
- [Decision] — [brief reasoning]

## Follow-ups
- [ ] [Action item]

## Notes
[Anything worth remembering]
```

## People Note Format

`People/FirstName LastName.md`:

```markdown
---
name: Full Name
relationship: [friend/client/colleague/etc]
met: YYYY-MM-DD
tags: [tag1, tag2]
---

# {Name}

## Context
[Who they are, how you know them]

## Key Details
- [Detail 1]
- [Detail 2]

## Interaction History
- YYYY-MM-DD: [Note]
```

## Decision Note Format

`Decisions/YYYY-MM-DD-{slug}.md`:

```markdown
---
date: YYYY-MM-DD
status: [active/superseded/reversed]
tags: [tag1, tag2]
---

# Decision: {Title}

## Context
[What prompted this decision]

## Decision
[What was decided]

## Reasoning
[Why this choice]

## Implications
[What changes as a result]
```

## Routing Rules

The agent follows these rules:
1. **"Remember this"** → Write to appropriate typed folder + update VAULT_INDEX.md
2. **Research output** → Always goes to `Research/{topic}/`
3. **Daily notes** → Captured in `Daily Logs/YYYY-MM-DD.md`
4. **Workspace `research/`** → Staging only, must mirror to Obsidian on completion
