# HISTORY — 問答與變更紀錄

> 對應 RQ-3：本專案所有「問答（Q&A）」與「變更（Change）」依版本記錄於此。
> 版本採 SemVer：`MAJOR.MINOR.PATCH`（內容/功能新增 → MINOR；修正 → PATCH）。
> 每個版本對應一個 git commit；commit 訊息 body 會寫 `Refs: HISTORY.md vX.Y.Z`，可雙向查找。
> 待回覆的問題集中在 `SPEC.md §4 QA`。

| 版本 | 日期 | 摘要 | Commit |
|---|---|---|---|
| v0.2.4 | 2026-09-30 | Reflection：依使用者筆記改寫為英文 Word 檔（可編輯），移除舊的 AI 草稿 PDF 與 PDF 產生腳本 | 見 `git log`（tag `v0.2.4`） |
| v0.2.3 | 2026-09-29 | 修正瀏覽器快取舊 CSS/圖片：資源網址加 `?v=` 版本參數 | 見 `git log`（tag `v0.2.3`） |
| v0.2.2 | 2026-09-29 | 照片改為直式（不裁切）；中華電信任職期間精確到 2026/08 | 見 `git log`（tag `v0.2.2`） |
| v0.2.1 | 2026-09-29 | 現職更新：已離開中華電信研究院、全職就讀博士班 | 見 `git log`（tag `v0.2.1`） |
| v0.2.0 | 2026-09-29 | 博士研究方向、學歷更新（長庚 AI 博士班）、本人照片、藍色主題、Contact 加 GitHub/LinkedIn/部落格 | 見 `git log`（tag `v0.2.0`） |
| v0.1.1 | 2026-09-29 | 新增 TODO.md 繳交前待辦；說明 repo 公開範圍 | tag `v0.1.1` |
| v0.1.0 | 2026-09-29 | 初版：網站、GitHub Pages 部署、SPEC/HISTORY、繳交文件草稿 | `0671cad`（tag `v0.1.0`） |

---

## v0.2.4 — 2026-09-30（Asia/Taipei）

### Q&A 紀錄

| # | 提問者 | 內容 | 回應 / 處理 |
|---|---|---|---|
| 20 | 使用者 | 發現作業還需要 Reflection（300–500 words）；已建立自己的 `Reflection.md` 供參考，可視需要 QA；因題目要求 PDF 但沒有 PDF 編輯軟體，希望提供 Word 檔，自行轉 PDF | 依使用者筆記的四個提問（What you asked AI to do / What it did well / Weaknesses & what you changed / What you learned）改寫為英文（課程為全英文），產出 `deliverables/Reflection.docx`（A4 一頁、約 410 字）與同內容的 `deliverables/Reflection.md` |
| 21 | AI | Q&A：是否要補個人修改例子 | 記入 SPEC Q12；不阻擋，先交付可用版本 |

### 變更內容
- 新增 `deliverables/Reflection.docx`；`deliverables/Reflection.md` 改為同一份英文內容。
- 使用者原稿 `Reflection.md`（專案根目錄）**保持原樣，未修改、未納入版控**。
- 移除 `deliverables/Reflection.pdf`（舊 AI 草稿，內容已過時）與 `scripts/build_reflection_pdf.py`；`make_submission.sh` 仍會檢查 `deliverables/Reflection.pdf` 存在，避免遺漏。

### Human judgment
- 內容**只使用使用者自己筆記中的事實**（Gemini 建議 GitHub Pages、info/RQ.md 流程、雙語超出預期、逐步教學、想要更多提問、補研究計劃只寫方向、學到的三點）；另補上本次對話中使用者親身經歷且可查證的例子（登入失敗、Pages 設定、artifact 重複錯誤、隱私排除、藍色/照片/現職修改）。
- 語氣維持第一人稱、使用者的觀點；不虛構使用者未提過的感想。
- 字數：內文 ≈ 410（含標題與抬頭 ≈ 450），落在 300–500 內，無論以何種方式計算。

## v0.2.3 — 2026-09-29（Asia/Taipei）

