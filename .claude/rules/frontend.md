# Frontend Development Rules

## Components:
- One component per file
- Keep components under 200 lines; extract if larger
- Props interface must be explicitly typed (no `any`)
- Use composition over prop drilling

## Styling:
- Follow the project's existing styling approach (CSS modules, Tailwind, styled-components)
- Don't mix styling approaches within the same component
- Use design tokens/variables for colors, spacing, typography
- Responsive design: mobile-first approach

## State management:
- Local state for UI-only concerns (useState)
- Shared state for cross-component data (context, store)
- Server state via data fetching library (React Query, SWR, etc.)
- Never duplicate server data in client state

## Performance:
- Lazy load routes and heavy components
- Memoize expensive computations (useMemo) only when measured
- Don't premature optimize — measure first with DevTools

## Accessibility:
- Semantic HTML elements over divs (button, nav, main, etc.)
- All images need alt text
- Interactive elements must be keyboard accessible
- Color contrast must meet WCAG AA
