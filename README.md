# Claude Code Harness Template v2

Claude Code & Cowork 마스터 가이드(583p) 기반 재사용 가능 작업 환경 템플릿.

> **인간은 이 README.md만 읽으면 됩니다.** 나머지 문서는 Claude가 알아서 읽고 처리합니다.

---

## 새 프로젝트 시작하기

### 준비물
- 이 템플릿 레포
- 프로젝트 기획안 (자유 형식 OK, `docs/project-plan.md` 양식 제공)
- Claude Code CLI (`claude`)

### Step 1: 프로젝트 생성 + 하네스 복사

```bash
mkdir my-new-app && cd my-new-app
git init

# 하네스 복사 (프로젝트 이름을 인자로)
/path/to/claude-code-harness-template/setup.sh my-new-app
```

### Step 2: 기획안 넣기

```bash
# 방법 A: 양식 복사 후 직접 채우기
cp /path/to/claude-code-harness-template/docs/project-plan.md docs/project-plan.md

# 방법 B: 기존 기획서가 있으면 그냥 docs/에 넣기
cp ~/my-plan.pdf docs/
cp ~/my-plan.md docs/
```

### Step 3: 초기화 세션 (Claude가 하네스 설정을 채움)

```bash
claude "docs/에 있는 기획안을 읽고, PlaceholderGuide.md를 참고해서
하네스의 모든 {{PLACEHOLDER}}를 채워줘.
대상: CLAUDE.md, context/about-me.md, templates/role-*.md
그리고 .claude/rules/와 .claude/hooks/post-edit-check.sh도
이 프로젝트에 맞게 수정해줘."
```

> 이 세션이 끝나면 하네스가 프로젝트에 맞게 완성됩니다.

### Step 4: 개발 시작 (3-Role 반복)

```bash
# 1. Planner — 계획 작성 (코드 읽기만)
claude "templates/role-planner.md 역할로 Task 1 진행해."

# 2. Developer — 구현 + 검증 (커밋 안 함)
claude "templates/role-developer.md 역할로 Task 1 구현해."

# 3. Reviewer — 검사 후 APPROVE 시 자동 커밋+푸시
claude "templates/role-reviewer.md 역할로 Task 1 검사해."
```

**REQUEST_CHANGES가 나오면:**
```bash
claude "templates/role-developer.md 역할로 Task 1 수정사항 반영해."
claude "templates/role-reviewer.md 역할로 Task 1 재검사해."
```

### 전체 흐름

```
[인간] 기획안 작성 + setup.sh 실행
  ↓
[초기화 세션] Claude가 기획안 읽고 하네스 설정 완성
  ↓
[Planner] → [Developer] → [Reviewer] 반복
  ↓
(handoff/latest.md가 자동 업데이트되어 세션 간 상태 유지)
```

---

## 기존 프로젝트에 적용하기

```bash
cd /path/to/existing-project
/path/to/claude-code-harness-template/setup.sh my-existing-app

# 초기화 세션에서 기존 코드 분석도 요청
claude "이 프로젝트의 코드를 분석하고, PlaceholderGuide.md를 참고해서
하네스의 모든 {{PLACEHOLDER}}를 채워줘.
대상: CLAUDE.md, context/about-me.md, templates/role-*.md
그리고 .claude/rules/와 .claude/hooks/post-edit-check.sh도
이 프로젝트에 맞게 수정해줘.
추가로 프로젝트의 좋은 점, 개선할 점, 바로 고쳐야 할 점을 분석해서
handoff/latest.md에 Task Queue로 정리해줘."
```

---

## 세션 종류 요약

| 세션 | 언제 쓰는지 | 프롬프트 |
|------|-----------|---------|
| **초기화** | 프로젝트 시작할 때 1번 | `"기획안 읽고 placeholder 채워줘"` |
| **Planner** | Task마다 첫 번째 | `"role-planner.md 역할로 Task N 진행해"` |
| **Developer** | Task마다 두 번째 | `"role-developer.md 역할로 Task N 구현해"` |
| **Reviewer** | Task마다 세 번째 | `"role-reviewer.md 역할로 Task N 검사해"` |
| **일반** | 간단한 질문/수정 | 역할 지정 없이 자유롭게 |

---

## 구조

