# AI Interaction Log — HW1 Personal Portfolio Website

**Student:** 李冠穎 Kuan-Yin Lee  **Student ID:** _TBD_
**AI tool:** Claude (Cowork mode, Anthropic)  **Date:** 2026-09-29
**Full versioned record:** `HISTORY.md` (Q&A + every change) · `SPEC.md` (decisions & open questions)

---

## Prompt 1 — Delegating the whole assignment with constraints

**Prompt (to AI):**
> 可以幫我根據 RQ.md 做出整個作業嗎
> *(RQ.md: publish as a GitHub web page exposing only the website; use `info/` as the source but never publish it; log all Q&A and changes in a versioned md; write clear commit messages; record open questions in SPEC.md.)*

**AI output (selected):**
- Read `HW.md`, `RQ.md` and extracted text from the three resume/autobiography PDFs in `info/`.
- Also fetched the Google Doc handout linked in HW.md, finding the grading rubric and the “understand who you are in ~2 minutes” goal.
- Proposed a repo layout where **only `site/` is deployed** via a GitHub Actions Pages workflow, and `info/` is excluded by `.gitignore` plus a workflow guard.

**What I changed / why:**
Instead of writing my requirements as a long prompt, I kept them in `RQ.md` so the AI (and I) could refer back to them. The privacy requirement (RQ-2) was the most important constraint: I wanted my resume to be used as *input* but never leak to the public repo.

---

## Prompt 2 — Clarification vs. momentum

**AI output:** The AI stopped to ask two multiple-choice questions (what the homework is — HW.md was still empty on disk — and how to publish to GitHub).

**My action:** I declined the questions and repeated the original request.

**Result / iteration note:** By then I had saved HW.md, so the AI re-read it and continued. It moved every unresolved item (student ID, GitHub account, conflicting employment dates, e-mail typo, whether to show a photo) into a **QA table in `SPEC.md`** with a default assumption for each, rather than blocking. This is the workflow I wanted: progress first, decisions documented and reviewable.

---

## Prompt 3 — Content generation from the resume

**Implicit prompt:** build the four required sections (About, Education/Experience, Research/Projects, Contact) from `info/`.

**AI output (selected):**
- Bilingual (EN/中文) single page with a hero summary and three key numbers (24 years, 3 patents, 2 EI/IEEE papers).
- Featured research case study for my APNOMS 2025 paper written as *Problem → My role → Approach → Result*, with an SVG architecture diagram.
- IEEE Xplore links for both 2025 papers found by web search.

**Human judgment applied (accepted / modified / rejected):**
| AI suggestion | Decision | Reason |
|---|---|---|
| Use resume contact details | **Modified** | Kept only e-mail and city; no phone, no address, no PDFs. |
| Mention the rejected ICCE-TW submission | **Modified** | Kept the lesson (“used reviewer feedback to improve the next paper”) but not the venue name. |
| Chinese names for ICCAI co-authors | **Rejected** | They are not in my sources — AI should not invent them; kept the English names. |
| Architecture diagram agent names | **Accepted with label** | Marked “illustrative” because it is a simplification, not the paper’s figure. |
| One “2001–Present” job line (English CV) | **Modified** | Used the more precise Chinese CV (2001–04 branch engineer, 2004– Labs) and logged the conflict as Q4. |

---

## Prompt 4 — Visual QA with screenshots

**Action:** The AI rendered the page with a headless browser at 1280 px (desktop, English, light) and 390 px (mobile, Chinese, dark) and reviewed the screenshots.

**Issues found and fixed:**
1. Card labels stretched by a flexbox rule, pushing titles down → only body text flexes now.
2. Three stat cards wrapped 2 + 1 on mobile → forced a 3-column grid.
3. 📄 emoji rendered as an empty circle on a system without an emoji font → replaced with `↗`.
4. Diagram edge labels overlapped arrows → moved coordinates.

**Note:** No horizontal scroll at either width; the only console errors were blocked Google Fonts in the sandbox (system fonts are the fallback).

---

## Prompt 5 — Deployment & traceability

**AI output:** `.github/workflows/pages.yml` (deploys `site/` only), `scripts/check_links.py` (anchors, local files, external links), `scripts/make_submission.sh` (builds `hw1_<ID>.zip` without `info/`), and a commit-message convention (`type(scope): summary` + requirement IDs + `Refs: HISTORY.md vX.Y.Z`).

**What I will do myself:** fill in my student ID in `site/assets/config.js`, create the GitHub repo and push, enable Pages (“GitHub Actions” source), and rewrite the reflection in my own words.
