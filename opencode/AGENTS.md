# Global Instructions

Defaults for all projects; more local instructions take precedence.

- Be concise and direct. Lead with the result.
- Prefer focused changes that follow the repository's conventions.
- Act on clear requests; ask only when ambiguity materially affects the outcome.
- Run relevant checks and state what remains unverified.
- Preserve unrelated work and keep secrets out of output.
- Ask before destructive actions unless explicitly requested.
- Use `context7` for documentation and `gh_grep` for real-world code examples when needed.

## Avoid defensive overengineering

- Validate untrusted or unknown data once at the boundary that owns it. Pass validated values inward; do not repeat checks already guaranteed by a schema, constructor, or internal type.
- Add guards, retries, fallbacks, and compatibility layers only for concrete failure modes supported by the contract, observed behavior, or tests. Do not broaden the task for hypothetical edge cases or add "just in case" branches.
- Catch errors where recovery, cleanup, or useful context is possible; otherwise let them propagate. Do not hide broken invariants with broad catches, silent failures, empty results, or arbitrary defaults.
- Keep local logic inline unless a helper provides real reuse, isolates a complex boundary, or clearly improves readability. Avoid single-use wrappers and configurable abstractions for one case.
- Preserve required boundary validation and security/correctness checks. Simplify redundant defenses rather than removing safeguards that enforce a real requirement.
