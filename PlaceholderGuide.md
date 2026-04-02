# Placeholder Guide (v2)

이 문서는 하네스 템플릿의 모든 `{{PLACEHOLDER}}`를 채우는 방법을 안내합니다.

---

## 1. CLAUDE.md — 프로젝트 계약서

### 프로젝트 기본 정보

| Placeholder | 설명 | 예시 |
|-------------|------|------|
| `{{PROJECT_NAME}}` | 프로젝트 이름 | `my-saas-app`, `divebase`, `portfolio-site` |
| `{{PROJECT_TYPE}}` | 프로젝트 유형 | `Web App`, `Mobile App (Flutter)`, `API Server`, `CLI Tool` |
| `{{TECH_STACK}}` | 주요 기술 콤마 나열 | `Next.js 15, React 19, TypeScript, Tailwind CSS, Prisma, PostgreSQL` |

### 빌드/테스트 명령 (가장 중요!)

Claude가 코드 수정 후 자동 검증하는 데 이 명령들을 씁니다.

| Placeholder | 설명 | 확인 방법 |
|-------------|------|----------|
| `{{INSTALL_CMD}}` | 의존성 설치 | `npm install` / `yarn` / `flutter pub get` / `pip install -r requirements.txt` |
| `{{DEV_CMD}}` | 개발 서버 실행 | `npm run dev` / `flutter run` / `python manage.py runserver` |
| `{{BUILD_CMD}}` | 프로덕션 빌드 | `npm run build` / `flutter build apk` / `go build` |
| `{{TEST_CMD}}` | 테스트 전체 실행 | `npm test` / `flutter test` / `pytest` / `go test ./...` |
| `{{TEST_SINGLE_CMD}}` | 테스트 단일 실행 | `npx vitest run {{file}}` / `flutter test test/{{file}}` / `pytest {{file}}` |
| `{{LINT_CMD}}` | 린트/분석 | `npm run lint` / `dart analyze` / `flake8` / `golangci-lint run` |
| `{{FORMAT_CMD}}` | 코드 포맷팅 | `npx prettier --write .` / `dart format lib/` / `black .` / `gofmt -w .` |

> 💡 **빠른 확인:** `cat package.json | grep -A 20 '"scripts"'` 또는 `cat Makefile`

> 없는 명령은 줄 자체를 삭제하면 됩니다.

### 폴더 경계

| Placeholder | 설명 | 예시 |
|-------------|------|------|
| `{{SRC_DIR}}` | 소스 코드 루트 | `src/`, `lib/`, `app/`, `cmd/` |
| `{{TEST_DIR}}` | 테스트 루트 | `tests/`, `test/`, `__tests__/`, `*_test.go` |
| `{{BUILD_OUTPUT}}` | 빌드 산출물 (수정 금지) | `dist`, `build`, `.next` |
| `{{LOCK_FILE}}` | 락 파일 (수정 금지) | `package-lock.json`, `pubspec.lock`, `poetry.lock` |

### 아키텍처

| Placeholder | 설명 | 예시 |
|-------------|------|------|
| `{{ARCHITECTURE_PATTERN}}` | 코드 구조 패턴 | `Feature-First`, `MVC`, `Clean Architecture`, `모노리스` |
| `{{STATE_MANAGEMENT}}` | 상태 관리 | `Riverpod`, `Redux`, `Zustand`, `Pinia`, `없음 (서버 렌더링)` |
| `{{ROUTING}}` | 라우팅 방식 | `GoRouter`, `Next.js App Router`, `React Router`, `파일 기반` |
| `{{DATA_ACCESS_PATTERN}}` | 데이터 접근 패턴 | `Repository pattern`, `직접 ORM`, `API client`, `Supabase SDK` |

### 코딩 규칙

| Placeholder | 설명 | 예시 |
|-------------|------|------|
| `{{LANGUAGE}}` | 주 언어 | `TypeScript (strict mode)`, `Dart`, `Python 3.12`, `Go 1.22` |
| `{{NAMING_CONVENTION}}` | 이름 규칙 | `camelCase for vars, PascalCase for classes` |
| `{{FILE_NAMING}}` | 파일명 규칙 | `snake_case`, `kebab-case`, `PascalCase` |
| `{{IMPORT_STYLE}}` | 임포트 스타일 | `absolute (@/components)`, `relative`, `package imports first` |
| `{{ERROR_HANDLING}}` | 에러 처리 방식 | `try/catch with typed errors`, `Result type`, `error wrapping` |

### 기타

| Placeholder | 설명 | 예시 |
|-------------|------|------|
| `{{PROTECTED_FILES}}` | 묻지 않고 수정 금지 파일 | `CI/CD configs`, `supabase/migrations`, `android/, ios/` |
| `{{SCHEMA_FILE}}` | DB 스키마 문서 (있다면) | `SCHEMA.md`, `prisma/schema.prisma`, `없으면 줄 삭제` |

