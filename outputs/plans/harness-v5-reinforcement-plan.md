# Harness v4 → v5 보강 계획서

가이드북(583p) 기준 대조 분석 결과, 누락된 7개 영역 + 병렬 git 반영 문제 1개를 보강합니다.

---

## 보강 1: 외부 통합 층 (MCP / Connector 정책)

### 현재 상태
- MCP 관련 파일이 전혀 없음
- settings.json에 MCP allowlist 없음

### 보강 내용

**A. `context/mcp-policy.md` 신규 생성**

```markdown
# MCP & External Integration Policy

## Allowed by Default
- Read, Edit, Write inside approved workspaces
- lint, test, build commands
- approved plugins from managed marketplace

## Requires Human Approval
- deployment to production
- customer-facing email/message send
- scheduled tasks with external side effects
- database writes to production
- new MCP server connection

## Blocked
- reading `.env*` files
- destructive shell commands
- unapproved MCP servers
- editing outside approved repositories

## MCP Evaluation Checklist
새로운 MCP를 연결하기 전 반드시 확인:
- [ ] 출처 확인 (공식 / 커뮤니티 / 개인)
- [ ] 필요한 권한 범위 (read-only vs read-write)
- [ ] 유지보수 상태 (최근 업데이트 날짜)
- [ ] 컨텍스트 비용 (도구 설명이 항상 올라오는가, 필요 시만 호출되는가)
- [ ] 조직 정책과의 충돌 여부

## 연결 원칙
- "무엇을 더 붙일까"보다 "이 연결이 사람이 하던 어떤 단계를 줄이는가" 먼저
- MCP는 길을 열어주는 층, Skill은 그 길을 어떤 방식으로 사용할지 정하는 층
- 연결은 많을수록 좋은 것이 아니라, 세션을 무겁게 만들지 않는 선에서 유지
```

**B. `settings.json`에 MCP 관련 deny 패턴 추가 (주석 가이드)**

```json
"deny": [
  // 기존 deny 유지...
  "mcp__*"  // 기본적으로 모든 MCP 차단, allow에 명시적으로 허용할 것만 추가
]
```

> 참고: 실제 프로젝트에서는 사용할 MCP만 allow에 추가하는 allowlist 방식 권장

---

## 보강 2: Verification Plan 강화

### 현재 상태
- `templates/verify.md` 존재하지만 가이드북 수준의 구체성 부족
- 완료 기준(Acceptance Criteria)과 검증 계획이 분리되어 있지 않음

### 보강 내용

**`templates/verify.md` 수정 — 가이드북의 TASK_CONTRACT 수준으로 업그레이드**

```markdown
# Verification Plan

## Task
[Task N] — [Task name]

## Completion Criteria (완료 기준)
모델과 사람이 같은 끝점을 보게 만드는 좌표.
- [ ] [기능적 완료 기준 1]
- [ ] [기능적 완료 기준 2]

## Automated Checks (기계적 확인)
순서대로 실행. 이전 단계 실패 시 다음 단계 진행하지 않음.
1. Lint/Analyze: `{{LINT_CMD}}`
2. Type check: `{{TYPECHECK_CMD}}`
3. Targeted test: `{{TEST_SINGLE_CMD}}` (변경 영역만)
4. Full test: `{{TEST_CMD}}`
5. Build: `{{BUILD_CMD}}`

## Manual Checks (사람 확인)
- [ ] [수동 검증 항목 — e.g., "빈 폼 제출 시 에러 메시지 확인"]
- [ ] [엣지 케이스 — e.g., "null/empty 입력으로 테스트"]
- [ ] [화면 검증 — e.g., "스크린샷 확인" or "로컬 UI에서 직접 확인"]

## Constraints (수정 금지 범위)
- 테스트 코드를 통과시키기 위해 테스트를 수정하지 말 것
- 다음 파일은 수정 금지: [보호 파일 목록]
- 화면 검증까지 끝나야 종료할 것

## Rollback Point
- Revert 대상: [특정 파일 또는 git revert 전략]
- 유지 가능: [롤백해도 남겨도 되는 파일]

## Report Format
검증 완료 후 아래 형식으로 기록:
- What changed: [변경 사항]
- What passed: [통과 항목]
- What failed: [실패 항목]
- What needs human confirmation: [사람 확인 필요 항목]
- Confidence level: HIGH / MEDIUM / LOW
```

