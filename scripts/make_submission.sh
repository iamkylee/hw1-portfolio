#!/usr/bin/env bash
# 產生繳交檔 hw1_<學號>.zip（HW.md §2：檔名必須完全符合；§3：四項交付物）。
# info/ 絕不打包（RQ-2）。
# 用法：bash scripts/make_submission.sh <學號> <網站URL> <repoURL>
set -euo pipefail
cd "$(dirname "$0")/.."

SID="${1:?用法: bash scripts/make_submission.sh <學號> <網站URL> <repoURL>}"
SITE_URL="${2:?缺網站 URL}"
REPO_URL="${3:?缺 repo URL}"
NAME="hw1_${SID}"

# ---------- 事前檢查 ----------
fail(){ echo "❌ $*"; exit 1; }
grep -q "studentId: \"$SID\"" site/assets/config.js || fail "site/assets/config.js 的 studentId 不是 $SID"
[ -f deliverables/Reflection.pdf ]            || fail "缺 deliverables/Reflection.pdf（請在 Word 另存為 PDF）"
[ -f deliverables/AI_Interaction_Log.md ]     || fail "缺 deliverables/AI_Interaction_Log.md"
[ -z "$(git ls-files info 2>/dev/null)" ]     || fail "info/ 被 git 追蹤，請先 git rm -r --cached info"
WORDS=$(pdftotext deliverables/Reflection.pdf - 2>/dev/null | wc -w | tr -d ' ')
echo "ℹ️  Reflection.pdf 約 ${WORDS} words（要求 300–500，含標題與抬頭）"
{ [ "$WORDS" -ge 300 ] && [ "$WORDS" -le 500 ]; } || echo "⚠️  字數不在 300–500，請確認"
grep -q "Student ID ${SID}" <(pdftotext deliverables/Reflection.pdf - 2>/dev/null) || echo "⚠️  Reflection.pdf 內找不到 'Student ID ${SID}'"

# ---------- 組裝目錄 ----------
rm -rf "dist/${NAME}" "dist/${NAME}.zip"
OUT="dist/${NAME}"; SRC="$OUT/2_Source_Code"
mkdir -p "$SRC"

cat > "$OUT/1_Live_Website_URL.txt" <<TXT
Live Website URL (GitHub Pages):
${SITE_URL}
TXT

cat > "$SRC/REPO_LINK.txt" <<TXT
Source code repository (public):
${REPO_URL}

This folder also contains a copy of the code (the website is in site/).
TXT
cp -R site .github scripts README.md SPEC.md HISTORY.md RQ.md HW.md .gitignore "$SRC/"

cp deliverables/AI_Interaction_Log.md "$OUT/3_AI_Interaction_Log.md"
cp deliverables/Reflection.pdf        "$OUT/4_Reflection.pdf"

cat > "$OUT/README.md" <<MD
# HW1 Submission — 李冠穎 Kuan-Yin Lee (${SID})

| # | Deliverable | Where |
|---|---|---|
| 1 | Live Website URL | [1_Live_Website_URL.txt](1_Live_Website_URL.txt) — ${SITE_URL} |
| 2 | Source Code | [2_Source_Code/](2_Source_Code/) — repo: ${REPO_URL} |
| 3 | AI Interaction Log (5 key prompts) | [3_AI_Interaction_Log.md](3_AI_Interaction_Log.md) |
| 4 | Reflection (PDF, 300–500 words) | [4_Reflection.pdf](4_Reflection.pdf) |

Full change history with questions and answers: \`2_Source_Code/HISTORY.md\`.
MD

# ---------- 安全檢查：不得含 info/ 或個人原始檔 ----------
find "$OUT" \( -path '*/info/*' -o -name '*.pptx' -o -name '大頭貼*' -o -name '*履歷*' -o -name '~$*' -o -name '.DS_Store' \) -print -delete
find "$OUT" -iname '*.pdf' ! -name '4_Reflection.pdf' | grep . && fail "發現多餘 PDF（可能是 info/ 的履歷）" || true

# ---------- 壓縮 ----------
(cd dist && zip -qrX "${NAME}.zip" "${NAME}")
echo; echo "✅ dist/${NAME}.zip  ($(du -h "dist/${NAME}.zip" | cut -f1))"
unzip -Z1 "dist/${NAME}.zip" | grep -v '/$' | sed 's/^/   /'
