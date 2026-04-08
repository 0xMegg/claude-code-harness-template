# About This Project

## Project Name
Claude Code Harness

## What It Does
Claude Code 프로젝트를 위한 하네스(운영 프레임워크)를 만들고, 개선하고, 배포하는 메타 프로젝트.
자기 자신도 하네스 방법론으로 운영하며, trend-harvester 기반 self-improvement pipeline으로 지속 진화한다.

## Tech Stack
- Runtime: Bash, Claude Code CLI
- Format: Markdown (skills, rules, templates, docs)
- Integration: MCP (WebFetch, Notion), Claude Code hooks/skills

## Key Directories
- `src/` — 배포용 하네스 템플릿 소스 ({{플레이스홀더}} 포함)
- `outputs/template/` — 빌드된 최신 하네스 템플릿
- `harvest/` — self-improvement pipeline 데이터
- `.claude/` — 이 프로젝트 자체의 Claude 설정

## Current State
- [x] Active development
- [ ] Production / Maintenance

## Who Uses It
솔로 개발자 (mero). 아임웹, Dive Base 등 실제 프로젝트에 하네스를 적용.

## Important Context
- 기존 git 히스토리 유지하면서 "정적 템플릿 → 관리 프로젝트"로 전환됨
- src/ 수정 후 반드시 `bash scripts/build-template.sh`로 빌드해야 outputs/template/ 반영
- harvest pipeline은 외부 트렌드 수집 → 5축 필터 → 실측 검증 → 자동/수동 적용 루프
