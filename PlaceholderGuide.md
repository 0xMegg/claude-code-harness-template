CLAUDE.md 플레이스홀더 가이드
{{PROJECT_NAME}}
프로젝트 이름. 레포 이름이나 서비스명을 그대로 씁니다.

예: my-saas-app, portfolio-site, internal-admin-dashboard

{{TECH_STACK}}
주요 기술 스택을 콤마로 나열. Claude가 코드 스타일과 패턴을 맞출 때 참고합니다.

예: Next.js 15, React 19, TypeScript, Tailwind CSS, Prisma, PostgreSQL
예: Python 3.12, FastAPI, SQLAlchemy, React, Vite
예: Nuxt 3, Vue 3, TypeScript, Supabase

{{INSTALL_CMD}} ~ {{TYPE_CMD}} (빌드/테스트 명령 6개)
이게 가장 중요합니다. Claude가 코드 수정 후 자동으로 검증하는 데 이 명령들을 씁니다. package.json의 scripts 섹션을 보고 채우면 됩니다.

플레이스홀더 확인 방법 없으면
{{INSTALL_CMD}} npm install / yarn / pnpm install 하나 골라 적기
{{DEV_CMD}} npm run dev / yarn dev package.json scripts 확인
{{BUILD_CMD}} npm run build / yarn build 없으면 줄 삭제
{{TEST_CMD}} npm test / pytest / vitest 없으면 # 아직 없음 표시
{{TEST_SINGLE_CMD}} npx vitest run {{file}} / pytest {{file}} 프레임워크에 따라 다름
{{LINT_CMD}} npm run lint / npx eslint . 없으면 줄 삭제
{{TYPE_CMD}} npx tsc --noEmit (TS 프로젝트만) JS면 줄 삭제
빠른 확인법:

cd your-project && cat package.json | grep -A 20 '"scripts"'

context/about-me.md 플레이스홀더 가이드
{{PROJECT_NAME}}
CLAUDE.md와 동일한 값.

{{ONE_PARAGRAPH_DESCRIPTION}}
프로젝트가 무슨 문제를 해결하는지 2~3문장으로 설명. Claude가 코드 맥락을 이해하는 데 사용합니다.

예: 소규모 팀을 위한 프로젝트 관리 SaaS. 칸반 보드, 타임라인, 팀 채팅 기능을 제공한다.
현재 베타 사용자 50명이 테스트 중이다.

예: 개인 포트폴리오 사이트. 블로그, 프로젝트 갤러리, 이력서 페이지로 구성.
정적 사이트로 Vercel에 배포 중.

예: 사내 관리자 대시보드. 주문 현황, 고객 관리, 매출 리포트를 보여준다.
직원 10명이 매일 사용하는 내부 도구.

{{FRONTEND}}, {{BACKEND}}, {{DATABASE}}, {{HOSTING}}
각각의 기술을 버전과 함께 적습니다.

- Frontend: Next.js 15, React 19, TypeScript 5.5, Tailwind CSS 4
- Backend: Next.js API Routes (서버리스)
- Database: Supabase (PostgreSQL)
- Hosting: Vercel

또는

- Frontend: React 18, Vite 6, TypeScript
- Backend: Python 3.12, FastAPI
- Database: PostgreSQL 16, Redis
- Hosting: AWS EC2 + RDS

없는 항목은 없음 또는 줄 자체를 삭제하면 됩니다.

{{TARGET_USERS}}
누가 이 서비스를 쓰는지. Claude가 UI/UX 판단이나 에러 메시지 톤을 맞출 때 참고합니다.

예: 한국 스타트업 팀 리드와 PM (비개발자 포함)
예: 본인만 사용하는 개인 도구
예: 일반 소비자 (20~30대, 모바일 위주)
예: 사내 CS팀 직원 5명

{{ANY_CONSTRAINTS_OR_HISTORY}}
Claude가 알아야 하지만 코드만 봐서는 모르는 것. 여러 줄 가능합니다.

예:

- 레거시 jQuery 코드가 pages/ 일부에 남아있음. 점진적으로 React로 전환 중
- 외부 결제 API(토스페이먼츠) 연동 중. 테스트 키만 사용할 것
- 디자인 시스템이 아직 없어서 Tailwind 클래스를 직접 사용 중
- 6월 런칭 목표. 현재 핵심 기능 70% 완료

예:

- 1인 프로젝트, 코드 리뷰어 없음
- SEO가 중요한 프로젝트라 SSR 유지 필수

최소 필수 vs 나중에 채워도 되는 항목
지금 바로 채워야 나중에 채워도 됨
PROJECT_NAME TARGET_USERS
INSTALL_CMD, DEV_CMD, BUILD_CMD DATABASE, HOSTING
TEST_CMD (있다면) ANY_CONSTRAINTS_OR_HISTORY
TECH_STACK / FRONTEND TEST_SINGLE_CMD, TYPE_CMD
ONE_PARAGRAPH_DESCRIPTION Key Directories (프로젝트 구조 보고 수정)
핵심 원칙: 빌드/테스트 명령이 정확해야 Claude가 코드 수정 후 자동 검증을 할 수 있습니다. 이것만 정확하면 나머지는 작업하면서 점진적으로 채워도 괜찮습니다.
