---
name: paper-review
description: Review CS research papers for language, consistency, logic, figures, notation, claims, and venue/style compliance. Ask for venue before applying venue-specific rules.
---

# Paper Review

Use this skill to review systems research papers, especially LaTeX manuscripts with experiments, workloads, figures, tables, equations, algorithms, and references. Prefer finding concrete issues over general rewriting.

## When to Use

- User asks to check, review, polish, or validate a paper draft
- User wants spelling, grammar, consistency, logic, figure/table, notation, or venue-style checks
- User is preparing a systems or CS submission and wants issues before editing or submission

## Intake First

Before venue-specific review, ask briefly if not already known:

- Target venue or journal
- Whether there is a style guide, template, author kit, or checklist to follow
- Main paper entry file, usually a `.tex` file
- Whether image-content checking is needed or text-only figure checks are enough

If venue is unknown, proceed with general systems-paper standards and explicitly mark venue-specific compliance as not checked.

## Review Workflow

## Low-Cost Model Mode

Use this mode automatically when running on a cheaper or weaker model such as Gemini Flash, or when the user asks for a lightweight pass.

- Review one section, figure/table, or narrow context window at a time.
- Run one check category at a time instead of doing a full-paper review in one pass.
- Report only evidence-backed, high-confidence findings.
- Limit each pass to the most important findings; avoid long speculative lists.
- Put uncertain global issues under `needs-human-check` instead of presenting them as facts.
- Prefer extraction-first checks: list systems, workloads, baselines, metrics, configurations, hardware/software setup, claims, figures, and tables before checking consistency.
- Do not make venue-specific claims without a provided style source.
- Do not judge visual figure content unless rendered images are available.
- Do not perform broad rewrites; propose minimal local edits only after user confirmation.

### 1. Language

Check for:

- Spelling, grammar, articles, tense, plurality, and subject-verb agreement
- Awkward, ambiguous, or overly long sentences
- Local edits that preserve technical meaning

Do not rewrite large sections unless the user asks for rewriting. Report the sentence, problem, and a minimal suggested fix.

### 2. Consistency

Check terminology, numbers, abbreviations, and notation.

- Terms: one concept should not use multiple names without reason
- Numbers: abstract, text, tables, figures, and conclusion should agree
- Abbreviations: first use should be expanded; later use should be consistent
- Notation: variables should not change meaning; vectors, matrices, scalars, functions, and sets should be styled consistently
- Units and percentages: spacing, symbols, decimal precision, and comparisons should be consistent

For systems papers, pay special attention to workload names, system/component names, baseline names, metric names, configuration names, hardware/software setup, algorithm names, theorem/lemma numbering, and experimental settings.

### 3. Logic and Claims

Check whether the argument is technically supported.

- Claims should follow from methods, experiments, theory, or citations
- Avoid overclaiming with words like `prove`, `guarantee`, `always`, `significantly`, `state-of-the-art`, or `outperforms` unless evidence supports them
- Distinguish causation from correlation
- Ensure limitations, assumptions, and failure cases are not hidden by broad wording
- Check that conclusions do not introduce new results not established earlier

For systems papers, inspect baseline fairness, workload representativeness, evaluation setup, configuration comparability, benchmark coverage, statistical significance if claimed, overhead/latency/throughput/scalability claims, and whether experiments support the main contribution.

### 4. Figures and Tables

First do text-only checks from LaTeX source:

- Every figure/table is referenced in the text
- Every figure/table is explained, not merely mentioned as `see Figure X`
- Captions are self-contained enough to understand the result
- Labels, captions, legends, subfigure names, and text references agree
- Textual claims about trends, ordering, colors, methods, axes, or subfigures match captions and nearby discussion

Only use image-content checking when the issue depends on the visual content itself. For EPS figures, do not treat raw EPS text as reliable visual evidence; convert to PDF/PNG or ask the user for rendered figures before using a multimodal model.

### 5. Venue and Style Compliance

Apply this only after intake or after the user provides a target venue/template.

Check:

- Page, abstract, appendix, supplementary, anonymity, and camera-ready rules
- Citation and reference style
- Section names, figure/table conventions, capitalization, and abbreviation preferences
- Required checklists, ethical statements, reproducibility statements, or artifact badges if applicable

If no authoritative venue source is available, label findings as general style suggestions, not compliance failures.

## Output Format

By default, review first and edit later. Do not modify the manuscript during initial review. Present findings one at a time or in small batches, then ask the user to choose for each finding:

- accept the suggested fix
- skip the finding
- provide a custom revision instruction

Track these decisions. Apply edits only after summarizing the accepted/custom changes and receiving final confirmation.

## Report Format

Return findings grouped by severity:

- `blocking`: likely correctness, consistency, submission, or technical-validity issue
- `important`: affects clarity, credibility, or reviewer confidence
- `minor`: local language or style cleanup

For each finding include:

- `location`: file, section, paragraph, figure/table/equation, or nearby unique text
- `type`: one of `language`, `terminology`, `number`, `abbreviation`, `notation`, `claim-strength`, `logic`, `figure-coverage`, `figure-consistency`, `venue-style`, `reference`
- `evidence`: exact text or source fact that supports the issue
- `issue`: concise explanation
- `suggested_fix`: minimal change or next check

End with:

- What was checked
- What was not checked
- Whether image-content review or venue-specific review still needs user input

## Guardrails

- Do not invent venue rules, paper content, citations, numerical results, or image details.
- Do not silently change technical claims; flag risky claims instead.
- Prefer issue lists over broad rewrites.
- Keep suggestions minimal and low-side-effect.
- When checking EPS figures, prefer rendered artifacts over raw EPS content for visual claims.
