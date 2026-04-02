#!/bin/bash
# Hook: Automatic checks after file edits (PostToolUse)
#
# Checks:
# - .env file modification (secret protection)
# - Hardcoded secret patterns (API keys, passwords, tokens)

INPUT="$1"

# Detect .env file modifications
if echo "$INPUT" | grep -qE '\.env'; then
  echo "WARNING: .env file was modified. Verify no secrets were exposed."
fi

# Detect hardcoded secret patterns
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
