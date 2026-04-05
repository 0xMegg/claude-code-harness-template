#!/bin/bash
# run-task.sh — Run Plan → Develop → Review in separate sessions
#
# Usage:
#   ./scripts/run-task.sh "Task 1 — 회원가입 폼 빈값 제출 버그 수정"
#
# Each phase runs as an independent claude -p session (clean context).
# Stops on failure. Logs saved to /tmp/{{PROJECT_NAME}}-run/

set -euo pipefail

# ============================================================
# Configuration — adjust for your project
# ============================================================
CLAUDE_BIN="${CLAUDE_BIN:-claude}"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT_NAME="{{PROJECT_NAME}}"
LOG_DIR="/tmp/${PROJECT_NAME}-run"
TASK="$*"

if [ -z "$TASK" ]; then
  echo "Usage: $0 <task description>"
  echo "Example: $0 Task 1 — 회원가입 폼 빈값 제출 버그 수정"
  exit 1
fi

mkdir -p "$LOG_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================================
# Helper functions
# ============================================================
log_phase() {
  echo ""
  echo -e "${BLUE}════════════════════════════════════════${NC}"
  echo -e "${BLUE}  $1${NC}"
  echo -e "${BLUE}════════════════════════════════════════${NC}"
  echo ""
}

log_success() { echo -e "${GREEN}✓ $1${NC}"; }
log_fail()    { echo -e "${RED}✗ $1${NC}"; }
log_warn()    { echo -e "${YELLOW}! $1${NC}"; }

run_claude() {
  local phase="$1"
  local command="$2"
  local log_file="${LOG_DIR}/${phase}.log"

  cd "$PROJECT_DIR"
  echo "Running: claude -p \"$command\""
  echo "Log: $log_file"
  echo ""

  if "$CLAUDE_BIN" -p "$command" \
    --output-format text \
    2>&1 | tee "$log_file"; then
    return 0
  else
    return 1
  fi
}

# ============================================================
# Phase 1: Plan
# ============================================================
log_phase "PHASE 1/3: PLAN"

if ! run_claude "plan" "/plan $TASK"; then
  log_fail "Plan phase failed. Check ${LOG_DIR}/plan.log"
  exit 1
fi

log_success "Plan phase complete"

# ============================================================
# Phase 2: Develop
# ============================================================
log_phase "PHASE 2/3: DEVELOP"

if ! run_claude "develop" "/develop $TASK"; then
  log_fail "Develop phase failed. Check ${LOG_DIR}/develop.log"
  exit 1
fi

log_success "Develop phase complete"

# ============================================================
# Phase 3: Review
# ============================================================
log_phase "PHASE 3/3: REVIEW"

if ! run_claude "review" "/review $TASK"; then
  log_fail "Review phase failed. Check ${LOG_DIR}/review.log"
  exit 1
fi

# Check verdict
REVIEW_LOG="${LOG_DIR}/review.log"

if grep -qi "REQUEST_CHANGES\|request.changes" "$REVIEW_LOG" 2>/dev/null; then
  log_fail "Review verdict: REQUEST_CHANGES"
  echo ""
  echo "Review output: $REVIEW_LOG"
  echo ""
  echo "Next steps:"
  echo "  1. Read the review: cat $REVIEW_LOG"
  echo "  2. Fix: /develop $TASK — REQUEST_CHANGES 수정"
  echo "  3. Re-review: /review $TASK"
  exit 1
fi

if grep -qi "APPROVE" "$REVIEW_LOG" 2>/dev/null; then
  log_success "Review verdict: APPROVE"
fi

# ============================================================
# Done
# ============================================================
echo ""
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}  TASK COMPLETE: $TASK${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo ""
echo "Logs: $LOG_DIR/{plan,develop,review}.log"
