# SPEC — HW1 Personal Portfolio Website

> 本文件是本作業的**規格書 + 待確認問題 (QA) 清單**（對應 RQ-5）。
> 所有決策與假設都記在這裡，之後修改時以此為依據；變更歷程請見 `HISTORY.md`。

| 項目 | 內容 |
|---|---|
| 課程 | 2026 Generative AI (CGU) — Homework #1 |
| 截止 | **2026-10-06 23:59**（每遲交 4 小時扣 5%） |
| 繳交檔名 | **`hw1_<學號>.zip`**（格式錯誤 ×0.9） |
| 文件版本 | v0.1.0（2026-09-29） |

---

## 1. 需求來源與對應

| 編號 | 來源 | 需求 | 實作方式 | 狀態 |
|---|---|---|---|---|
| HW-1 | HW.md | 4 個區段：About（中英文姓名、學號）、Education/Experience、Research/Projects（≥1 研究專案）、Contact/Links | `site/index.html` 四個 `<section>` | ✅（學號待填，見 Q1） |
| HW-2 | HW.md | RWD（手機/桌機）、≥1 視覺元素、無壞連結 | CSS Grid + 760px 斷點；頭像 SVG、多代理人架構圖 SVG、時間軸；`scripts/check_links.py` | ✅ |
| HW-3 | HW.md | 公開網址 | GitHub Pages（Actions 部署） | ⏳ 需建立 repo 並 push（見 Q3） |
| HW-4 | HW.md | Source code | GitHub repo（zip 內亦附 `site/`） | ✅ |
| HW-5 | HW.md | AI Interaction Log：3–5 個關鍵 prompt、輸出、迭代說明 | `deliverables/AI_Interaction_Log.md` | ✅ 草稿 |
| HW-6 | HW.md | Reflection 300–500 字 PDF | `deliverables/Reflection.md` → `Reflection.pdf` | ✅ 草稿（**請用自己的話修改**，見 Q7） |
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
│       └── img/           avatar.svg、multi-agent.svg、favicon.svg（皆原創向量圖）
├── .github/workflows/pages.yml
├── deliverables/          AI Interaction Log、Reflection（繳交用，不上網站）
├── scripts/               check_links.py、make_submission.sh
├── info/                  ✗ 私人原始資料（.gitignore，不進 git、不進 zip）
├── HW.md / RQ.md          作業說明 / 本人需求
├── SPEC.md                本文件
├── HISTORY.md             版本化的問答與變更紀錄
└── README.md
```

設計決策：
- **純靜態 HTML/CSS/JS、無框架、無建置步驟**：作業規模小，降低出錯風險；GitHub Pages 可直接服務。
- **雙語**：同一份 HTML 以 `<span lang="en">` / `<span lang="zh">` 並列，`html[data-lang]` 控制顯示，預設英文；偏好存於 localStorage。
- **設定外置**：未確定的個人資訊（學號等）放 `config.js`，值為空時自動隱藏對應區塊 → 不會產生壞連結。
- **視覺**：頭像用 SVG 字標（不上傳真實照片、保護隱私）；研究專案附簡化的多代理人架構示意圖；學經歷用時間軸。
- **「約 2 分鐘看懂你是誰」**（Handout 要求）：Hero 區塊一句話定位 + 3 個數字重點，其後才是細節。

## 3. 內容來源對照（info/ → 網站）

| 網站內容 | 來源 | 備註 |
|---|---|---|
| 姓名、職稱、24 年經歷、技術演進 | Resume(202603).pdf、履歷-自傳.pdf | |
| 工作經歷兩段（2001–2004 / 2004–至今） | 履歷-自傳.pdf | 英文履歷寫 2001–Present 單一段，採用中文較細版本（見 Q4） |
| 學歷（北科碩、文化學士、東南工專） | 履歷-自傳.pdf | 名次資訊取自中文履歷 |
| 論文 3 篇、專利 3 件 | 兩份履歷 | IEEE Xplore 連結由網路搜尋確認（APNOMS: 11181316、ICCAI: 11105938） |
| SLM on Raspberry Pi、醫療 AI 願景 | 自傳 | 未寫出被拒會議名稱，只寫「首次投稿未獲接受」 |
| 刻意 **不** 放 | — | 電話、地址、原始 PDF、「報考台大博士班」等申請文件語境 |
| `info/myblog.md` | — | 目前為空檔，未使用 |

## 4. QA — 待確認問題（請直接在「回答」欄填寫）

| # | 問題 | 目前假設 / 預設 | 回答 | 狀態 |
|---|---|---|---|---|
| Q1 | 你的長庚大學 **學號** 是？（About 區段必填，zip 檔名也需要） | 網站顯示 `TBD` | | ❓ 必答 |
| Q2 | 目前就讀的 **系所 / 學位**？（顯示在學歷時間軸最上方與學號旁） | 留空 → 自動隱藏 | | ❓ |
| Q3 | GitHub **帳號與 repo 名稱**？ | 建議 repo 名 `hw1-portfolio`、Public（免費方案的 Pages 需要 public repo；info/ 已排除不會外流） | | ❓ 必答 |
| Q4 | 英文履歷寫中華電信研究院 **2001–Present**，中文履歷寫 **2001–2004 分公司 + 2004–至今研究院**，以哪個為準？ | 採中文版（兩段） | | ❓ |
| Q5 | 要放 GitHub / LinkedIn 個人頁連結嗎？ | 不放（config 中留空即隱藏） | | ❓ |
| Q6 | 履歷上的 Email 是 `iamkylee@email.com`，看起來是筆誤；網站用 `iamkylee@gmail.com` 可以嗎？ | 用 gmail | | ❓ |
| Q7 | Reflection 是 AI 依本次過程寫的初稿；作業評分重視 human judgment，請用自己的話改寫/補充後再轉 PDF。 | 草稿 PDF 已產出，可先暫用 | | ❓ |
| Q8 | 架構圖中的三個 Specialist Agent（Inventory / Provisioning / Verification）是示意命名，是否改成論文中的實際 agent 名稱？ | 圖說標示 "illustrative" | | ❓ |
| Q9 | 是否放個人照片取代 SVG 字標頭像？ | 不放照片（隱私） | | ❓ |

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
- [ ] 學號已填（Q1）
- [x] 桌機 1280px / 手機 390px 無水平捲動（Playwright 截圖驗證）
- [x] 視覺元素 ≥ 1（頭像、架構圖、時間軸）
- [x] 連結檢查：站內錨點與外部連結皆有效（`python3 scripts/check_links.py`）
- [ ] GitHub Pages 公開網址可開啟（Q3 後）
- [x] info/ 不在 git、不在網站、不在 zip
- [ ] Reflection 已由本人修訂並輸出 PDF（Q7）
- [ ] `hw1_<學號>.zip` 已產生並上傳
