# SPEC — HW1 Personal Portfolio Website

> 本文件是本作業的**規格書 + 待確認問題 (QA) 清單**（對應 RQ-5）。
> 所有決策與假設都記在這裡，之後修改時以此為依據；變更歷程請見 `HISTORY.md`。

| 項目 | 內容 |
|---|---|
| 課程 | 2026 Generative AI (CGU) — Homework #1 |
| 截止 | **2026-10-06 23:59**（每遲交 4 小時扣 5%） |
| 繳交檔名 | **`hw1_<學號>.zip`**（格式錯誤 ×0.9） |
| 文件版本 | v0.2.5（2026-10-02） |

---

## 1. 需求來源與對應

| 編號 | 來源 | 需求 | 實作方式 | 狀態 |
|---|---|---|---|---|
| HW-1 | HW.md | 4 個區段：About（中英文姓名、學號）、Education/Experience、Research/Projects（≥1 研究專案）、Contact/Links | `site/index.html` 四個 `<section>` | ✅（學號待填，見 Q1） |
| HW-2 | HW.md | RWD（手機/桌機）、≥1 視覺元素、無壞連結 | CSS Grid + 760px 斷點；頭像 SVG、多代理人架構圖 SVG、時間軸；`scripts/check_links.py` | ✅ |
| HW-3 | HW.md | 公開網址 | GitHub Pages（Actions 部署） | ⏳ 需建立 repo 並 push（見 Q3） |
| HW-4 | HW.md | Source code | GitHub repo（zip 內亦附 `site/`） | ✅ |
| HW-5 | HW.md | AI Interaction Log：3–5 個關鍵 prompt、輸出、迭代說明 | `deliverables/AI_Interaction_Log.md` | ✅ 草稿 |
| HW-6 | HW.md | Reflection 300–500 字 PDF | `deliverables/Reflection.docx`（可編輯）→ 使用者自行匯出 `deliverables/Reflection.pdf` | ✅ 依使用者筆記 `Reflection.md` 改寫成英文（約 410 字），待使用者審閱/修改後匯出 PDF（見 Q7、Q12） |
| HW-7 | Handout | 能說明 AI 產出了什麼、為何接受或修改 | Log 與 HISTORY 中的「Human judgment」欄 | ✅ |
| RQ-1 | RQ.md | 做成 GitHub 網頁，**只暴露網頁部分** | `.github/workflows/pages.yml` 只把 `site/` 上傳為 Pages artifact | ✅ |
| RQ-2 | RQ.md | 資訊可由 `info/` 索引，但 **info/ 不可外流** | `.gitignore` 排除 `info/`；workflow 內建 guard，若 info/ 被追蹤就中止部署；網站未放任何履歷 PDF、電話、地址；打包腳本排除 info/ | ✅ |
| RQ-3 | RQ.md | 所有問答與變更記錄在 md 並可知版本 | `HISTORY.md`（SemVer + 日期 + commit） | ✅ |
| RQ-4 | RQ.md | commit 訊息寫清楚 | Conventional Commits，body 列出變更與需求編號；規範見 §5 | ✅ |
| RQ-5 | RQ.md | 問題用 QA 形式記在 SPEC.md | 本文件 §4 | ✅ |
| RQ-6 | RQ.md | 其他視需求增加 | 中/英切換、深色模式、`config.js` 集中設定、打包腳本、連結檢查 | ✅ |

## 2. 專案架構

