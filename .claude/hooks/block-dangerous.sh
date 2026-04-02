#!/bin/bash
# Hook: 위험한 명령 사전 차단
# 가이드북 5.10, 6.8 기반 - Permission Gate 역할
#
# 차단 대상:
# - rm -rf (재귀 삭제)
# - git push --force / -f (강제 푸시)
# - git reset --hard (하드 리셋)
# - chmod 777 (과도한 권한)
# - 파이프를 통한 원격 스크립트 실행

INPUT="$1"

DANGEROUS_PATTERNS=(
  "rm -rf /"
  "rm -rf \*"
  "rm -rf ."
  "git push --force"
  "git push -f "
  "git reset --hard"
  "git clean -fd"
  "chmod 777"
  "curl.*|.*bash"
  "curl.*|.*sh"
  "wget.*|.*bash"
  "wget.*|.*sh"
  "DROP TABLE"
  "DROP DATABASE"
  "truncate "
  "> /dev/sd"
  "mkfs\."
  ":(){ :|:& };:"
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$INPUT" | grep -qiE "$pattern"; then
    echo "BLOCKED: Dangerous command detected matching pattern: $pattern"
    echo "Command: $INPUT"
    echo "Ask the user for explicit permission before running this command."
    exit 1
  fi
done

exit 0