### Q&A 紀錄

| # | 提問者 | 內容 | 回應 / 處理 |
|---|---|---|---|
| 18 | 使用者 | Actions 重新 Run 出現 "Multiple artifacts named github-pages … Artifact count is 3" | 原因：對同一筆失敗紀錄反覆 Re-run，會在同一 run 累積同名 artifact。解法：改推新 commit / 手動 Run workflow 開新的執行，勿再 Re-run 舊紀錄；程式無誤 |
| 19 | 使用者 | 本機看到長型照片，線上網站仍是正方形，但 2026/08 已更新 | 已用線上 CSS 驗證伺服器端 `aspect-ratio: 298 / 452` 是新的 → 使用者瀏覽器快取了舊的 `style.css`/`photo.jpg`（GitHub Pages 預設快取約 10 分鐘）。短期：強制重新整理；長期：資源網址加版本參數 |

### 變更內容
- `site/index.html`：所有 `assets/...` 的 `href`/`src` 加上 `?v=0.2.3`（CSS、JS、config、圖片、favicon）。
- 之後修改任何 `site/assets/` 內檔案時，須同步遞增 `index.html` 中的 `?v=` 版本（README 已註明）。

### Human judgment
- 先驗證線上檔案內容，再判斷是快取問題而非部署失敗，避免無謂地改動程式。

## v0.2.2 — 2026-09-29（Asia/Taipei）

### Q&A 紀錄

| # | 提問者 | 內容 | 回應 / 處理 |
|---|---|---|---|
| 16 | 使用者 | 希望照片「長型一點」 | v0.2.0 為取正方形裁切；改為使用原圖完整直式比例（298×452，約 2:3），不再裁切 |
| 17 | 使用者 | 中華電信研究院任職期間為「2004 – 2026/08」 | 經歷時間改為 `2004 – 2026/08`（補足 v0.2.1 所缺月份） |

### 變更內容
- `site/assets/img/photo.jpg`：改為原圖全尺寸直式（298×452），仍移除 EXIF；`<img>` 尺寸屬性與 CSS `aspect-ratio` 同步為 298/452。
- 首頁照片欄寬 300px（手機 210px），圓角框與藍色外框不變。
- Experience 時間：`2004 – 2026/08`。

### Human judgment
- 原圖僅 298 px 寬，直式顯示在桌機約 300 px 寬，不需放大即可清晰；不使用插值放大以免變糊。若之後有更高解析度原圖，替換 `photo.jpg` 即可。

## v0.2.1 — 2026-09-29（Asia/Taipei）

### Q&A 紀錄

| # | 提問者 | 內容 | 回應 / 處理 |
|---|---|---|---|
| 15 | 使用者 | 回答 Q10：「目前離開中華電信研究院工作，全職讀書研究」，請更新上去 | SPEC Q10 標記為已回答；網站與文件依此更新 |

### 變更內容
- About：eyebrow 改為「Ph.D. Student in AI · Former Chief Architect／人工智慧博士生 · 前首席架構師」；簡介改為「離開中華電信研究院，全職就讀長庚大學人工智慧學系博士班」。
- Experience：中華電信研究院一段結束年份由「至今」改為「2004 – 2026」，職責描述改為過去式。
- Education：博士班條目加註「全職博士研究生」。
- meta description / og:description 同步改為 former Chief Architect。

### Human judgment
- 使用者只說「離開」而未給日期 → 結束年份寫 **2026**（與 2026/9 入學銜接），**不寫月份**，避免捏造；已在 TODO.md 註明可再精確。
- 「24 年電信研發」數字沿用使用者履歷，未重新計算。

## v0.2.0 — 2026-09-29（Asia/Taipei）

### Q&A 紀錄

