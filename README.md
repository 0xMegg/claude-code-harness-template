# Claude Code Harness Template

Claude Code & Cowork 마스터 가이드(583p) 기반으로 구축한 재사용 가능 작업 환경 템플릿.

## 구조

```
claude-code-harness-template/
├── CLAUDE.md                          # 프로젝트 계약서 (빌드/테스트 명령, 폴더 경계, 코딩 규약, 금지사항)
├── .claude/
│   ├── settings.json                  # 권한/안전 설정 (allow/deny 목록, hook 연결)
│   ├── hooks/
│   │   ├── block-dangerous.sh         # PreToolUse: 위험 명령 사전 차단
│   │   └── post-edit-check.sh         # PostToolUse: 시크릿 노출 감지
│   └── rules/
│       ├── api.md                     # API 개발 규칙 (입력 검증, SQL 안전, 인증)
│       ├── testing.md                 # 테스트 규칙 (회귀 테스트, 커버리지 기준)
│       ├── frontend.md                # 프론트엔드 규칙 (컴포넌트, 상태관리, 접근성)
│       └── git.md                     # Git 규칙 (커밋 메시지, 브랜치 전략)
├── context/
│   ├── about-me.md                    # 프로젝트 배경 (스택, 디렉토리, 현재 상태)
│   └── working-rules.md              # 작업 원칙 (세션 프로토콜, 품질 게이트)
├── templates/
│   ├── plan.md                        # 작업 계획 템플릿
│   ├── handoff.md                     # 세션 인수인계 템플릿
│   └── bug-fix.md                     # 버그 수정 템플릿
├── skills/
│   ├── bug-fix/SKILL.md              # 버그 수정 워크플로 스킬
│   └── code-review/SKILL.md          # 코드 리뷰 워크플로 스킬
├── handoff/                           # 세션 인수인계 기록
├── outputs/                           # 산출물
├── setup.sh                           # 새 프로젝트 초기화 스크립트
└── README.md
```

## 사용법

### 새 프로젝트에 적용

```bash
cd /path/to/your-project
/Users/mero/claude-code-harness-template/setup.sh my-project-name
```

### 적용 후 해야 할 것

1. `CLAUDE.md` — `{{PLACEHOLDER}}` 값 채우기 (빌드 명령, 테스트 명령, 스택)
2. `context/about-me.md` — 프로젝트 설명 채우기
3. `.claude/rules/` — 프로젝트에 맞지 않는 규칙 수정/삭제
4. Claude Code 실행

## 가이드북 매핑

| 파일 | 가이드북 근거 |
|------|-------------|
| `CLAUDE.md` | 3.7 (7일 세팅), 5.3 (CLAUDE.md 운영 원칙) |
| `settings.json` | 3.14 (보안), 5.10 (하네스 요소) |
| `hooks/` | 2장 (Hook 개념), 5.10 (자동 개입) |
| `rules/` | 5.4 (Rules 파일 분리), 5.5 (컨텍스트 엔지니어링) |
| `context/` | 3.17 (스타터 번들), 5.2 (작업공간 설계) |
| `templates/` | 3.9 (템플릿 역할), 4.3 (실전 프롬프트 템플릿) |
| `skills/` | 6.1-6.3 (Skill 설계), 6.7 (Skill 필요성) |
| `handoff/` | 5.7 (Handoff > 세션 압축) |
| `setup.sh` | 3.7 (7일 세팅 로드맵) |

## 핵심 개념 (가이드북 기반)

### 하네스 4요소
1. **Memoized Context** — CLAUDE.md, rules/, context/ 가 매 턴마다 재사용되는 배경
2. **Tool Orchestration** — settings.json의 도구 허용/차단 설정
3. **Permission Gate** — hooks/의 사전/사후 자동 점검
4. **Resumable Session** — handoff/의 세션 이어받기 기록

### 작업 흐름
```
세션 시작 → handoff/latest.md 읽기 → plan 작성 → 구현 → 테스트 → handoff 업데이트 → 세션 종료
```

### 규칙 우선순위
```
CLAUDE.md (항상 로드) > .claude/rules/ (경로별 활성화) > 프롬프트 (현재 요청)
```
