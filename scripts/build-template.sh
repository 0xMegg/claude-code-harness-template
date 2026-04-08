#!/bin/bash
# build-template.sh — Build the harness template from src/ to outputs/template/
#
# Usage:
#   ./scripts/build-template.sh
#
# Copies src/ contents to outputs/template/, preserving directory structure.
# The output is a ready-to-use harness template that can be copied to new projects.

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$PROJECT_DIR/src"
OUT_DIR="$PROJECT_DIR/outputs/template"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ ! -d "$SRC_DIR" ]; then
  echo -e "${RED}✗ src/ directory not found at $SRC_DIR${NC}"
  exit 1
fi

echo -e "${CYAN}Building harness template...${NC}"
echo "  Source: $SRC_DIR"
echo "  Output: $OUT_DIR"

# Clean previous build
if [ -d "$OUT_DIR" ]; then
  rm -rf "$OUT_DIR"
fi

# Copy src/ to outputs/template/
mkdir -p "$OUT_DIR"
cp -R "$SRC_DIR/"* "$OUT_DIR/" 2>/dev/null || true
# Copy hidden files/dirs (like .claude/)
cp -R "$SRC_DIR/".* "$OUT_DIR/" 2>/dev/null || true

# Remove any .DS_Store files
find "$OUT_DIR" -name '.DS_Store' -delete 2>/dev/null || true

# Ensure scripts are executable
find "$OUT_DIR/scripts" -name '*.sh' -exec chmod +x {} \; 2>/dev/null || true
[ -f "$OUT_DIR/setup.sh" ] && chmod +x "$OUT_DIR/setup.sh"

# Count files
FILE_COUNT=$(find "$OUT_DIR" -type f | wc -l | tr -d ' ')
DIR_COUNT=$(find "$OUT_DIR" -type d | wc -l | tr -d ' ')

echo ""
echo -e "${GREEN}✓ Template built successfully${NC}"
echo "  Files: $FILE_COUNT"
echo "  Directories: $DIR_COUNT"
echo ""
echo -e "${YELLOW}To use this template:${NC}"
echo "  cp -R $OUT_DIR /path/to/new-project"
echo "  cd /path/to/new-project && ./setup.sh"