**변경 포인트:**
- Completion Criteria 섹션 추가 (가이드북: "완료 기준은 모델과 사람이 같은 끝점을 보게 만드는 최소한의 좌표")
- 자동화 검사 순서 명시 (낮은 비용부터 차례로)
- Type check 단계 추가
- Constraints 섹션 추가 ("테스트는 고치지 말 것" 같은 수정 금지 규칙)
- Confidence level 추가

---

## 보강 3: 토큰 경제학 & 컨텍스트 관리 가이드

### 현재 상태
- `context/working-rules.md`에 Compact Rules만 있음
- 토큰 관리, 세션 분리, 컨텍스트 비용 관련 지침 없음

### 보강 내용

**`context/working-rules.md`에 다음 섹션 추가:**

```markdown
## Token & Context Management

### 핵심 원칙
토큰은 비용이면서 집중력(attention budget) 문제다.
절약보다 집중 — 필요한 것만 조합한다.

### 컨텍스트 구성 (항상 vs 필요 시)
| 항상 상주 | 필요 시만 열기 |
|-----------|---------------|
| CLAUDE.md | 긴 참고 문서, 사례집 |
| 짧은 공통 규칙 (rules/) | 세부 라이브러리 레퍼런스 |
| 핵심 명령, 프로젝트 구조 | 오래된 설계 문서 |
| handoff/latest.md | outputs/archive/ |

### 토큰 비용이 커지는 5가지 구간
1. 너무 긴 CLAUDE.md와 상시 규칙 파일
2. 범위가 모호한 프롬프트 ("알아서 해 줘")
3. 긴 세션 누적 (작업 경계 바뀌면 세션도 끊기)
4. 과도한 도구 출력 (테스트 전체 로그, 검색 결과 수백 줄)
5. 한 세션에서 너무 많은 역할 동시 수행

### 모델 사용 분리
- 강한 모델 (Opus): 설계, 논문 이해, 큰 구조 판단
- 균형형 모델 (Sonnet): 구현, 검색, 파일 확인, 단순 수정

### 세션 분리 기준
- 작업 경계가 바뀌면 세션도 끊기
- /compact → 같은 세션 이어가기 (빠르지만 세션 피로 완전 제거 못함)
- 리셋 (새 세션) → handoff와 plan이 더 단단해야 함 (깨끗한 출발점)
- 압축 뒤에는 바로 이어서 밀어붙기보다, 현재 task plan과 관련 파일을 다시 읽고 시작

### MCP 상주 비용
- 도구 설명과 출력이 컨텍스트를 미리 차지
- 자주 안 쓰는 MCP는 꺼두기
- 같은 작업이라도 무거운 통합보다 필요 시 CLI 호출이 가벼울 수 있음

### CLAUDE.md 관리
- 같은 실수가 반복되면 규칙에 반영
- 이미 잘 지키는 상식까지 길게 적지 않음
- 규칙 파일은 많을수록 좋은 설명서가 아니라, 계속 틀리는 지점을 줄여주는 짧은 운영 문서
```

---

## 보강 4: Skills 정밀화

### 현재 상태
- bug-fix, code-review 2개만 존재
- SKILL.md에 name, description 있지만 가이드북 수준의 anatomy 부족
- trigger 표현이 단일 문장, 오발동 방지 설계 없음
- examples/는 placeholder만 있음

### 보강 내용

**A. 기존 Skills SKILL.md를 가이드북 anatomy 기준으로 업그레이드**

bug-fix/SKILL.md 수정:
```yaml
---
name: bug-fix
description: >
  버그 수정 워크플로. 다음과 같은 요청에 활성화:
  "버그 수정해 줘", "이거 왜 안 돼?", "에러 발생", "동작이 이상해",
  "regression 생겼어", "이전에 되던 게 안 됨"
  다음에는 활성화하지 않음:
  "리팩토링해 줘", "새 기능 추가", "성능 개선"
version: 3.0.0
---
```

