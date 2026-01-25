#!/bin/bash

# Vibe Coding Toolkit Installer
# Installs skills and commands into your project's .claude/ folder
# Usage: curl -fsSL https://raw.githubusercontent.com/jacksnxly/claude-vibe-coding-toolkit/main/install.sh | bash

set -e

REPO_URL="https://github.com/jacksnxly/claude-vibe-coding-toolkit"
REPO_RAW="https://raw.githubusercontent.com/jacksnxly/claude-vibe-coding-toolkit/main"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║            Vibe Coding Toolkit Installer                  ║"
echo "║   AI-Augmented Development Workflow (4 Phases)            ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if we're in a git repo or project directory
if [ ! -d ".git" ] && [ ! -f "package.json" ] && [ ! -f "Cargo.toml" ] && [ ! -f "pyproject.toml" ] && [ ! -f "go.mod" ]; then
    echo -e "${YELLOW}Warning: Not in a typical project directory.${NC}"
    read -p "Install here anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

# Function to download a file
download_file() {
    local url="$1"
    local dest="$2"

    if command -v curl &> /dev/null; then
        curl -fsSL "$url" -o "$dest"
    elif command -v wget &> /dev/null; then
        wget -q "$url" -O "$dest"
    else
        echo -e "${RED}Error: curl or wget required${NC}"
        exit 1
    fi
}

# Create .claude directory structure
echo -e "${BLUE}Creating .claude directory structure...${NC}"
mkdir -p .claude/commands
mkdir -p .claude/skills/vibe-coding-toolkit/{feature-brief/references,technical-spec/references,implement-feature/references,review-code/references}

# Download commands
echo -e "${BLUE}Downloading commands...${NC}"

COMMANDS=(
    "feature-brief"
    "technical-spec"
    "implement-feature"
    "review-code"
)

for cmd in "${COMMANDS[@]}"; do
    echo -e "  ${GREEN}✓${NC} $cmd"
    download_file "$REPO_RAW/commands/$cmd.md" ".claude/commands/$cmd.md"
done

# Download skills and their references
echo -e "${BLUE}Downloading skills...${NC}"

# Feature Brief
echo -e "  ${GREEN}✓${NC} feature-brief skill"
download_file "$REPO_RAW/skills/feature-brief/SKILL.md" ".claude/skills/vibe-coding-toolkit/feature-brief/SKILL.md"
download_file "$REPO_RAW/skills/feature-brief/references/interview-guide.md" ".claude/skills/vibe-coding-toolkit/feature-brief/references/interview-guide.md"
download_file "$REPO_RAW/skills/feature-brief/references/brief-template.md" ".claude/skills/vibe-coding-toolkit/feature-brief/references/brief-template.md"

# Technical Spec
echo -e "  ${GREEN}✓${NC} technical-spec skill"
download_file "$REPO_RAW/skills/technical-spec/SKILL.md" ".claude/skills/vibe-coding-toolkit/technical-spec/SKILL.md"
download_file "$REPO_RAW/skills/technical-spec/references/research-checklist.md" ".claude/skills/vibe-coding-toolkit/technical-spec/references/research-checklist.md"
download_file "$REPO_RAW/skills/technical-spec/references/option-format.md" ".claude/skills/vibe-coding-toolkit/technical-spec/references/option-format.md"
download_file "$REPO_RAW/skills/technical-spec/references/spec-template.md" ".claude/skills/vibe-coding-toolkit/technical-spec/references/spec-template.md"

# Implement Feature
echo -e "  ${GREEN}✓${NC} implement-feature skill"
download_file "$REPO_RAW/skills/implement-feature/SKILL.md" ".claude/skills/vibe-coding-toolkit/implement-feature/SKILL.md"
download_file "$REPO_RAW/skills/implement-feature/references/execution-protocols.md" ".claude/skills/vibe-coding-toolkit/implement-feature/references/execution-protocols.md"
download_file "$REPO_RAW/skills/implement-feature/references/completion-checklist.md" ".claude/skills/vibe-coding-toolkit/implement-feature/references/completion-checklist.md"

# Review Code
echo -e "  ${GREEN}✓${NC} review-code skill"
download_file "$REPO_RAW/skills/review-code/SKILL.md" ".claude/skills/vibe-coding-toolkit/review-code/SKILL.md"
download_file "$REPO_RAW/skills/review-code/references/confidence-scoring.md" ".claude/skills/vibe-coding-toolkit/review-code/references/confidence-scoring.md"
download_file "$REPO_RAW/skills/review-code/references/security-checklist.md" ".claude/skills/vibe-coding-toolkit/review-code/references/security-checklist.md"
download_file "$REPO_RAW/skills/review-code/references/audit-report-template.md" ".claude/skills/vibe-coding-toolkit/review-code/references/audit-report-template.md"

# Create .agent directory for briefs and specs
echo -e "${BLUE}Creating .agent directory for workflow documents...${NC}"
mkdir -p .agent/briefs
mkdir -p .agent/specs

# Success message
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║            Installation Complete!                         ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Commands installed to: ${BLUE}.claude/commands/${NC}"
echo -e "Skills installed to:   ${BLUE}.claude/skills/vibe-coding-toolkit/${NC}"
echo -e "Workflow docs folder:  ${BLUE}.agent/briefs/${NC} and ${BLUE}.agent/specs/${NC}"
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}                    4-Phase Workflow                        ${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  ${CYAN}Phase 1: Discovery${NC}"
echo -e "    /feature-brief         - Extract requirements via interview"
echo ""
echo -e "  ${CYAN}Phase 2: Design${NC}"
echo -e "    /technical-spec        - Research codebase & gather decisions"
echo ""
echo -e "  ${CYAN}Phase 3: Build${NC}"
echo -e "    /implement-feature     - Execute spec with constraint tracking"
echo ""
echo -e "  ${CYAN}Phase 4: Verify${NC}"
echo -e "    /review-code           - Audit against spec (confidence scoring)"
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Quick start:${NC}"
echo "  1. Start new feature:  /feature-brief"
echo "  2. Design solution:    /technical-spec"
echo "  3. Build it:           /implement-feature"
echo "  4. Review changes:     /review-code"
echo ""
echo -e "Documentation: ${BLUE}$REPO_URL${NC}"
echo ""
