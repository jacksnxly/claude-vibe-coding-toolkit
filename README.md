# Vibe Coding Toolkit

AI-augmented development workflow for teams. Enables non-technical and technical members to use AI coding agents while maintaining code quality.

## Overview

A 4-phase workflow where AI agents behave differently at each phase:

```
Phase 1          Phase 2            Phase 3             Phase 4
DISCOVERY   →    DESIGN        →    BUILD          →    VERIFY

feature-brief    technical-spec     implement-feature   review-code

Anyone can       Tech Lead only     Anyone can          Tech Lead
initiate         decides            execute             approves

Agent:           Agent:             Agent:              Agent:
INTERVIEWER      RESEARCHER         EXECUTOR            AUDITOR
```

## Skills

### `/feature-brief` (Phase 1: Discovery)

Extract complete requirements through structured interviewing.

- Conducts multi-turn interview to get concrete details
- Challenges vague answers ("users" → "which users specifically?")
- Extracts edge cases, scope boundaries, priority
- **Output:** `BRIEF-[name]-[date].md` in `.agent/briefs/`

### `/technical-spec` (Phase 2: Design)

Create technical specifications by researching codebase and gathering decisions.

- **Gate:** Requires approved feature brief
- Searches codebase for existing patterns
- Presents 2-3 options for each major decision
- Documents human's choices with reasoning
- **Output:** `SPEC-[name]-[date].md` in `.agent/specs/`

### `/implement-feature` (Phase 3: Build)

Execute implementation following the spec exactly.

- **Gate:** Requires approved technical spec
- Acknowledges all constraints before coding
- Follows existing patterns, asks on ambiguity
- Logs scope temptations without acting on them
- **Output:** Code + constraint verification checklist

### `/review-code` (Phase 4: Verify)

Audit implementation against spec with confidence scoring.

- **Gate:** Requires spec + files to review
- 4 parallel audit passes (constraints, security, scope, tests)
- Confidence scoring 0-100 (threshold 80)
- **Output:** Audit report with APPROVE / REQUEST CHANGES / NEEDS DISCUSSION

## Installation

### Quick Install (Recommended)

Run this in your project directory:

```bash
curl -fsSL https://raw.githubusercontent.com/jacksnxly/claude-vibe-coding-toolkit/main/install.sh | bash
```

This installs the toolkit to your project's `.claude/` folder.

### Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/jacksnxly/claude-vibe-coding-toolkit/main/uninstall.sh | bash
```

### Alternative: Plugin Directory

For development/testing:

```bash
claude --plugin-dir /path/to/vibe-coding-toolkit
```

## Usage

```bash
# Start a new feature
/feature-brief

# After brief is complete, create technical design
/technical-spec

# After spec is approved, implement
/implement-feature

# After implementation, review
/review-code
```

## Document Structure

The plugin uses `.agent/` for documents:

```
.agent/
├── briefs/           # Feature briefs (Phase 1 output)
│   └── BRIEF-[name]-[date].md
├── specs/            # Technical specs (Phase 2 output)
│   └── SPEC-[name]-[date].md
└── ...
```

## Key Principles

1. **Gate enforcement** - Each phase requires previous phase's output
2. **Role separation** - Agents stay in their lane (interviewer doesn't code, executor doesn't decide)
3. **Constraint-based** - Specs generate verifiable constraints, review checks them
4. **Human decisions** - AI presents options, humans choose
5. **No git required** - Works with files in working directory (vibe-coder friendly)

## License

MIT