code-review/SKILL.md 수정:
```yaml
---
name: code-review
description: >
  코드 리뷰 워크플로. 다음과 같은 요청에 활성화:
  "코드 리뷰해 줘", "이거 머지해도 될까?", "이 코드 안전해?",
  "PR 검토", "변경사항 확인해 줘"
  다음에는 활성화하지 않음:
  "코드 작성해 줘", "구현해 줘", "새 기능 만들어 줘"
version: 3.0.0
---
```

**B. 각 SKILL.md에 Gotchas 섹션 강화**
- 현재: 일반적인 주의사항
- 변경: 프로젝트별 placeholder + 구체적 실패 패턴

```markdown
## Common Pitfalls
- Fixing the symptom instead of the root cause
- Changing too many files at once
- Forgetting to add a regression test
- Mixing scope — doing refactoring alongside the fix
- 불확실한 원인은 추측하지 말고 "확인 필요"로 표시
- 3회 이상 가설이 틀리면 사람에게 에스컬레이션 (이미 있음, 유지)
- {{PITFALL_1}}
- {{PITFALL_2}}
```

**C. Skill 테스트 체크리스트 추가 — `skills/SKILL-TEST-CHECKLIST.md` 신규 생성**

```markdown
# Skill Test Checklist

새 Skill을 만들거나 기존 Skill을 수정한 후 반드시 확인.

## 1. 호출 시험 (Trigger Test)
- [ ] 다양한 자연어 표현으로 활성화되는가?
- [ ] 한국어/영어 모두 작동하는가?

## 2. 오발동 시험 (Negative Test)
- [ ] 관련 없는 요청에는 활성화되지 않는가?
- [ ] 유사하지만 다른 Skill 영역의 요청을 구분하는가?

## 3. 형식 시험 (Format Test)
- [ ] 출력이 템플릿과 예시를 따르는가?
- [ ] 필수 섹션이 빠지지 않는가?

## 4. 실패 사례 점검 (Gotcha Test)
- [ ] 불확실한 경우 "확인 필요"로 표시하는가?
- [ ] Pitfalls에 적힌 실수를 하지 않는가?

## 5. 경계 사례 점검 (Boundary Test)
- [ ] 유사하지만 다른 요청에 대해 scope creep 없는가?
```

---

## 보강 5: Plugin 배포 구조

### 현재 상태
- plugin 관련 구조, 문서, 가이드라인이 전혀 없음

### 보강 내용

**`docs/plugin-guide.md` 신규 생성**

```markdown
# Plugin Guide

## Skill vs Plugin — 언제 승격하는가

| Plugin으로 올릴 때 | Skill로 남길 때 |
|---|---|
| 팀 전체 온보딩을 줄여야 할 때 | 아직 개인 실험 단계일 때 |
| skill + hook + MCP + command 묶어 한 번에 설치해야 할 때 | 단일 루틴, 취향성 세팅 |
| 특정 언어/직무용 작업장을 통째로 배포할 때 | 검증되지 않은 흐름 |

## Plugin 구조

plugin-name/
├── PLUGIN.md           # 설명, 설치법, 의존성
├── skills/             # 포함된 Skill들
├── hooks/              # 자동 개입 규칙
├── .mcp.json           # MCP 연결 설정
├── settings.json       # 권한 설정
└── examples/           # 사용 예시

## 외부 Plugin 보안 체크리스트
1. SKILL.md 외에 scripts/, assets/, references/ 내용까지 확인
2. 네트워크 호출 여부 (외부 URL fetch, API call)
3. 도구 범위 (allowed-tools가 과도하게 넓지 않은가)
4. 필요 권한 수준 (read-only면 충분한가, write/execute까지 필요한가)
5. 고객 데이터를 다루는 경우 격리 환경에서 먼저 테스트
6. 자동화 기능은 테스트 계정 + 별도 브라우저 프로필로 먼저 시험
7. 팀 공유 시스템에는 allowlist + 승인 프로세스 후 배포

## 신뢰 순서
1. 공식 저장소 또는 조직 관리 자산
2. 팀 내 검토된 커뮤니티 자산
3. 외부/개인 자산은 격리 테스트 환경에서만
```

---

## 보강 6: 권한 정책 문서 (사람이 읽을 수 있는 형태)

### 현재 상태
- settings.json은 있지만 기계가 읽는 형식
- 사람이 빠르게 "어디까지 자동화이고 어디서부터 사람 승인인가" 판단할 문서 없음

### 보강 내용