```
HW1/
├── site/                  ← 唯一會公開的目錄（GitHub Pages）
│   ├── index.html         單頁：About / Education & Experience / Research & Projects / Contact
│   ├── .nojekyll
│   └── assets/
│       ├── config.js      ★ 學號、系所、Email、GitHub、LinkedIn 都在這裡改
│       ├── style.css      設計 token、深色模式、RWD
│       ├── main.js        語言切換、主題切換、手機選單、捲動標示
│       └── img/           photo.jpg（本人照片，直式 298×452，已移除 EXIF）、multi-agent.svg、favicon.svg
├── .github/workflows/pages.yml
├── deliverables/          AI Interaction Log、Reflection（繳交用，不上網站）
├── scripts/               check_links.py、make_submission.sh
├── info/                  ✗ 私人原始資料（.gitignore，不進 git、不進 zip）
├── HW.md / RQ.md          作業說明 / 本人需求
├── SPEC.md                本文件
├── HISTORY.md             版本化的問答與變更紀錄
├── TODO.md                繳交前待辦清單
└── README.md
```

設計決策：
- **純靜態 HTML/CSS/JS、無框架、無建置步驟**：作業規模小，降低出錯風險；GitHub Pages 可直接服務。
- **雙語**：同一份 HTML 以 `<span lang="en">` / `<span lang="zh">` 並列，`html[data-lang]` 控制顯示，預設英文；偏好存於 localStorage。
- **設定外置**：未確定的個人資訊（學號等）放 `config.js`，值為空時自動隱藏對應區塊 → 不會產生壞連結。
- **視覺**：本人照片（v0.2.0 起，取代 SVG 字標）；研究專案附簡化的多代理人架構示意圖；學經歷用時間軸；**主色為藍色**（淺/深色模式皆有對應 token）。
- **「約 2 分鐘看懂你是誰」**（Handout 要求）：Hero 區塊一句話定位 + 3 個數字重點，其後才是細節。

## 3. 內容來源對照（info/ → 網站）

| 網站內容 | 來源 | 備註 |
|---|---|---|
| 姓名、職稱、24 年經歷、技術演進 | Resume(202603).pdf、履歷-自傳.pdf | |
| 工作經歷兩段（2001–2004 / 2004–至今） | 履歷-自傳.pdf | 英文履歷寫 2001–Present 單一段，採用中文較細版本（見 Q4） |
| 學歷（北科碩、文化學士、東南工專） | 履歷-自傳.pdf | 名次資訊取自中文履歷 |
| 論文 3 篇、專利 3 件 | 兩份履歷 | IEEE Xplore 連結由網路搜尋確認（APNOMS: 11181316、ICCAI: 11105938） |
| SLM on Raspberry Pi、醫療 AI 願景 | 自傳 | 未寫出被拒會議名稱，只寫「首次投稿未獲接受」 |
| 博士研究方向（v0.2.0） | `info/v092401_博士研究計畫…pptx` | 只摘錄「研究方向」層級：組織成長／角色演化／好奇心驅動學習／安全驗證＋醫療願景；**不放**細節（指標、實驗設計、備援投影片 Q&A）、指導教授姓名、獎學金申請語境 |
| 大頭照（v0.2.0） | `info/大頭貼20260306.jpg` | 本人明確要求放上網站；只複製**去 EXIF**（原尺寸 298×452，直式）的 `site/assets/img/photo.jpg`，原檔仍留在 info/（不進 git） |
| 刻意 **不** 放 | — | 電話、地址、原始 PDF、申請文件語境 |
| `info/myblog.md` | — | 內容為部落格網址，已放入 Contact（v0.2.0） |

## 4. QA — 待確認問題（請直接在「回答」欄填寫）

