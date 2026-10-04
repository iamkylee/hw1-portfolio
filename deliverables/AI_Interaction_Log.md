# AI Interaction Log — HW1 Personal Portfolio Website

**Student:** 李冠穎 Kuan-Yin Lee  **Student ID:** D1561001
**AI tools:** Gemini (planning the hosting choice) · Claude (building, deploying, documenting)
**Period:** 2026-09-29 → 2026-10-04
**Live site:** https://iamkylee.github.io/hw1-portfolio/  **Repo:** https://github.com/iamkylee/hw1-portfolio
**Full versioned record:** `HISTORY.md` (every question and change, v0.1.0 → v0.2.5) · `SPEC.md` (decisions and open questions)

Five key prompts are listed below, each with a selected output and what I judged, changed or rejected.

---

## Prompt 1 — Delegating the whole assignment with written constraints

**Prompt (to Claude):**
> 可以幫我根據 RQ.md 做出整個作業嗎
> *(RQ.md: publish as a GitHub web page exposing only the website; use `info/` as the source but never publish it; record all Q&A and changes in a versioned md; write clear commit messages; record open questions in SPEC.md.)*

**AI output (selected):**
- Read `HW.md`, `RQ.md` and the three resume / autobiography PDFs in `info/`; also fetched the Google Doc handout and found the grading rubric and the “understand who I am in ~2 minutes” goal.
- Proposed a repo where **only `site/` is deployed** by a GitHub Actions Pages workflow, with `info/` excluded by `.gitignore` plus a workflow guard that fails if `info/` is ever tracked.

**What I did / why:** Instead of one long prompt I kept my rules in `RQ.md`, so both the AI and I could re-read them. The privacy rule (RQ-2) mattered most: my resume is *input*, never *output*.

---

## Prompt 2 — Clarification versus momentum

**AI output:** Claude stopped to ask two multiple-choice questions (what the homework was, because `HW.md` was still empty on disk, and how to publish to GitHub).

**My action:** I declined the questions and repeated my request.

**Result:** Claude re-read `HW.md`, made reasonable assumptions, and put every unresolved item into a **QA table in `SPEC.md`** (student ID, GitHub account, conflicting employment dates, e-mail typo, photo …), each with a default. Progress first, decisions logged and reviewable.

---

## Prompt 3 — First content draft from my resume, and my editing of it

**Implicit prompt:** build the four required sections (About, Education/Experience, Research/Projects, Contact) from `info/`.

**AI output (selected):** a bilingual (EN / 中文) single page with a hero summary, three key numbers, a research case study written as *Problem → My role → Approach → Result*, an SVG architecture diagram and IEEE Xplore links found by web search.

**Human judgment (accepted / modified / rejected):**

| AI suggestion | Decision | Reason |
|---|---|---|
| Use all resume contact details | **Modified** | Only e-mail and city; no phone, no address, no PDF files. |
| Mention the rejected conference submission | **Modified** | Kept the lesson (used reviewer feedback to improve the next paper), dropped the venue. |
| Chinese names for ICCAI co-authors | **Rejected** | Not in my sources — the AI must not invent them. |
| Architecture diagram agent names | **Accepted, labelled** | Marked “illustrative”: a simplification, not the paper's figure. |
| One “2001–Present” job line (English CV) | **Modified** | Used the more precise Chinese CV and logged the conflict as an open question. |

---

## Prompt 4 — Visual QA with screenshots

**Action:** Claude rendered the page in a headless browser at 1280 px (desktop, English, light) and 390 px (mobile, Chinese, dark), then reviewed the screenshots itself.

**Issues found and fixed:** card labels stretched by a flexbox rule; three stat cards wrapped 2 + 1 on mobile; an emoji icon rendered as an empty circle without an emoji font; diagram labels overlapped arrows. No horizontal scrolling at either width.

**Later repeat of the same loop:** after I added my photo, the blue theme and the portrait crop, the screenshots were checked again before each commit.

---

## Prompt 5 — Iterating with my own material and decisions

**My prompts (summarised):**
> 請根據我的博士未來簡報更新研究計劃，不用寫那麼細，只要寫研究方向即可 … 我的 2026/9 就到長庚大學人工智慧學系博士班 … 配色以藍色為主 … 我希望我的照片長型一點 … 離開中華電信研究院（2004–2026/08），全職讀書 … 介紹請改成下面這段（my own English paragraph)

**AI output and my judgment:**
- **Research direction:** read my 21-slide PhD plan (.pptx) and wrote only a direction-level block — *Curiosity-Driven Self-Growing Multi-Agent Systems* with four pillars (organisation growth, role evolution, curiosity-driven learning, safety & validation). I had asked for no detail, so experiments, metrics, backup Q&A, advisor name and scholarship wording were left out.
- **Photo:** the AI first cropped it square; I asked for a taller shape, so it now uses the full portrait. It also stripped the EXIF data. The original stays untracked in `info/`.
- **Blue theme, education line, career status** were applied exactly as I stated them; the AI did not guess the leaving month and asked/recorded it as an open question until I supplied “2026/08”.
- **About paragraph:** my own English sentence was used verbatim; the Chinese version is a matching rewrite that I reviewed.
- **Bug caught:** the AI found a syntax error I had made in `config.js` (a stray quote) that would have broken the page.

**Deployment troubleshooting (with my screenshots):** GitHub password login rejected → token / CLI login; Pages source set to “branch” → changed to “GitHub Actions”; “Multiple artifacts named github-pages” → caused by re-running a failed run, fixed by starting a new run; my browser showed the old square photo → browser cache, fixed with `?v=` version parameters on assets.

---

### Summary of iteration notes
1. A written spec (`RQ.md`, `SPEC.md`) kept the AI consistent and made its output checkable.
2. The AI was strongest at breadth (layout, bilingual text, dark mode, deployment); I remained the judge of privacy, accuracy and emphasis.
3. Every change is traceable: `HISTORY.md` entries ↔ git tags `v0.1.0`–`v0.2.5` ↔ commit messages.
