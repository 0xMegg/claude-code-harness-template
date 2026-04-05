# Claude Code Harness Template v4

Claude Code & Cowork 마스터 가이드(583p) 기반 재사용 가능 작업 환경 템플릿.

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

### Step 4: 개발 시작

#### 방법 A: 자동 실행 (권장)

한 커맨드로 Plan → Develop → Review를 각각 새 세션에서 순차 실행:

```bash
# 단일 태스크
./scripts/run-task.sh "Task 1 — 회원가입 폼 빈값 제출 버그 수정"

# Epic (분해 + 각 Slice 자동 실행)
./scripts/run-epic.sh "Epic 1 — 다이브 로그 입력 화면 전체 구현"
```

- 문제 없으면 자동으로 3단계 완료 (커밋+푸시 포함)
- REQUEST_CHANGES → 해당 Slice에서 멈추고 리뷰 내용 출력
- 로그: `/tmp/프로젝트명-run/{plan,develop,review}.log`

#### 방법 B: 수동 실행 (세밀한 제어)

각 단계를 별도 세션에서 수동으로:
```
/plan Task 1 — 회원가입 폼 빈값 제출 버그 수정
/develop Task 1 — 회원가입 폼 빈값 제출 버그 수정
/review Task 1 — 회원가입 폼 빈값 제출 버그 수정
```

**REQUEST_CHANGES가 나오면:**
```
/develop Task 1 — REQUEST_CHANGES 수정사항 반영
/review Task 1 — 재검사
```

### 전체 흐름