| # | 問題 | 目前假設 / 預設 | 回答 | 狀態 |
|---|---|---|---|---|
| Q1 | 你的長庚大學 **學號** 是？（About 區段必填，zip 檔名也需要） | 網站顯示 `TBD` | `D1561001`（2026-09-29，寫在 config.js） | ✅ v0.2.0 |
| Q2 | 目前就讀的 **系所 / 學位**？（顯示在學歷時間軸最上方與學號旁） | 留空 → 自動隱藏 | 2026/09 起，長庚大學 人工智慧學系博士班 學生 | ✅ v0.2.0 |
| Q3 | GitHub **帳號與 repo 名稱**？repo 公開範圍選 A 或 B（見 TODO.md §3）？ | 建議 repo 名 `hw1-portfolio`、Public（免費方案的 Pages 需要 public repo；info/ 已排除不會外流） | | ❓ 必答 |
| Q4 | 英文履歷寫中華電信研究院 **2001–Present**，中文履歷寫 **2001–2004 分公司 + 2004–至今研究院**，以哪個為準？ | 採中文版（兩段） | | ❓ |
| Q5 | 要放 GitHub / LinkedIn 個人頁連結嗎？ | 不放（config 中留空即隱藏） | 放 GitHub、LinkedIn、部落格（config.js） | ✅ v0.2.0 |
| Q6 | 履歷上的 Email 是 `iamkylee@email.com`，看起來是筆誤；網站用 `iamkylee@gmail.com` 可以嗎？ | 用 gmail | | ❓ |
| Q7 | Reflection 是 AI 依你的筆記寫成的英文初稿；作業評分重視 human judgment，請用自己的話改寫/補充後，在 Word 匯出 PDF。 | 提供 `.docx`，由你編輯並匯出（你沒有 PDF 編輯軟體） | Word 版即可，自行轉 PDF（2026-09-30） | ✅ v0.2.4 |
| Q12 | Reflection 想再補一個**具體的個人修改例子**嗎？（目前有：補研究計劃、藍色配色、直式照片、現職更新。字數 ≈ 410，上限 500） | 如現況 | | ❓ |
| Q8 | 架構圖中的三個 Specialist Agent（Inventory / Provisioning / Verification）是示意命名，是否改成論文中的實際 agent 名稱？ | 圖說標示 "illustrative" | | ❓ |
| Q9 | 是否放個人照片取代 SVG 字標頭像？ | 不放照片（隱私） | 使用者已放入大頭照並要求上網站 | ✅ v0.2.0 |
| Q10 | 你目前**仍在中華電信研究院任職**嗎？（網站經歷寫「2004 – 至今 首席架構師」，同時就讀博士班；若已留職停薪／離職，請告訴我改寫） | 維持「至今」 | 已離開中華電信研究院，全職讀書研究；任職 2004 – 2026/08（2026-09-29） | ✅ v0.2.2 |
| Q11 | 博士研究方向摘要是否可公開？（已刻意只寫方向層級，未含細節、指導教授、獎學金字樣；若要加入指導教授或再精簡請告知） | 如現況 | | ❓ |
| Q13 | 簡介用 "self-evolving／自我演化"，但「博士研究方向」區塊與題目用 "Self-Growing／自成長"（來自簡報）。要統一用詞嗎？ | 暫時並存 | | ❓ |

> 回答後告訴我（或直接改表格），我會同步更新網站、HISTORY.md 並 commit。

## 5. Commit 規範（RQ-4）

```
<type>(<scope>): <一句話摘要>

- 變更 1（對應 HW-x / RQ-x / Qx）
- 變更 2
Why: 為什麼這樣改
Refs: HISTORY.md vX.Y.Z
```
type：`feat` 新功能、`fix` 修正、`content` 內容、`docs` 文件、`style` 樣式、`ci` 部署、`chore` 雜項。
每次 commit 都要在 `HISTORY.md` 新增一個版本段落。

## 6. 驗收清單

- [x] 四個區段齊全（About 含中英文姓名 + 學號欄位）
- [x] 學號已填（Q1）
- [x] 桌機 1280px / 手機 390px 無水平捲動（Playwright 截圖驗證）
- [x] 視覺元素 ≥ 1（頭像、架構圖、時間軸）
- [x] 連結檢查：站內錨點與外部連結皆有效（`python3 scripts/check_links.py`）
- [ ] GitHub Pages 公開網址可開啟（Q3 後）
- [x] info/ 不在 git、不在網站、不在 zip
- [ ] Reflection.docx 已由本人審閱、匯出為 `deliverables/Reflection.pdf`（Q7）
- [ ] `hw1_<學號>.zip` 已產生並上傳
