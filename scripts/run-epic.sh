#!/bin/bash
# run-epic.sh — Epic decomposition + automatic Slice execution
#
# Usage:
#   ./scripts/run-epic.sh "Epic 1 — 사용자 인증 시스템"
#
# Flow:
#   1. /plan Epic N → generates epic plan with Slice list
#   2. Parses Slice list from the epic plan
#   3. Runs run-task.sh for each Slice sequentially
#   4. Stops on first failure (REQUEST_CHANGES or error)

set -euo pipefail

# ============================================================
# Configuration
# ============================================================
CLAUDE_BIN="${CLAUDE_BIN:-claude}"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_NAME="{{PROJECT_NAME}}"
LOG_DIR="/tmp/${PROJECT_NAME}-run"
EPIC="$*"

if [ -z "$EPIC" ]; then
  echo "Usage: $0 <epic description>"
  echo "Example: $0 Epic 1 — 사용자 인증 시스템"
  exit 1
fi

mkdir -p "$LOG_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log_phase() {
  echo ""
  echo -e "${CYAN}════════════════════════════════════════${NC}"
  echo -e "${CYAN}  $1${NC}"
  echo -e "${CYAN}════════════════════════════════════════${NC}"
  echo ""
}

# ============================================================
# Phase 0: Epic Decomposition
# ============================================================
log_phase "EPIC DECOMPOSITION: $EPIC"

cd "$PROJECT_DIR"

EPIC_LOG="${LOG_DIR}/epic-plan.log"
echo "Running: claude -p \"/plan $EPIC\""

if ! "$CLAUDE_BIN" -p "/plan $EPIC" \
  --output-format text \
  2>&1 | tee "$EPIC_LOG"; then
  echo -e "${RED}✗ Epic planning failed. Check $EPIC_LOG${NC}"
  exit 1
fi

echo -e "${GREEN}✓ Epic plan created${NC}"

# ============================================================
# Parse Slice list from epic plan
# ============================================================
EPIC_PLAN=$(find "$PROJECT_DIR/outputs/plans" -name "epic*plan*.md" -mmin -10 2>/dev/null | sort | tail -1)

if [ -z "$EPIC_PLAN" ]; then
  echo -e "${RED}✗ Could not find epic plan file in outputs/plans/${NC}"
  echo "Run slices manually with: ./scripts/run-task.sh \"Task N — description\""
  exit 1
fi

echo "Epic plan: $EPIC_PLAN"

# Extract Task/Slice lines
SLICES=()
while IFS= read -r line; do
  SLICE_DESC=$(echo "$line" | sed -E '
    s/^[[:space:]]*[-*|]+[[:space:]]*//;
    s/\|[[:space:]]*$//;
    s/^[0-9]+\.[[:space:]]*//;
    s/^#+[[:space:]]*//;
    s/[[:space:]]+$//
  ')
  if [ -n "$SLICE_DESC" ]; then
    SLICES+=("$SLICE_DESC")
  fi
done < <(grep -iE "^[[:space:]]*[-*|#0-9].*\b(Task|Slice|태스크|슬라이스)\s+[0-9]" "$EPIC_PLAN" 2>/dev/null)

if [ ${#SLICES[@]} -eq 0 ]; then
  echo -e "${YELLOW}! Could not auto-parse Slices from epic plan${NC}"
  echo "Run slices manually: ./scripts/run-task.sh \"Task N — description\""
  exit 0
fi

# ============================================================
# Execute each Slice
# ============================================================
TOTAL=${#SLICES[@]}

echo -e "${BLUE}Found $TOTAL slices:${NC}"
for i in "${!SLICES[@]}"; do
  echo "  $((i+1)). ${SLICES[$i]}"
done
echo ""

COMPLETED=0

for i in "${!SLICES[@]}"; do
  SLICE_NUM=$((i+1))
  SLICE="${SLICES[$i]}"

  log_phase "SLICE $SLICE_NUM/$TOTAL: $SLICE"

  if "$SCRIPT_DIR/run-task.sh" "$SLICE"; then
    COMPLETED=$((COMPLETED+1))
    echo -e "${GREEN}✓ Slice $SLICE_NUM/$TOTAL complete${NC}"
  else
    echo -e "${RED}✗ Slice $SLICE_NUM/$TOTAL failed: $SLICE${NC}"
    echo ""
    echo "Completed: $COMPLETED/$TOTAL"
    echo ""
    echo "To resume:"
    for j in $(seq $i $((TOTAL-1))); do
      echo "  $SCRIPT_DIR/run-task.sh \"${SLICES[$j]}\""
    done
    exit 1
  fi
done

echo ""
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}  EPIC COMPLETE: $EPIC${NC}"
echo -e "${GREEN}  All $TOTAL slices finished${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"
