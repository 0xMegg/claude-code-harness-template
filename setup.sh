#!/bin/bash
# Claude Code Harness v2 Setup Script
# 가이드북 3.7 "7일 세팅 로드맵" 기반 + 3-Role Workflow
#
# 사용법:
#   1. 새 프로젝트 디렉토리에서 실행
#   2. /path/to/setup.sh [project-name]
#   3. 생성된 파일의 {{PLACEHOLDER}} 값을 채우기

set -e

PROJECT_NAME="${1:-my-project}"
TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$(pwd)"

echo "=== Claude Code Harness v2 Setup ==="
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
echo "[1/6] Creating directory structure..."
mkdir -p "$TARGET_DIR/.claude/hooks"
mkdir -p "$TARGET_DIR/.claude/rules"
mkdir -p "$TARGET_DIR/context"
mkdir -p "$TARGET_DIR/templates"
mkdir -p "$TARGET_DIR/outputs/plans"
mkdir -p "$TARGET_DIR/outputs/reviews"
mkdir -p "$TARGET_DIR/outputs/archive"
mkdir -p "$TARGET_DIR/handoff"
mkdir -p "$TARGET_DIR/skills/bug-fix"
mkdir -p "$TARGET_DIR/skills/code-review"

# 핵심 파일 복사
echo "[2/6] Copying core files..."
cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
cp "$TEMPLATE_DIR/.claude/settings.json" "$TARGET_DIR/.claude/settings.json"

# Hook 스크립트 복사 및 실행 권한
echo "[3/6] Setting up hooks..."
cp "$TEMPLATE_DIR/.claude/hooks/"*.sh "$TARGET_DIR/.claude/hooks/"
chmod +x "$TARGET_DIR/.claude/hooks/"*.sh

# Rules 파일 복사
echo "[4/6] Copying rules..."
cp "$TEMPLATE_DIR/.claude/rules/"*.md "$TARGET_DIR/.claude/rules/"

# 컨텍스트, 템플릿, 스킬 복사
echo "[5/6] Copying context, templates, and skills..."
cp "$TEMPLATE_DIR/context/"*.md "$TARGET_DIR/context/"
cp "$TEMPLATE_DIR/templates/"*.md "$TARGET_DIR/templates/"
cp "$TEMPLATE_DIR/skills/bug-fix/SKILL.md" "$TARGET_DIR/skills/bug-fix/SKILL.md"
cp "$TEMPLATE_DIR/skills/code-review/SKILL.md" "$TARGET_DIR/skills/code-review/SKILL.md"

# PlaceholderGuide 복사 (AI가 초기화 세션에서 참고)
if [ -f "$TEMPLATE_DIR/PlaceholderGuide.md" ]; then
  cp "$TEMPLATE_DIR/PlaceholderGuide.md" "$TARGET_DIR/PlaceholderGuide.md"
fi

# 기획안 양식 복사
mkdir -p "$TARGET_DIR/docs"
if [ -f "$TEMPLATE_DIR/docs/project-plan.md" ]; then
  cp "$TEMPLATE_DIR/docs/project-plan.md" "$TARGET_DIR/docs/project-plan.md"
fi

# 프로젝트명 치환
echo "[6/6] Replacing project name..."
FILES_TO_REPLACE=(
  "$TARGET_DIR/CLAUDE.md"
  "$TARGET_DIR/context/about-me.md"
  "$TARGET_DIR/templates/role-planner.md"
  "$TARGET_DIR/templates/role-developer.md"
  "$TARGET_DIR/templates/role-reviewer.md"
)

for file in "${FILES_TO_REPLACE[@]}"; do
  if [ -f "$file" ]; then
    sed -i '' "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$file" 2>/dev/null || \
    sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$file" 2>/dev/null || true
  fi
done

# 초기 handoff 파일 생성
cat > "$TARGET_DIR/handoff/latest.md" << EOF
# Session Handoff

## Date
$(date +%Y-%m-%d)

## Current State
Project initialized with Claude Code harness v2 template.

## Task Queue
### 다음 단계
1. CLAUDE.md의 {{PLACEHOLDER}} 값 채우기 (빌드/테스트 명령 필수)
2. context/about-me.md 프로젝트 설명 채우기
3. templates/role-*.md의 {{PLACEHOLDER}} 값 채우기
4. .claude/rules/ 프로젝트에 맞게 수정
5. 첫 Task 시작

## Notes
- Harness template version: 2.0.0
- 3-Role Workflow: Planner → Developer → Reviewer
EOF

# .gitignore 추가 (없을 때만)
if [ ! -f "$TARGET_DIR/.gitignore" ]; then
  cat > "$TARGET_DIR/.gitignore" << 'EOF'
# Claude Code
.claude/settings.local.json

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
echo "=== Setup Complete (v2.0.0) ==="
echo ""
echo "Next steps:"
echo "  1. 기획안을 docs/project-plan.md에 작성 (또는 기존 기획서를 docs/에 넣기)"
echo "  2. 초기화 세션 실행:"
echo ""
echo "     claude \"docs/에 있는 기획안을 읽고, PlaceholderGuide.md를 참고해서"
echo "     하네스의 모든 {{PLACEHOLDER}}를 채워줘."
echo "     대상: CLAUDE.md, context/about-me.md, templates/role-*.md"
echo "     그리고 .claude/rules/와 .claude/hooks/post-edit-check.sh도"
echo "     이 프로젝트에 맞게 수정해줘.\""
echo ""
echo "  3. 개발 시작:"
echo "     claude \"templates/role-planner.md 역할로 Task 1 진행해.\""
echo "     claude \"templates/role-developer.md 역할로 Task 1 구현해.\""
echo "     claude \"templates/role-reviewer.md 역할로 Task 1 검사해.\""
echo ""
echo "Files created:"
find "$TARGET_DIR" -not -path "*/node_modules/*" -not -path "*/.git/*" \
  \( -name "*.md" -o -name "*.json" -o -name "*.sh" \) | \
  sed "s|$TARGET_DIR/||" | sort | head -30
