---
name: paper-review
description: Review CS research papers for language, consistency, logic, figures, notation, claims, and venue/style compliance. Ask for venue before applying venue-specific rules.
---

# Paper Review

Review systems/CS papers, especially LaTeX drafts with experiments, workloads, figures, tables, equations, and references. Prefer concrete, evidence-backed issues over broad rewriting.

## Intake

Ask only if missing:

- Target venue or journal
- Style guide, template, author kit, or checklist if available
- Main paper entry file, usually a `.tex` file
- Whether rendered figures are available for visual checking

If no venue source is provided, proceed with general systems-paper standards and do not claim venue compliance.

## Checks

### Language

- Spelling, grammar, articles, tense, plurality, and subject-verb agreement
- Awkward, ambiguous, overly long, or hard-to-parse sentences
- Local wording that can be made clearer without changing technical meaning
- Repeated words, inconsistent capitalization, punctuation, and hyphenation
- Minimal local fixes only; do not rewrite large sections unless asked

### Terminology

- System, component, method, workload, benchmark, baseline, and metric names
- One concept using multiple names without explanation
- Similar terms that may refer to different concepts but are used interchangeably
- Capitalization and hyphenation of technical names
- Consistency between abstract, introduction, evaluation, conclusion, captions, and tables

### Numbers and Units

- Numerical results repeated in multiple places should agree
- Percentages, speedups, slowdowns, latency, throughput, memory, overhead, and scalability claims
- Units, spacing, decimal precision, significant digits, and comparison direction
- Textual claims should match table/figure values and captions
- Abstract, introduction, evaluation, and conclusion should not report conflicting numbers

### Abbreviations

- First use should define the abbreviation unless it is universally obvious in context
- Later uses should not alternate between multiple abbreviations for the same concept
- Acronym capitalization should be consistent
- Abbreviations in figures, tables, and captions should be understandable or explained

### Notation and Math

- Variables should not change meaning across sections, equations, algorithms, or captions
- Scalars, vectors, matrices, sets, functions, and constants should use consistent styling
- Equation, theorem, lemma, algorithm, and symbol references should be correct
- Symbols introduced in equations should be defined before or immediately after use
- Avoid overloaded notation unless the distinction is explicit

### Logic and Claims

- Claims should be supported by methods, experiments, theory, or citations
- Flag overclaiming words such as `prove`, `guarantee`, `always`, `significantly`, `state-of-the-art`, or `outperforms` when evidence is insufficient
- Distinguish causation from correlation
- Check that limitations, assumptions, and failure cases are not hidden by broad wording
- Conclusions should not introduce new results not established earlier

### Systems Evaluation

- Baseline fairness and configuration comparability
- Workload and benchmark representativeness
- Hardware/software setup, versions, parameters, and experimental conditions
- Whether latency, throughput, overhead, scalability, memory, and reliability claims are backed by results
- Whether evaluation evidence supports the main contribution and stated scope

### Figures and Tables

- Every figure/table should be referenced in the text
- Every figure/table should be explained, not merely mentioned as `see Figure X`
- Labels, captions, legends, subfigure names, axis names, and text references should agree
- Captions should be self-contained enough to understand the result
- Textual claims about trends, ordering, colors, methods, axes, or subfigures should match the figure/table

### References and Cross-References

- Figure, table, section, equation, algorithm, theorem, and appendix references should resolve correctly
- Citation claims should match what the cited work is being used to support when evidence is available
- Reference style should be consistent with the venue/template when provided
- Avoid missing references for related work, baselines, tools, datasets/workloads, or benchmark suites when they are central to the claim

### Venue and Style

- Apply only when an authoritative venue/template/checklist is available
- Page limits, abstract limits, anonymity, appendix/supplementary rules, artifact rules, and required statements
- Citation/reference style, capitalization, section naming, figure/table conventions, and checklist requirements
- If no venue source is available, label findings as general style suggestions, not compliance failures

## Figure Reading

- Do visual figure checking by default, in addition to LaTeX source checks.
- First check figures/tables from LaTeX source: labels, captions, references, subfigure names, and nearby claims.
- For visual claims, inspect rendered figures rather than raw source text.
- For EPS/PDF figures, convert or ask for rendered images before making visual judgments.
- Do not invent visual details, colors, trends, axes, or legends that are not visible from the provided/rendered figure.

## Workflow

- Batch by issue type across the paper, not by section, so global consistency issues remain visible.
- Use passes such as language, terminology, numbers, abbreviations, notation, claims, figures/tables, venue style.
- In each pass, report at most 10 findings by default.
- If there are many issues in one pass, choose the highest-impact or most representative findings first and ask whether to continue that pass.
- For language-only issues, default to at most 10 total findings unless the user explicitly asks for more polishing.
- Prefer recurring language patterns over isolated micro-edits when many similar issues exist.
- Number findings from 1 in each batch.
- Explain the reason in Chinese by default; include exact evidence and a minimal suggested fix.
- Ask: `接受哪些序号？例如 1,3,5。未列出的默认 skip；自定义写 2: 改成 ...`
- Apply accepted/custom edits immediately after each batch, summarize briefly, then continue.

## Finding Format

For each finding include:

- location: file, section, paragraph, figure/table/equation, or nearby unique text
- type: language, terminology, number, abbreviation, notation, claim, logic, figure/table, venue-style, reference
- evidence: exact text, source fact, or visible figure detail supporting the issue
- issue: concise Chinese explanation of why it is a problem
- suggested fix: minimal edit or next check

Use severities only when helpful: `blocking`, `important`, `minor`.

## Guardrails

- Do not invent venue rules, content, citations, numbers, or image details.
- Do not silently change technical claims; flag risky claims.
- Keep edits minimal and low-side-effect.
- For EPS or visual-only issues, use rendered images or ask the user instead of trusting raw EPS text.
