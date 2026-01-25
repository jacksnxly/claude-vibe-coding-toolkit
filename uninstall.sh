#!/bin/bash

# Vibe Coding Toolkit Uninstaller
# Removes vibe-coding-toolkit from your project's .claude/ folder
# Usage: curl -fsSL https://raw.githubusercontent.com/jacksnxly/claude-vibe-coding-toolkit/main/uninstall.sh | bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║            Vibe Coding Toolkit Uninstaller                ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if vibe-coding-toolkit is installed
INSTALLED=0

if [ -d ".claude/skills/vibe-coding-toolkit" ]; then
    INSTALLED=1
fi

if [ -f ".claude/commands/feature-brief.md" ] || [ -f ".claude/commands/technical-spec.md" ] || [ -f ".claude/commands/implement-feature.md" ] || [ -f ".claude/commands/review-code.md" ]; then
    INSTALLED=1
fi

if [ $INSTALLED -eq 0 ]; then
    echo -e "${YELLOW}Vibe Coding Toolkit is not installed in this directory.${NC}"
    exit 0
fi

# Show what will be removed
echo -e "${BLUE}The following will be removed:${NC}"
echo ""

if [ -d ".claude/skills/vibe-coding-toolkit" ]; then
    echo -e "  ${YELLOW}Skills:${NC}"
    echo "    - .claude/skills/vibe-coding-toolkit/"
fi

echo -e "  ${YELLOW}Commands:${NC}"
for cmd in feature-brief technical-spec implement-feature review-code; do
    if [ -f ".claude/commands/$cmd.md" ]; then
        echo "    - .claude/commands/$cmd.md"
    fi
done

echo ""

# Check for workflow documents
BRIEFS_COUNT=0
SPECS_COUNT=0

if [ -d ".agent/briefs" ]; then
    BRIEFS_COUNT=$(find .agent/briefs -name "BRIEF-*.md" 2>/dev/null | wc -l | tr -d ' ')
fi

if [ -d ".agent/specs" ]; then
    SPECS_COUNT=$(find .agent/specs -name "SPEC-*.md" 2>/dev/null | wc -l | tr -d ' ')
fi

if [ "$BRIEFS_COUNT" -gt 0 ] || [ "$SPECS_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}Note: Your workflow documents will NOT be removed:${NC}"
    [ "$BRIEFS_COUNT" -gt 0 ] && echo "  - $BRIEFS_COUNT feature brief(s) in .agent/briefs/"
    [ "$SPECS_COUNT" -gt 0 ] && echo "  - $SPECS_COUNT technical spec(s) in .agent/specs/"
    echo ""
fi

# Confirm uninstallation
read -p "Remove Vibe Coding Toolkit from this project? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstallation cancelled."
    exit 0
fi

# Remove skills
if [ -d ".claude/skills/vibe-coding-toolkit" ]; then
    echo -e "${BLUE}Removing skills...${NC}"
    rm -rf .claude/skills/vibe-coding-toolkit
    echo -e "  ${GREEN}✓${NC} Skills removed"
fi

# Remove commands
echo -e "${BLUE}Removing commands...${NC}"
for cmd in feature-brief technical-spec implement-feature review-code; do
    if [ -f ".claude/commands/$cmd.md" ]; then
        rm ".claude/commands/$cmd.md"
        echo -e "  ${GREEN}✓${NC} Removed $cmd"
    fi
done

# Ask about .agent directories
echo ""
if [ -d ".agent/briefs" ] || [ -d ".agent/specs" ]; then
    echo -e "${YELLOW}The .agent/briefs/ and .agent/specs/ directories contain your workflow documents.${NC}"
    read -p "Remove these empty directories? (keeps any documents) (y/n) " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Only remove if empty
        rmdir .agent/briefs 2>/dev/null && echo -e "  ${GREEN}✓${NC} Removed .agent/briefs/" || echo -e "  ${YELLOW}⊘${NC} .agent/briefs/ not empty, keeping"
        rmdir .agent/specs 2>/dev/null && echo -e "  ${GREEN}✓${NC} Removed .agent/specs/" || echo -e "  ${YELLOW}⊘${NC} .agent/specs/ not empty, keeping"
        rmdir .agent 2>/dev/null || true
    fi
fi

# Clean up empty directories
rmdir .claude/skills 2>/dev/null || true
rmdir .claude/commands 2>/dev/null || true
rmdir .claude 2>/dev/null || true

echo ""
echo -e "${GREEN}Vibe Coding Toolkit has been removed.${NC}"
echo ""
echo -e "${YELLOW}Your workflow documents (briefs/specs) were preserved.${NC}"
echo "To reinstall: curl -fsSL https://raw.githubusercontent.com/jacksnxly/claude-vibe-coding-toolkit/main/install.sh | bash"
echo ""