```
기획안 작성 + setup.sh 실행
  ↓
초기화 세션: 기획안 읽고 하네스 설정 완성
  ↓
자동: ./scripts/run-epic.sh "Epic N — 기능"  (Epic 분해 + Slice별 3-Role 자동)
수동: /plan → /develop → /review             (세밀한 제어가 필요할 때)
  ↓
(handoff/latest.md + decision-log.md가 자동 업데이트되어 세션 간 상태 유지)
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

| 세션 | 언제 쓰는지 | 커맨드 |
|------|-----------|--------|
| **초기화** | 프로젝트 시작할 때 1번 | `"기획안 읽고 placeholder 채워줘"` |
| **Epic 분해** | 큰 기능 시작할 때 | `/plan Epic N — [기능 설명]` |
| **Planner** | Task/Slice마다 첫 번째 | `/plan Task N — [설명]` |
| **Developer** | Task마다 두 번째 | `/develop Task N — [설명]` |
| **Reviewer** | Task마다 세 번째 | `/review Task N — [설명]` |
| **일반** | 간단한 질문/수정 | 역할 지정 없이 자유롭게 |
| **블로그** | 기술 블로그 초안 | `/blog` 또는 `/blog [주제]` |

---

## 구조

```
project/
├── CLAUDE.md                              # 프로젝트 계약서 (AI 진입점, ~50줄)
├── .claude/
│   ├── settings.json                      # 권한/안전 설정
│   ├── hooks/
│   │   ├── block-dangerous.sh             # PreToolUse: 위험 명령 차단
│   │   ├── post-edit-check.sh             # PostToolUse: BLOCK/WARN 심각도 분리
│   │   ├── post-edit-lint.sh              # PostToolUse: 자동 lint (프로젝트 자동 감지)
│   │   └── post-edit-test.sh              # PostToolUse: 변경 영역 타겟 테스트 자동 실행
│   ├── commands/
│   │   ├── plan.md                        # /plan: Planner 역할 진입
│   │   ├── develop.md                     # /develop: Developer 역할 진입
│   │   ├── review.md                      # /review: Reviewer 역할 진입
│   │   └── blog.md                        # /blog: 기술 블로그 초안
│   └── rules/
│       ├── api.md                         # API/DB 규칙
│       ├── frontend.md                    # UI 규칙
│       ├── testing.md                     # 테스트 규칙
│       ├── git.md                         # 커밋/브랜치 규칙
│       └── gotchas.md                     # 프로젝트 고유 함정 (CLAUDE.md에서 분리)
├── context/
│   ├── about-me.md                        # 프로젝트 배경
│   ├── working-rules.md                   # 작업 원칙 + 3-Role Protocol
│   └── decision-log.md                    # 결정 기록 (재논의 방지)
├── templates/
│   ├── role-planner.md                    # Planner 역할
│   ├── role-developer.md                  # Developer 역할
│   ├── role-reviewer.md                   # Reviewer 역할
│   ├── epic-plan.md                       # Epic → Slice 분해 형식
│   ├── plan.md                            # 작업 계획 형식 (per slice/task)
│   ├── verify.md                          # 검증 계획 형식
│   ├── handoff.md                         # 세션 인수인계 형식
│   └── bug-fix.md                         # 버그 수정 형식
├── skills/
│   ├── bug-fix/
│   │   ├── SKILL.md                       # 버그 수정 워크플로
│   │   └── examples/good-output.md        # 좋은 버그 수정 예시 (프로젝트별 교체)
│   └── code-review/
│       ├── SKILL.md                       # 코드 리뷰 워크플로
│       └── examples/good-output.md        # 좋은 리뷰 예시 (프로젝트별 교체)
├── handoff/
│   └── latest.md                          # 현재 상태 (세션 간 연결고리)
├── outputs/
│   ├── plans/                             # Planner 산출물
│   ├── reviews/                           # Reviewer 산출물
│   └── archive/                           # 해결된 과거 문서
├── scripts/
│   ├── run-task.sh                        # 단일 Task 자동 실행 (Plan→Develop→Review)
│   └── run-epic.sh                        # Epic 분해 + Slice별 자동 실행
├── docs/
│   └── project-plan.md                    # 프로젝트 기획안 양식
├── PlaceholderGuide.md                    # 초기화 세션용: placeholder 채우기 가이드
├── setup.sh                               # 새 프로젝트 초기화 스크립트
└── README.md
```

### 문서 역할 구분

| 문서 | 용도 |
|------|------|
| `README.md` | 시작 가이드, 사용법 |
| `docs/project-plan.md` | 프로젝트 기획안 양식 |
| `PlaceholderGuide.md` | 초기화 세션에서 placeholder 채우기 규칙 |
| 나머지 전부 | 세션마다 자동으로 읽고 따르는 하네스 파일 |

---

## 파일 간 연결 구조

```
CLAUDE.md (AI 진입점)
  ├── context/about-me.md ← 프로젝트 배경
  ├── context/working-rules.md ← 3-Role Protocol 정의
  ├── handoff/latest.md ← 세션 간 연결고리
  │     ↑ Planner 쓰기 → Developer 읽기 → Reviewer 쓰기
  ├── templates/role-*.md ← 각 역할의 행동 규칙
  │     ├── role-planner.md → outputs/plans/ (plan + verify)
  │     ├── role-developer.md → handoff/latest.md (커밋 안 함)
  │     └── role-reviewer.md → outputs/reviews/ + git commit+push
  ├── .claude/commands/ ← 슬래시 커맨드 (/plan, /develop, /review, /blog)
  ├── .claude/rules/ ← 자동 적용 규칙
  ├── .claude/hooks/ ← 자동 안전 검사
  └── .claude/settings.json ← 권한 + hook 연결