| # | 提問者 | 內容 | 回應 / 處理 |
|---|---|---|---|
| 9 | 使用者 | `git push` 出現 "Invalid username or token" | GitHub 不再接受密碼；提供 gh CLI / PAT / SSH 三種方式，使用者自行推送成功（遠端 main = `fab300f`） |
| 10 | 使用者 | Pages 網址 404 → 截圖確認 Source 為 "Deploy from a branch" | 指示改為 **GitHub Actions**；網站上線 |
| 11 | 使用者（RQ.md `[2026092902]`） | 已增加學號等資料；新增照片；請依「博士未來簡報」更新研究計畫（只寫研究方向）、更新履歷（2026/9 長庚大學人工智慧學系博士班學生）、配色改藍色、完成後推上去 | 見下方「變更內容」；SPEC Q1/Q2/Q5/Q9 標記為已回答 |
| 12 | AI | `config.js` 第 8 行語法錯誤：`program: ""Ph.D. …"`（多一個引號），會使整份設定失效 | 已修正；`program` 欄位改由 HTML 雙語呈現，不再依賴 config |
| 13 | AI | 照片位於 `info/`，與 RQ-2「info 不可外流」衝突 | 依使用者明確要求，只複製**縮圖（298×298）並移除 EXIF** 的 `site/assets/img/photo.jpg`；原檔仍在 info/ 且不進 git（SPEC §3 已記錄） |
| 14 | AI | 新增待確認：Q10 是否仍在中華電信任職、Q11 研究方向摘要公開範圍 | 已寫入 SPEC §4 |

### 變更內容
**內容**
- About：eyebrow 改為「Ph.D. Student in AI · Chief Architect」；簡介改寫（2026/9 入學長庚大學人工智慧學系博士班）；學號旁顯示系所；興趣標籤更新。
- Education：新增最上方「2026/09 – 至今　人工智慧學系博士班 學生／長庚大學 智慧運算學院」。
- Research & Projects：新增**博士研究方向**區塊（題目 *Curiosity-Driven Self-Growing Multi-Agent Systems／好奇心驅動的自成長多代理人系統*），四大方向：組織成長、角色演化、好奇心驅動的主動學習、安全與驗證；原有論文區改為「前期研究成果」。
- 「未來方向」改寫為醫療領域願景（用系統整合的廣度串連各專科深度）。
- Contact：新增 GitHub、LinkedIn、部落格連結（由 `config.js` 控制）。

**視覺**
- 主色由青綠改為**藍色**（淺色 `#1d4ed8`、深色 `#60a5fa`）；背景、卡片、SVG 圖同步調整。
- 頭像由 SVG 字標改為本人照片（圓角方形＋藍框）；移除不再使用的 `avatar.svg`。

**修正 / 其他**
- 修正 `config.js` 語法錯誤；新增 `blog` 欄位。
- RQ.md 加入 `[2026092902]` 需求紀錄。

### Human judgment
- **只摘錄研究「方向」**：簡報中的實驗設計、指標、備援 Q&A、指導教授、獎學金申請語境皆不放（依使用者「不用寫那麼細」）。
- **照片**：使用者明確要求才公開；縮圖並移除 EXIF，避免帶出拍攝地點等中繼資料。
- **待確認而非猜測**：現職狀態（Q10）不自行改寫。

## v0.1.1 — 2026-09-29（Asia/Taipei）

### Q&A 紀錄

| # | 提問者 | 內容 | 回應 / 處理 |
|---|---|---|---|
| 6 | 使用者 | 「還需處理的部分，可以放成一個 md 嗎？」 | 新增 `TODO.md`：必做、待確認假設、repo 公開範圍、完成後回報事項 |
| 7 | 使用者 | 「git remote HW1 的話，不會把全部都放上去嗎？還是有寫 ignore？」 | push 會上傳所有被追蹤檔案；`info/` 已由 `.gitignore` 排除（`git check-ignore` 驗證）。網站只部署 `site/`，但 Public repo 可瀏覽其餘文件 → 在 TODO.md §3 提供 A（單一 public repo）/ B（private 原始碼 + public 只放 site）兩方案待選 |
| 8 | AI | 發現 `info/` 新增一張大頭照 | 已確認被 ignore、未使用；列為 SPEC Q9 / TODO §2 待決定 |

