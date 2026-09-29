# HISTORY — 問答與變更紀錄

> 對應 RQ-3：本專案所有「問答（Q&A）」與「變更（Change）」依版本記錄於此。
> 版本採 SemVer：`MAJOR.MINOR.PATCH`（內容/功能新增 → MINOR；修正 → PATCH）。
> 每個版本對應一個 git commit；commit 訊息 body 會寫 `Refs: HISTORY.md vX.Y.Z`，可雙向查找。
> 待回覆的問題集中在 `SPEC.md §4 QA`。

| 版本 | 日期 | 摘要 | Commit |
|---|---|---|---|
| v0.1.1 | 2026-09-29 | 新增 TODO.md 繳交前待辦；說明 repo 公開範圍 | tag `v0.1.1` |
| v0.1.0 | 2026-09-29 | 初版：網站、GitHub Pages 部署、SPEC/HISTORY、繳交文件草稿 | `0671cad`（tag `v0.1.0`） |

---

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