**`context/access-policy.md` 신규 생성**

```markdown
# AI Tool Access Policy

이 문서의 목적은 법무 문체가 아니라,
어디까지는 자동화 편의이고 어디서부터는 사람 승인인지를 빨리 긋는 것.

## Allowed by Default (자동 허용)
- 승인된 작업 폴더 내 Read, Edit, Write
- lint, test, build 명령
- git add, commit, push (Reviewer APPROVE 후)
- managed marketplace의 승인된 plugins

## Requires Human Approval (사람 승인 필요)
- 프로덕션 배포
- 고객 대면 이메일/메시지 발송
- 외부 side effect가 있는 scheduled task
- 프로덕션 데이터베이스 쓰기
- 새로운 MCP 서버 연결
- 새로운 의존성(패키지) 추가

## Blocked (차단)
- `.env*` 파일 읽기/수정
- 파괴적 쉘 명령 (rm -rf, git push --force, git reset --hard)
- 미승인 MCP 서버
- 승인된 저장소 외부 파일 편집
- 시크릿/API키 코드 내 하드코딩

## Permission Scope (적용 범위)
- Managed (IT/조직 강제) > Command line > Local > Project > User
- 팀 공유: CLAUDE.md + .claude/settings.json
- 개인 로컬: CLAUDE.local.md + .claude/settings.local.json
- 이 구분이 중요한 이유: 팀 표준과 개인 편의 설정을 섞지 않기 위함

## 고위험 작업 승인선
- 3개 이상 파일 수정하는 작업 → Planner가 계획 먼저
- 프로덕션 영향 작업 → 반드시 사람 승인
- 민감 데이터 접근 → 격리 환경에서 먼저 시험
```

---

## 보강 7: 평가 루프 (Evaluation Loop)

### 현재 상태
- 작업 완료 여부만 판단, 체계적 품질 추적 없음
- 어디서 자주 실패하는지 패턴 분석 구조 없음

### 보강 내용

**A. `templates/evaluation.md` 신규 생성**

```markdown
# Task Evaluation

## Task
[Task N] — [Task name]

## 5 Metrics (매 Task 완료 후 기록)

### 1. Success Rate (성공률)
- 완료 기준 통과: YES / NO / PARTIAL
- REQUEST_CHANGES 횟수: [N]

### 2. Human Edit Count (사람 수정량)
- Reviewer가 직접 고친 곳: [N]개소
- 주요 수정 내용: [설명]

### 3. Time (시간)
- 요청 → 승인 가능 상태: [시간]
- Plan → Develop → Review 각 단계: [시간]

### 4. Token Cost (토큰/비용)
- 총 토큰: [N]
- 세션 수: [N]
- 도구 호출 횟수: [N]

### 5. Failure Type (실패 유형)
해당하는 항목에 체크:
- [ ] 근거 부족 (필요한 정보를 충분히 읽지 않음)
- [ ] 형식 오류 (출력 형식이 기대와 다름)
- [ ] 테스트 실패 (기능적 오류)
- [ ] 범위 초과 (계획에 없는 파일 수정)
- [ ] 검증 누락 (수동 확인 빠짐)
- [ ] 기타: [설명]

## Lessons Learned
- [이번 작업에서 배운 점 — gotchas.md나 rules에 반영할 것이 있으면 여기 기록]
```

**B. `context/working-rules.md`에 평가 루프 섹션 추가**

```markdown
## Evaluation Loop
매 Task 완료 후 `templates/evaluation.md` 형식으로 기록.
반복되는 실패 패턴이 발견되면:
1. `.claude/rules/gotchas.md`에 Known Pitfall로 추가
2. 해당 Skill의 Common Pitfalls에 추가
3. 필요 시 hook으로 자동 감지 추가

5가지 지표를 계속 비교:
- 성공률, 사람 수정량, 시간, 토큰/비용, 실패 유형
```

---

## 보강 8: 병렬 Task Git 통합 커밋

### 현재 상태 (문제)
- `run-epic.sh`의 병렬 Stage에서 각 Slice가 독립적으로 Review → `git commit + push` 실행
- Slice A가 먼저 push하면, Slice B는 remote가 앞서 있어 push 실패
- `set -euo pipefail`로 스크립트 종료 → 해당 Slice 변경사항이 git에 반영되지 않음
- 결과: 병렬 Stage에서 첫 번째 Slice만 커밋되고 나머지는 누락

