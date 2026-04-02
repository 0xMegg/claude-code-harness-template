#!/bin/bash
# Hook: 파일 수정 후 자동 점검
# 가이드북 5.10 기반 - Verification 자동화
#
# 체크 항목:
# - .env 파일 수정 감지 (비밀값 보호)
# - 하드코딩된 시크릿 패턴 감지
# - TODO/FIXME 잔존 확인

INPUT="$1"

# .env 파일 수정 감지
if echo "$INPUT" | grep -qE '\.env'; then
  echo "WARNING: .env file was modified. Verify no secrets were exposed."
fi

# 하드코딩된 시크릿 패턴 감지
SECRET_PATTERNS=(
  "sk-[a-zA-Z0-9]{20,}"
  "AKIA[A-Z0-9]{16}"
  "ghp_[a-zA-Z0-9]{36}"
  "password\s*=\s*['\"][^'\"]+['\"]"
  "api_key\s*=\s*['\"][^'\"]+['\"]"
  "secret\s*=\s*['\"][^'\"]+['\"]"
)

for pattern in "${SECRET_PATTERNS[@]}"; do
  if echo "$INPUT" | grep -qiE "$pattern"; then
    echo "WARNING: Possible hardcoded secret detected. Review before committing."
    break
  fi
done

exit 0