```
project/
├── CLAUDE.md                              # 프로젝트 계약서 (AI 진입점)
├── .claude/
│   ├── settings.json                      # 권한/안전 설정
│   ├── hooks/
│   │   ├── block-dangerous.sh             # PreToolUse: 위험 명령 차단
│   │   └── post-edit-check.sh             # PostToolUse: 시크릿 감지
│   └── rules/
│       ├── api.md                         # API/DB 규칙
│       ├── frontend.md                    # UI 규칙
│       ├── testing.md                     # 테스트 규칙
│       └── git.md                         # 커밋/브랜치 규칙
├── context/
│   ├── about-me.md                        # 프로젝트 배경
│   └── working-rules.md                   # 작업 원칙 + 3-Role Protocol
├── templates/
│   ├── role-planner.md                    # Planner 역할
│   ├── role-developer.md                  # Developer 역할
│   ├── role-reviewer.md                   # Reviewer 역할
│   ├── plan.md                            # 작업 계획 형식
│   ├── handoff.md                         # 세션 인수인계 형식
│   └── bug-fix.md                         # 버그 수정 형식
├── skills/
│   ├── bug-fix/SKILL.md                   # 버그 수정 워크플로
│   └── code-review/SKILL.md              # 코드 리뷰 워크플로
├── handoff/
│   └── latest.md                          # 현재 상태 (세션 간 연결고리)
├── outputs/
│   ├── plans/                             # Planner 산출물
│   ├── reviews/                           # Reviewer 산출물
│   └── archive/                           # 해결된 과거 문서
├── docs/
│   └── project-plan.md                    # 프로젝트 기획안 양식
├── PlaceholderGuide.md                    # AI용: placeholder 채우기 가이드
├── setup.sh                               # 새 프로젝트 초기화 스크립트
└── README.md                              # 인간용: 이 문서
```

### 문서 역할 구분

| 문서 | 누가 읽는지 | 용도 |
|------|-----------|------|
| `README.md` | **인간** | 시작 가이드, 사용법 |
| `PlaceholderGuide.md` | **AI (초기화 세션)** | placeholder 채우기 규칙 |
| `docs/project-plan.md` | **인간 → AI** | 인간이 채우고, AI가 읽어서 하네스 설정 |
| 나머지 전부 | **AI** | 세션마다 자동으로 읽고 따름 |

---

## 파일 간 연결 구조

```
CLAUDE.md (AI 진입점)
  ├── context/about-me.md ← 프로젝트 배경
  ├── context/working-rules.md ← 3-Role Protocol 정의
  ├── handoff/latest.md ← 세션 간 연결고리
  │     ↑ Planner 쓰기 → Developer 읽기 → Reviewer 쓰기
  ├── templates/role-*.md ← 각 역할의 행동 규칙
  │     ├── role-planner.md → outputs/plans/
  │     ├── role-developer.md → handoff/latest.md (커밋 안 함)
  │     └── role-reviewer.md → outputs/reviews/ + git commit+push
  ├── .claude/rules/ ← 자동 적용 규칙
  ├── .claude/hooks/ ← 자동 안전 검사
  └── .claude/settings.json ← 권한 + hook 연결
```

---

## v1 → v2 변경사항

| 개선 | v1 | v2 |
|------|----|----|
| 워크플로우 | 단일 세션 | **3-Role (Planner → Developer → Reviewer)** |
| 커밋 권한 | 명시 없음 | **Reviewer만 APPROVE 후 커밋+푸시** |
| settings.json | Read/Write만 허용 | **git, lint, test Bash 자동 허가** |
| 산출물 관리 | outputs/ 단일 폴더 | **outputs/plans/, reviews/, archive/ 분리** |
| 브랜치 규칙 | "main 직접 푸시 금지" 고정 | **Solo/협업 구분** |
| 파일 간 연결 | 일부만 참조 | **전체 구조 참조** |
| 초기화 | 인간이 placeholder 직접 채움 | **초기화 세션에서 AI가 채움** |

---

## 가이드북 매핑

| 파일 | 가이드북 근거 |
|------|-------------|
| `CLAUDE.md` | 3.7 (7일 세팅), 5.3 (운영 원칙) |
| `settings.json` | 3.14 (보안), 5.10 (하네스 요소) |
| `hooks/` | 2장 (Hook 개념), 5.10 (자동 개입) |
| `rules/` | 5.4 (Rules 분리), 5.5 (컨텍스트 엔지니어링) |
| `context/` | 3.17 (스타터 번들), 5.2 (작업공간 설계) |
| `templates/` | 3.9 (템플릿 역할), 4.3 (실전 프롬프트) |
| `role-*.md` | 4.5 (역할 분리), 5.8 (에이전트 팀 패턴) |
| `skills/` | 6.1-6.3 (Skill 설계), 6.7 (필요성) |
| `handoff/` | 5.7 (Handoff > 세션 압축) |
| `outputs/` | 5.2 (산출물 관리) |

## 하네스 4요소

1. **Memoized Context** — CLAUDE.md, rules/, context/ → 매 턴마다 재사용
2. **Tool Orchestration** — settings.json → 도구 허용/차단
3. **Permission Gate** — hooks/ → 사전/사후 자동 점검
4. **Resumable Session** — handoff/ → 세션 이어받기