### 해결 전략
**병렬 모드에서는 Reviewer가 git 커밋하지 않고, Stage 완료 후 통합 커밋**

### 보강 내용

**A. `scripts/run-task.sh` 수정 — `--no-commit` 플래그 추가**

```bash
# 기존 --task-id 처리 블록 뒤에 추가
NO_COMMIT=false
if [ "${1:-}" = "--no-commit" ]; then
  NO_COMMIT=true
  shift
fi
```

Review 프롬프트 주입 변경:
```bash
# run_claude 함수 내, 병렬 모드일 때
if [ -n "$TASK_ID" ]; then
  command="${command} (IMPORTANT: Use '${HANDOFF_FILE}' instead of 'handoff/latest.md' for all handoff reads and writes in this task.)"
fi
if [ "$NO_COMMIT" = true ]; then
  command="${command} (IMPORTANT: Do NOT run git commit or git push. Only write the review report and update the handoff file. Git will be handled by the orchestrator after all parallel slices complete.)"
fi
```

**B. `run-epic.sh` 수정 — 병렬 Stage 호출 시 `--no-commit` 전달**

```bash
# run_parallel_stage 함수 내, run-task.sh 호출 변경
"$SCRIPT_DIR/run-task.sh" --task-id "slice-${idx}" --no-commit "$slice_desc" \
  > "${task_log_dir}/stdout.log" 2>&1 &
```

**C. `run-epic.sh`에 `commit_stage()` 함수 신규 추가**

```bash
# Stage 통합 커밋 함수
commit_stage() {
  local stage_num="$1"
  shift
  local indices=("$@")

  log_phase "STAGE $stage_num GIT COMMIT"

  cd "$PROJECT_DIR"

  # 변경된 파일이 있는지 확인
  if [ -z "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}! No changes to commit for Stage $stage_num${NC}"
    return 0
  fi

  # Slice 요약 수집
  local slice_summaries=""
  for idx in "${indices[@]}"; do
    local desc="${SLICES[$idx]}"
    # "Slice N: description" 또는 "Task N — description" 에서 요약 추출
    local short_desc
    short_desc=$(echo "$desc" | sed -E 's/^(Slice|Task|태스크|슬라이스)\s+[0-9]+\s*[-—:]\s*//')
    if [ -n "$slice_summaries" ]; then
      slice_summaries="${slice_summaries} + ${short_desc}"
    else
      slice_summaries="$short_desc"
    fi
  done

  # 커밋 메시지 형식: feat: Stage N — slice1 + slice2 + ...
  local commit_msg="feat: Stage ${stage_num} — ${slice_summaries}"

  # git add + commit + push
  git add -A
  git commit -m "$commit_msg"

  if git push; then
    echo -e "${GREEN}✓ Stage $stage_num committed and pushed${NC}"
    echo "  Commit: $(git rev-parse --short HEAD)"
    echo "  Message: $commit_msg"
  else
    echo -e "${RED}✗ Git push failed for Stage $stage_num${NC}"
    echo "  Commit was created locally. Run 'git push' manually."
    return 1
  fi
}
```

**D. `run-epic.sh`의 병렬 Stage 실행 블록에 통합 커밋 호출 추가**

```bash
# 기존 run_parallel_stage 성공 후, merge_stage_handoffs 뒤에 추가
if ! run_parallel_stage "$stage_num" "${stage_indices[@]}"; then
  # ... 기존 실패 처리 ...
fi

# Merge parallel handoff files back
merge_stage_handoffs "$stage_num" "${stage_indices[@]}"

# NEW: 병렬 Stage 통합 커밋
if ! commit_stage "$stage_num" "${stage_indices[@]}"; then
  echo -e "${RED}✗ Stage $stage_num commit failed${NC}"
  exit 1
fi
```

**E. 순차 실행(단일 Slice)은 기존 동작 유지**
- `--no-commit` 없이 `run-task.sh` 호출 → Reviewer가 직접 커밋

### 실행 흐름 비교

**기존 (v4) — 병렬 Stage:**
```
Stage 1:
  Slice A: Plan → Develop → Review(commit+push) ✓
  Slice B: Plan → Develop → Review(commit+push) ✗ (remote ahead)
  Slice C: Plan → Develop → Review(commit+push) ✗ (remote ahead)
→ Slice A만 git에 반영
```

