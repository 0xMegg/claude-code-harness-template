# Claude Code Harness Template v2

Claude Code & Cowork 마스터 가이드(583p) 기반 재사용 가능 작업 환경 템플릿.

## v1 → v2 변경사항

| 개선 | v1 | v2 |
|------|----|----|
| 워크플로우 | 단일 세션 | **3-Role (Planner → Developer → Reviewer)** |
| 커밋 권한 | 명시 없음 | **Reviewer만 APPROVE 후 커밋+푸시** |
| settings.json | Read/Write만 허용 | **git, lint, test Bash 명령 자동 허가** |
| 산출물 관리 | outputs/ 단일 폴더 | **outputs/plans/, reviews/, archive/ 분리** |
| Session Protocol | 한 AI가 전부 수행 | **역할별 분리 + 일반 세션 fallback** |
| 브랜치 규칙 | "main 직접 푸시 금지" 고정 | **Solo/협업 구분** |
| 커밋 형식 | `type: description` | **`type: Task N — 변경 요약`** |
| 파일 간 연결 | CLAUDE.md에서 일부만 참조 | **전체 구조 참조 (roles, rules, skills, outputs)** |

## 구조

```
project/
├── CLAUDE.md                              # 프로젝트 계약서
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
│   ├── role-planner.md                    # Planner 역할 (NEW in v2)
│   ├── role-developer.md                  # Developer 역할 (NEW in v2)
│   ├── role-reviewer.md                   # Reviewer 역할 (NEW in v2)
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
├── setup.sh                               # 새 프로젝트 초기화 스크립트
├── PlaceholderGuide.md                    # {{PLACEHOLDER}} 채우기 가이드
└── README.md
```

## 사용법

### 새 프로젝트에 적용

```bash
cd /path/to/your-project
/path/to/claude-code-harness-template/setup.sh my-project-name
```

### 적용 후 해야 할 것

1. `CLAUDE.md` — `{{PLACEHOLDER}}` 값 채우기 (빌드/테스트 명령 **필수**)
2. `context/about-me.md` — 프로젝트 설명 채우기
3. `templates/role-*.md` — `{{LINT_CMD}}`, `{{TEST_CMD}}` 등 프로젝트 명령으로 교체
4. `.claude/rules/` — 프로젝트에 맞지 않는 규칙 수정/삭제
5. `.claude/hooks/post-edit-check.sh` — 프로젝트 특화 검사 패턴 추가

### 3-Role Workflow 사용

```bash
# 1. Planner — 읽기 전용, 계획 작성
claude "templates/role-planner.md 역할로 Task 1 진행해."

# 2. Developer — 구현 + 검증 (커밋 안 함)
claude "templates/role-developer.md 역할로 Task 1 구현해."

# 3. Reviewer — 검사 + APPROVE 시 커밋+푸시
claude "templates/role-reviewer.md 역할로 Task 1 검사해."
```

**REQUEST_CHANGES가 나오면:**
```bash
# Developer 다시 → Reviewer 다시 (APPROVE될 때까지)
claude "templates/role-developer.md 역할로 Task 1 수정사항 반영해."
claude "templates/role-reviewer.md 역할로 Task 1 재검사해."
```

## 파일 간 연결 구조

```
CLAUDE.md (진입점)
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
