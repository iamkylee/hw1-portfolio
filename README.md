# 李冠穎 Kuan-Yin Lee — Portfolio (CGU 2026 GenAI · HW1)

Personal portfolio website built with generative AI as a collaborator.
Only the `site/` folder is published to GitHub Pages.

- **Live site:** `https://<username>.github.io/<repo>/` *(fill in after first deploy)*
- **Spec & open questions:** [SPEC.md](SPEC.md)
- **Versioned Q&A / change log:** [HISTORY.md](HISTORY.md)
- **Deliverables:** [AI Interaction Log](deliverables/AI_Interaction_Log.md) · [Reflection](deliverables/Reflection.md)

## Run locally

```bash
python3 -m http.server 8000 -d site   # open http://localhost:8000
python3 scripts/check_links.py        # anchors, local assets, external links
```

## Cache busting

Assets are referenced as `assets/xxx?v=<version>` in `site/index.html`. When you change anything under
`site/assets/`, bump that `?v=` value (e.g. `0.2.3` → `0.2.4`) so browsers do not show a stale cached copy.

## Edit personal info

Everything that may change (student ID, program, e-mail, GitHub, LinkedIn) lives in
[`site/assets/config.js`](site/assets/config.js). Empty values hide their block automatically.

## Publish to GitHub Pages (first time)

1. Create an empty repo on GitHub (e.g. `hw1-portfolio`, Public, **no** README).
2. In this folder:
   ```bash
   git remote add origin https://github.com/<username>/hw1-portfolio.git
   git push -u origin main
   ```
3. Repo → **Settings → Pages → Build and deployment → Source: GitHub Actions**.
4. The workflow `.github/workflows/pages.yml` deploys **only `site/`**. The URL appears in the Actions run.

`info/` (raw resume files) is in `.gitignore` and the workflow refuses to deploy if it is ever tracked.

## Build the submission

```bash
# 先在 Word 編輯 deliverables/Reflection.docx，另存為 deliverables/Reflection.pdf
bash scripts/make_submission.sh <studentID> <siteURL> <repoURL>
# → dist/hw1_<studentID>.zip
```