**보강 (v5) — 병렬 Stage:**
```
Stage 1:
  Slice A: Plan → Develop → Review(no commit) ✓
  Slice B: Plan → Develop → Review(no commit) ✓
  Slice C: Plan → Develop → Review(no commit) ✓
  → commit_stage(): git add -A → commit → push ✓
→ 모든 Slice가 git에 반영
```

**순차 실행 (변경 없음):**
```
Task 1: Plan → Develop → Review(commit+push) ✓ (기존과 동일)
```

---

## 파일 변경 요약

### 신규 생성 (5개)
| 파일 | 용도 |
|------|------|
| `context/mcp-policy.md` | MCP/외부 통합 정책 |
| `context/access-policy.md` | 사람이 읽는 권한 정책 문서 |
| `docs/plugin-guide.md` | Plugin 배포 가이드 |
| `skills/SKILL-TEST-CHECKLIST.md` | Skill 테스트 체크리스트 |
| `templates/evaluation.md` | Task 평가 루프 템플릿 |

### 수정 (6개)
| 파일 | 변경 내용 |
|------|----------|
| `templates/verify.md` | Completion Criteria, Constraints, Confidence level, Type check 추가 |
| `context/working-rules.md` | Token Management + Evaluation Loop 섹션 추가 |
| `skills/bug-fix/SKILL.md` | description에 trigger/negative 표현 추가, Gotchas 강화 |
| `skills/code-review/SKILL.md` | description에 trigger/negative 표현 추가 |
| `scripts/run-task.sh` | `--no-commit` 플래그 추가, Review 프롬프트에 no-commit 지시 주입 |
| `scripts/run-epic.sh` | `commit_stage()` 함수 추가, 병렬 Stage에서 `--no-commit` 전달 및 통합 커밋 |

### 참조 수정 (2개)
| 파일 | 변경 내용 |
|------|----------|
| `CLAUDE.md` | References에 mcp-policy.md, access-policy.md 추가 |
| `README.md` | 구조도에 신규 파일 반영, v5 변경사항 추가 |

### 변경 없음
| 파일 | 이유 |
|------|------|
| `settings.json` | MCP deny는 실제 프로젝트 적용 시 설정 (템플릿에는 주석 가이드만) |
| `hooks/*` | 현재 구조가 가이드북 기준에 이미 충분 |
| `templates/plan.md` | 현재 구조 적절 |
| `templates/handoff.md` | 현재 구조 적절 |
| `templates/role-*.md` | 현재 구조 적절 |

---

## 작업 순서

1. **verify.md 수정** → 다른 모든 작업의 검증 기준이 되므로 가장 먼저
2. **working-rules.md 수정** → 토큰 관리 + 평가 루프 섹션 추가
3. **Skills 정밀화** → bug-fix, code-review SKILL.md 업그레이드
4. **신규 파일 생성** → mcp-policy, access-policy, plugin-guide, evaluation, skill-test-checklist
5. **scripts 수정** → run-task.sh, run-epic.sh 병렬 git 통합 커밋
6. **CLAUDE.md, README.md 참조 업데이트**

---

## 가이드북 근거 매핑

| 보강 항목 | 가이드북 근거 |
|-----------|-------------|
| MCP 정책 | 5.10 (하네스 6번째 요소: 외부 통합), 6장 (MCP 설계) |
| verify.md 강화 | 5.11 (검증 계층), 5.10 ("무엇으로 확인할지 먼저 정한다") |
| 토큰 관리 | 3장 (토큰 경제학 5층), 5.5 (컨텍스트 엔지니어링) |
| Skills 정밀화 | 6.1-6.3 (Skill anatomy, trigger 설계, 테스트 체크리스트) |
| Plugin 가이드 | 6.4-6.5 (Plugin 구조, 배포 전략, 보안) |
| 권한 정책 | 5.10 (Permission 최소 문서), 11장 (거버넌스) |
| 평가 루프 | 5.11 (평가 루프 5가지 지표) |
| 병렬 git 통합 | 5.8 (에이전트 팀 파일 충돌), run-epic.sh 실전 운영 개선 |
