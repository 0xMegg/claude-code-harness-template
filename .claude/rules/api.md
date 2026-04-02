# API Development Rules

## When working on API routes or endpoints:
- Always validate request input at the boundary (use zod, joi, or equivalent)
- Return consistent error response format: `{ error: string, code: string, details?: any }`
- Use proper HTTP status codes (don't default everything to 500)
- Never expose internal error stack traces in production responses
- Log errors with context (request ID, user ID, endpoint) before returning

## Database queries:
- Use parameterized queries, never string concatenation for SQL
- Always include WHERE clauses in UPDATE/DELETE statements
- Add indexes for frequently queried columns
- Use transactions for multi-step mutations

## Authentication:
- Never log tokens, passwords, or session IDs
- Validate auth on every protected endpoint (no shortcuts)
- Check authorization (permissions) separately from authentication (identity)