```

---

## v3 → v4 변경사항

| 개선 | v3 | v4 |
|------|----|----|
| 편집 후 검사 | 전부 WARNING (exit 0) | **BLOCK/WARN 심각도 분리** — 시크릿, 금지패턴은 exit 2로 블로킹 |
| 편집 후 테스트 | 없음 (수동 실행) | **post-edit-test.sh** — 변경 영역 대응 테스트 자동 실행 |
| CLAUDE.md | ~90줄 (Gotchas, Templates 등 포함) | **~50줄로 다이어트** — Gotchas → rules/gotchas.md 분리 |
| Gotchas | CLAUDE.md 본문에 포함 | **rules/gotchas.md로 분리** — auto-applied rule로 승격 |
| 금지 패턴 | 훅에 하드코딩 또는 없음 | **BLOCKED_PATTERNS 배열** — 프로젝트별 설정 가능 |

## v2 → v3 변경사항

| 개선 | v2 | v3 |
|------|----|----|
| 역할 진입 | 매번 긴 프롬프트 입력 | **`/plan`, `/develop`, `/review` 슬래시 커맨드** |
| 검증 계획 | plan.md 내 Acceptance Criteria | **독립 `templates/verify.md` + Planner가 작성** |
| 편집 후 lint | 수동 실행 | **PostToolUse hook 자동 실행 (프로젝트 자동 감지)** |
| 세션 관리 | 언급 없음 | **working-rules.md에 continue/resume/fork/worktree 지침** |
| /compact 지침 | 없음 | **Compact Rules로 보존 항목 사전 정의** |
| Gotchas | 없음 | **CLAUDE.md에 프로젝트 고유 함정 섹션** |
| Skill 구조 | SKILL.md만 | **examples/ 폴더 추가 (좋은 결과 감각 제공)** |

## v1 → v2 변경사항

| 개선 | v1 | v2 |
|------|----|----|
| 워크플로우 | 단일 세션 | **3-Role (Planner → Developer → Reviewer)** |
| 커밋 권한 | 명시 없음 | **Reviewer만 APPROVE 후 커밋+푸시** |
| settings.json | Read/Write만 허용 | **git, lint, test Bash 자동 허가** |
| 산출물 관리 | outputs/ 단일 폴더 | **outputs/plans/, reviews/, archive/ 분리** |
| 브랜치 규칙 | "main 직접 푸시 금지" 고정 | **Solo/협업 구분** |
| 파일 간 연결 | 일부만 참조 | **전체 구조 참조** |
| 초기화 | placeholder 직접 채움 | **초기화 세션에서 자동 채움** |

---

## 가이드북 매핑

| 파일 | 가이드북 근거 |
|------|-------------|
| `CLAUDE.md` | 3.7 (7일 세팅), 5.3 (운영 원칙) |
| `settings.json` | 3.14 (보안), 5.10 (하네스 요소) |
| `hooks/` | 2장 (Hook 개념), 5.10 (자동 개입), 5.6 (도구 출력 예산) |
| `commands/` | 6.1 (Skill 트리거), 가이드북 운영 원칙 (반복 비용 절감) |
| `verify.md` | 5.11 (검증 계층), 5.10 ("무엇으로 확인할지 먼저 정한다") |
| `rules/` | 5.4 (Rules 분리), 5.5 (컨텍스트 엔지니어링) |
| `context/` | 3.17 (스타터 번들), 5.2 (작업공간 설계) |
| `templates/` | 3.9 (템플릿 역할), 4.3 (실전 프롬프트) |
| `role-*.md` | 4.5 (역할 분리), 5.8 (에이전트 팀 패턴) |
| `skills/` | 6.1-6.3 (Skill 설계), 6.7 (필요성) |
| `handoff/` | 5.7 (Handoff > 세션 압축) |
| `outputs/` | 5.2 (산출물 관리) |

## 하네스 5요소 (가이드북 기준)

1. **Permissions** — settings.json → allow/deny/ask 라우팅
2. **Validation** — hooks/ → 사전 차단(block-dangerous) + 사후 검증(check/lint/test)
3. **Execution Mode** — commands/ → 3-Role 분리 (plan/develop/review 별도 세션)
4. **State Maintenance** — handoff/ → 세션 간 연결고리, context/ → 배경 지식
5. **Decision Trace** — decision-log.md → 의사결정 근거 기록 (재논의 방지)
