#!/bin/bash
# Claude Code Harness Setup Script
# 가이드북 3.7 "7일 세팅 로드맵" 기반
#
# 사용법:
#   1. 새 프로젝트 디렉토리에서 실행
#   2. ./setup.sh [project-name]
#   3. 생성된 파일의 {{PLACEHOLDER}} 값을 채우기

set -e

PROJECT_NAME="${1:-my-project}"
TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$(pwd)"

echo "=== Claude Code Harness Setup ==="
echo "Project: $PROJECT_NAME"
echo "Target:  $TARGET_DIR"
echo ""

# 이미 CLAUDE.md가 있으면 경고
if [ -f "$TARGET_DIR/CLAUDE.md" ]; then
  echo "WARNING: CLAUDE.md already exists in $TARGET_DIR"
  read -p "Overwrite? (y/N): " confirm
  if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Aborted."
    exit 1
  fi
fi

# 디렉토리 구조 생성
echo "[1/5] Creating directory structure..."
mkdir -p "$TARGET_DIR/.claude/hooks"
mkdir -p "$TARGET_DIR/.claude/rules"
mkdir -p "$TARGET_DIR/context"
mkdir -p "$TARGET_DIR/templates"
mkdir -p "$TARGET_DIR/outputs"
mkdir -p "$TARGET_DIR/handoff"
mkdir -p "$TARGET_DIR/skills"

# 핵심 파일 복사
echo "[2/5] Copying core files..."
cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
cp "$TEMPLATE_DIR/.claude/settings.json" "$TARGET_DIR/.claude/settings.json"

# Hook 스크립트 복사 및 실행 권한
echo "[3/5] Setting up hooks..."
cp "$TEMPLATE_DIR/.claude/hooks/"*.sh "$TARGET_DIR/.claude/hooks/"
chmod +x "$TARGET_DIR/.claude/hooks/"*.sh

# Rules 파일 복사
echo "[4/5] Copying rules..."
cp "$TEMPLATE_DIR/.claude/rules/"*.md "$TARGET_DIR/.claude/rules/"

# 컨텍스트 및 템플릿 복사
echo "[5/5] Copying context and templates..."
cp "$TEMPLATE_DIR/context/"*.md "$TARGET_DIR/context/"
cp "$TEMPLATE_DIR/templates/"*.md "$TARGET_DIR/templates/"

# Skills 복사
if [ -d "$TEMPLATE_DIR/skills" ]; then
  cp -r "$TEMPLATE_DIR/skills/"* "$TARGET_DIR/skills/" 2>/dev/null || true
fi

# 프로젝트명 치환
sed -i '' "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TARGET_DIR/CLAUDE.md" 2>/dev/null || \
sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TARGET_DIR/CLAUDE.md" 2>/dev/null || true

sed -i '' "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TARGET_DIR/context/about-me.md" 2>/dev/null || \
sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TARGET_DIR/context/about-me.md" 2>/dev/null || true

# 초기 handoff 파일 생성
cat > "$TARGET_DIR/handoff/latest.md" << EOF
# Session Handoff

## Date
$(date +%Y-%m-%d)

## Current State
Project initialized with Claude Code harness template.

## What's Next
1. Fill in {{PLACEHOLDER}} values in CLAUDE.md
2. Fill in context/about-me.md with project details
3. Review and customize .claude/rules/ for this project
4. Start first task

## Notes
- Harness template version: 1.0.0
- Based on: Claude Code & Cowork Master Guide
EOF

# .gitignore 추가
if [ ! -f "$TARGET_DIR/.gitignore" ]; then
  cat > "$TARGET_DIR/.gitignore" << EOF
# Claude Code
.claude/settings.local.json
outputs/
handoff/

# Environment
.env
.env.local
.env.*.local

# Dependencies
node_modules/

# Build
dist/
build/
.next/
EOF
  echo "Created .gitignore"
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md — fill in build/test commands and tech stack"
echo "  2. Edit context/about-me.md — describe your project"
echo "  3. Review .claude/rules/ — customize for your stack"
echo "  4. Start Claude Code in this directory"
echo ""
echo "Template structure:"
find "$TARGET_DIR" -not -path "*/node_modules/*" -not -path "*/.git/*" \
  \( -name "*.md" -o -name "*.json" -o -name "*.sh" \) | \
  sed "s|$TARGET_DIR/||" | sort | head -30