### 變更內容
- 新增 `TODO.md`
- `HISTORY.md` 版本表補上 v0.1.0 commit hash

## v0.1.0 — 2026-09-29（Asia/Taipei）

### Q&A 紀錄

| # | 提問者 | 內容 | 回應 / 處理 |
|---|---|---|---|
| 1 | 使用者 | 「可以幫我根據 RQ.md 做出整個作業嗎」 | AI 讀取 RQ.md、HW.md、info/；HW.md 與 info/myblog.md 起初為 0 bytes |
| 2 | AI | 以選項詢問：作業需求是什麼？GitHub 要如何發佈？ | 使用者**拒絕**回答並重述原需求 → AI 改為「先做合理假設、把問題記到 SPEC.md QA」（符合 RQ-5） |
| 3 | 使用者 | 重述「可以幫我根據 RQ.md 做出整個作業嗎」 | AI 重新讀取，HW.md 此時已有內容（1363 bytes），據此開始實作 |
| 4 | AI | 讀取 HW.md 中 Google Doc 作業說明 | 取得評分標準：Functionality 20 / Content 20 / Design 20 / GenAI Use 20 / Human Judgment 10 / Reflection 10；要求「2 分鐘內看懂你是誰」 |
| 5 | AI | 發現資料不一致與缺漏 | 記入 SPEC.md QA：Q1 學號、Q2 系所、Q3 GitHub repo、Q4 年資起訖不一致、Q5 社群連結、Q6 Email 筆誤、Q7 Reflection 需本人修訂、Q8 架構圖命名、Q9 照片 |

### 變更內容

**新增**
- `site/index.html`：單頁網站，四區段 About / Education & Experience / Research & Projects / Contact；中英雙語。
- `site/assets/style.css`：設計 token、深色模式（跟隨系統 + 手動切換）、760px/900px 斷點 RWD。
- `site/assets/main.js`：語言切換、主題切換、手機漢堡選單、捲動時高亮目前區段、套用 config。
- `site/assets/config.js`：學號/系所/Email/GitHub/LinkedIn 集中設定；空值自動隱藏區塊（避免壞連結）。
- `site/assets/img/`：`avatar.svg`（字標 + 代理人網路）、`multi-agent.svg`（研究架構示意）、`favicon.svg`。
- `.github/workflows/pages.yml`：只部署 `site/` 至 GitHub Pages；含「info/ 若被追蹤即中止」guard。
- `.gitignore`：排除 `info/`、`*.zip`、`dist/`。
- `SPEC.md`、`HISTORY.md`、`README.md`。
- `deliverables/AI_Interaction_Log.md`、`deliverables/Reflection.md` + `Reflection.pdf`（草稿）。
- `scripts/check_links.py`（站內錨點/資源與外部連結檢查）、`scripts/make_submission.sh`（產生 `hw1_<學號>.zip`，排除 info/）。

**迭代修正（同版本內，經截圖檢查後）**
- 研究卡片的 eyebrow 標籤被 `flex:1` 撐開，導致標題下移 → 只讓內文段落 `flex:1`。
- 手機版三個數字卡片換行成 2+1 → 改為 3 欄 grid。
- 聯絡區的 📄 emoji 在部分系統無字型顯示為空白 → 改為 `↗` 符號。
- 架構圖邊線標籤 "Command"/"Primary Key" 壓到線 → 調整座標。
- 架構圖加註 "illustrative"，避免讀者誤以為是論文原圖（Q8）。
- ICCAI 共同作者中文姓名無法由資料確認 → 維持英文原名，不自行翻譯（避免捏造）。

### Human judgment（採用 / 修改 / 拒絕 AI 產出的理由）
- **拒絕放入**電話、地址、原始 PDF：作業只要求公開網站，個資最小化。
- **拒絕**把「報考台大博士班」語境搬上網站：那是申請文件，不適合課程作品集。
- **修改**「被拒稿」敘述：不寫會議名稱，改為強調從評審意見改進 — 誠實但聚焦成長。
- **採用**中文履歷較細的年資分段，並將差異列為 Q4 待本人確認。
