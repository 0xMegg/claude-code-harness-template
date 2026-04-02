---
name: code-review
description: 코드 리뷰 — 정확성, 보안, 아키텍처 검증
version: 2.0.0
---

# Code Review Skill

## Goal
코드 변경사항을 검토하고 심각도별로 정리된 피드백을 제공한다.

## Input Required
- 리뷰할 diff 또는 파일
- 변경 목적 (어떤 문제를 해결하는지)

## Steps

### 1. 의도 파악
- Task 설명 또는 plan 읽기
- 변경이 해결하는 문제 이해

### 2. Diff 읽기
- 변경된 파일 전부 읽기
- 변경 범위 파악

### 3. 이슈 체크 (우선순위순)

#### Critical (반드시 수정)
- 보안: 시크릿 하드코딩, 인증 우회
- 데이터 손실 위험
- 외부 호출에 에러 처리 누락
- 깨진 기능 (라우팅, API 등)

#### Important (수정 권장)
- 아키텍처 규칙 위반 (rules/ 참고)
- 누락된 테스트
- 하드코딩된 값 (설정, URL, 색상 등)

#### Minor (선택)
- 네이밍 개선
- 코드 구조화
- 문서 부족

### 4. 리포트 형식
```
## Review Report

**Overall:** APPROVE / REQUEST_CHANGES / NEEDS_DISCUSSION

### Critical
- [파일:줄] 설명 + 수정 제안

### Important
- [파일:줄] 설명 + 수정 제안

### Minor
- [파일:줄] 설명

### Good
- 잘한 점 (강화할 패턴)
```

### 5. 검증
- lint/analyze 직접 실행해서 결과 확인
- test 직접 실행해서 결과 확인
- 리포트에 기재된 내용과 실제 결과 대조

## 판정 기준
- Critical 1개 이상 → REQUEST_CHANGES
- Important만 → Developer에게 판단 위임
- Minor만 → APPROVE
