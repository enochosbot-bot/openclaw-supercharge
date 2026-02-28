# ops/parallelization-rules.md — Parallel Agent Orchestration
Last Updated: YYYY-MM-DD
Owner: main agent

## Core Decision Tree

```
How many independent work packages?
├── 1–2 files / tight dependencies → single deep agent
├── 3–5 packages, partial dependencies → sequence with handoffs
└── 6+ packages, independent work → full parallel spawn
```

**Working memory rule:** If your current context covers >80% of what's needed, skip spawning agents entirely. Agent overhead isn't free.

---

## Dependency-Sort Before Parallelizing

Before spawning parallel agents, map dependencies:

```
Step 1: List all work packages
Step 2: For each, identify what it needs to already exist
Step 3: Sort into tiers:

  Tier 1 (no dependencies) → spawn immediately, all in parallel
  Tier 2 (depends on Tier 1 output) → spawn after Tier 1 closes
  Tier 3 (depends on Tier 2 output) → spawn after Tier 2 closes
```

**Example:**
- T1: Berean researches competitors | Ezra drafts bio copy (independent → parallel)
- T2: Solomon reviews Ezra's draft (needs T1 output → sequential after T1)
- T3: Bezzy builds the landing page (needs T2 approval → sequential after T2)

---

## Spawning Protocol

For each parallel agent:

1. **Pre-log in ops/in-flight.md** — one row per agent, before spawning
2. **Self-contained brief** — each agent gets full context. Don't assume they share memory.
3. **Named output paths** — tell each agent exactly where to write its output
4. **Closing Block** — each brief ends with the mandatory close block (Telegram ping + in-flight update)

### Brief Template for Parallel Work

```
PARALLEL TASK: [task name]
BATCH: [batch label, e.g. "research-batch-1"]
YOUR ROLE: [what this agent does]
OTHER AGENTS RUNNING: [what else is happening in parallel — so they don't duplicate]
INPUT: [path or inline context they need]
OUTPUT: [exact path where they write results]
DEADLINE: [expected window, e.g. "15 minutes"]

[task body]

## Mandatory Close (do not skip)
1. Update ops/in-flight.md — move your row from Active to Completed
2. Send Telegram ping: target=YOUR_TELEGRAM_GROUP_ID threadId=YOUR_OPS_THREAD_ID
   message: "✅ [task name] — done. [1-sentence result]"
```

---

## Coordination Patterns

### Fan-Out / Fan-In
```
main spawns → [Berean, Ezra, Bezzy] (all parallel)
main waits  → polls in-flight.md or Telegram pings
main merges → reads all outputs, synthesizes
```

### Pipeline
```
Berean researches → writes to shared-context/agent-outputs/research.md
Solomon reviews   → reads research.md, writes verdict
Ezra drafts       → reads verdict, writes draft
```

### Supervised Parallel
```
main spawns 3 agents
main monitors: if any row in in-flight.md is >60min old → check status manually
main consolidates when all 3 close
```

---

## Anti-Patterns to Avoid

- **Spawning without logging** — always log to in-flight.md first
- **Briefing without output paths** — agents will write anywhere. Be explicit.
- **Parallel work with shared state** — if two agents write the same file, one will clobber the other. Use separate output files then merge.
- **Forgetting the dependency order** — always tier before spawning
- **Declaring done before pings arrive** — wait for every Telegram close ping before reporting to human
