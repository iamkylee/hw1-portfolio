# TODO — 繳交前待辦清單

> 截止：**2026-10-06（二）23:59**　繳交檔：`hw1_<學號>.zip`
> 相關文件：待確認問題見 `SPEC.md §4 QA`；變更紀錄見 `HISTORY.md`。
> 完成一項就把 `[ ]` 改成 `[x]`。

## 1. 必做（沒做會扣分）

- [ ] **填學號（Q1）**
  打開 `site/assets/config.js`，把 `studentId: "TBD"` 改成你的學號。
  （可選）同檔 `program:` 填目前就讀系所（Q2），空字串會自動隱藏。

- [ ] **決定 GitHub repo 要公開哪些檔案** → 見下方 §3，選 A 或 B

- [ ] **建立 GitHub repo 並推上去**（Q3）
  1. GitHub → New repository，名稱例如 `hw1-portfolio`，**Public**，**不要**勾 README
  2. 在 Mac 終端機：
     ```bash
     cd ~/code/cgu/2026GenAI/HW1
     git remote add origin https://github.com/<你的帳號>/hw1-portfolio.git
     git push -u origin main --tags
     ```
  3. Repo → **Settings → Pages → Source：GitHub Actions**
  4. 到 **Actions** 分頁等部署完成（綠勾），取得網址 `https://<帳號>.github.io/hw1-portfolio/`
  5. 用手機與電腦各開一次，確認四個區段、中/EN 切換、連結都正常

- [ ] **改寫 Reflection（Q7）**
  `deliverables/Reflection.md` 是 AI 草稿，請用自己的話修改（300–500 字），然後：
  ```bash
  python3 scripts/build_reflection_pdf.py
  ```

- [ ] **打包繳交**
  ```bash
  bash scripts/make_submission.sh <學號> https://<帳號>.github.io/hw1-portfolio/ https://github.com/<帳號>/hw1-portfolio
  ```
  產出 `dist/hw1_<學號>.zip`（不含 info/），上傳到課程平台。**檔名格式錯會 ×0.9。**

## 2. 請確認的假設（不確認就維持現狀）

- [ ] **Q4 年資**：採中文履歷「2001–2004 分公司、2004 起研究院」兩段，而非英文履歷的「2001–至今」
- [ ] **Q6 Email**：履歷上的 `iamkylee@email.com` 疑為筆誤，網站用 `iamkylee@gmail.com`
- [ ] **Q8 架構圖**：三個 Agent 名稱（Inventory / Provisioning / Verification）為示意，已標 "illustrative"；要改成論文實際名稱嗎？
- [ ] **Q9 照片**：`info/` 裡有一張大頭照（目前**未使用**，網站用 SVG 字標頭像）。要放上網站嗎？
- [ ] **Q5 社群連結**：要放 GitHub / LinkedIn 嗎？填在 `config.js` 即可

## 3. Repo 公開範圍（回答「git remote 會不會把全部放上去？」）

`git push` 會上傳 **所有被 git 追蹤的檔案**，但 **`info/` 已被 `.gitignore` 排除**，不會上傳（`git check-ignore` 已驗證，含新加入的大頭照）。
目前會上傳的是：

| 會上傳 | 是否出現在網站上 |
|---|---|
| `site/`（網站本體） | ✅ 是 — GitHub Pages 只部署這個資料夾 |
| `HW.md`、`RQ.md`、`SPEC.md`、`HISTORY.md`、`TODO.md`、`README.md` | ❌ 否，但在 repo 頁面看得到 |
| `deliverables/`（AI Log、Reflection） | ❌ 否，但在 repo 頁面看得到 |
| `scripts/`、`.github/` | ❌ 否，但在 repo 頁面看得到 |
| `info/` | ❌ 不上傳 |

也就是：**「網站」只暴露 `site/`；但 Public repo 本身任何人都能瀏覽上表的檔案。**

請選一個：

- [ ] **A（建議）一個 Public repo 放全部（info/ 除外）**
  作業本來就要交 Source Code 與 AI Log，放在 repo 裡老師可直接看到開發紀錄與 commit 歷程，最有利於「Effective GenAI Use / Human Judgment」評分。照 §1 步驟做即可。

- [ ] **B repo 也只公開網站**
  建兩個 repo：`hw1-portfolio-src`（**Private**，放全部）＋ `hw1-portfolio`（**Public**，只放 `site/` 內容）。
  ```bash
  git remote add origin https://github.com/<帳號>/hw1-portfolio-src.git   # private
  git push -u origin main --tags
  git remote add site https://github.com/<帳號>/hw1-portfolio.git         # public
  git subtree push --prefix site site main
  ```
  Public repo → Settings → Pages → Source：**Deploy from a branch**，`main` / `(root)`。
  之後每次改網站都要再跑一次 `git subtree push --prefix site site main`。
  繳交時 Source Code 以 zip 內 `source/` 為主（老師看不到 private repo）。

## 4. 完成後告訴我

學號、repo 網址、A/B 選擇與 Q4–Q9 的回答給我，我會：更新 `config.js`、`SPEC.md` QA、`README.md` 網址，新增 `HISTORY.md` v0.2.0 並 commit。