---

## 2. context/about-me.md — 프로젝트 배경

| Placeholder | 설명 | 예시 |
|-------------|------|------|
| `{{PROJECT_NAME}}` | CLAUDE.md와 동일 | — |
| `{{ONE_PARAGRAPH_DESCRIPTION}}` | 프로젝트 설명 2~3문장 | `소규모 팀을 위한 프로젝트 관리 SaaS. 칸반 보드, 타임라인, 팀 채팅 기능을 제공한다.` |
| `{{FRONTEND}}` | 프론트엔드 기술+버전 | `Next.js 15, React 19, TypeScript 5.5, Tailwind CSS 4` |
| `{{BACKEND}}` | 백엔드 기술+버전 | `Node.js 22, Express`, `없으면 "없음 (서버리스)"` |
| `{{DATABASE}}` | 데이터베이스 | `PostgreSQL 16`, `Supabase`, `MongoDB Atlas` |
| `{{HOSTING}}` | 호스팅/배포 | `Vercel`, `AWS EC2`, `미정` |
| `{{SRC_DIR}}` | 소스 코드 경로 | `src/app/`, `lib/features/` |
| `{{TEST_DIR}}` | 테스트 경로 | `tests/`, `test/` |
| `{{CONFIG_DIR}}` | 설정 파일 경로 | `config/`, `프로젝트 루트` |
| `{{TARGET_USERS}}` | 사용자 | `한국 스타트업 PM`, `본인만 사용`, `일반 소비자 (20~30대)` |
| `{{ANY_CONSTRAINTS_OR_HISTORY}}` | Claude가 코드만 봐서는 모르는 것 | `레거시 jQuery 코드 잔존`, `6월 런칭 목표`, `1인 프로젝트` |

---

## 3. templates/role-*.md — 역할 파일

### role-planner.md

| Placeholder | 설명 |
|-------------|------|
| `{{PROJECT_NAME}}` | setup.sh가 자동 치환 |
| `{{SCHEMA_FILE}}` | CLAUDE.md와 동일한 값 |

### role-developer.md

| Placeholder | 설명 |
|-------------|------|
| `{{PROJECT_NAME}}` | setup.sh가 자동 치환 |
| `{{LINT_CMD}}` | CLAUDE.md의 Lint/Analyze 명령과 동일 |
| `{{TEST_CMD}}` | CLAUDE.md의 Test all 명령과 동일 |

### role-reviewer.md

| Placeholder | 설명 | 예시 |
|-------------|------|------|
| `{{PROJECT_NAME}}` | setup.sh가 자동 치환 | — |
| `{{LINT_CMD}}` | CLAUDE.md와 동일 | — |
| `{{TEST_CMD}}` | CLAUDE.md와 동일 | — |
| `{{ARCHITECTURE_CHECK_1}}` | 프로젝트 아키텍처 검사 항목 1 | `Repository 패턴을 따르는가?` |
| `{{ARCHITECTURE_CHECK_2}}` | 프로젝트 아키텍처 검사 항목 2 | `GoRouter만 사용하는가?` |
| `{{ARCHITECTURE_CHECK_3}}` | 프로젝트 아키텍처 검사 항목 3 | `디자인 시스템 토큰을 사용하는가?` |
| `{{SECURITY_CHECK}}` | 프로젝트 보안 검사 항목 | `RLS 우회 없음`, `XSS 방어`, `CSRF 토큰 확인` |

---

## 우선순위

### 지금 바로 채워야 하는 것
- `{{PROJECT_NAME}}`
- `{{INSTALL_CMD}}`, `{{DEV_CMD}}`, `{{BUILD_CMD}}`, `{{TEST_CMD}}`
- `{{LINT_CMD}}`
- `{{ONE_PARAGRAPH_DESCRIPTION}}`
- `{{LANGUAGE}}`, `{{TECH_STACK}}`

### 나중에 채워도 되는 것
- `{{TARGET_USERS}}`, `{{HOSTING}}`
- `{{ANY_CONSTRAINTS_OR_HISTORY}}`
- `{{TEST_SINGLE_CMD}}`, `{{FORMAT_CMD}}`
- `{{ARCHITECTURE_CHECK_*}}`, `{{SECURITY_CHECK}}` (첫 리뷰 때 채워도 됨)

> **핵심 원칙:** 빌드/테스트 명령이 정확해야 Claude가 자동 검증을 할 수 있습니다. 이것만 정확하면 나머지는 작업하면서 점진적으로 채워도 괜찮습니다.
