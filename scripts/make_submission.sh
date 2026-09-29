#!/usr/bin/env bash
# 產生繳交檔 hw1_<學號>.zip（HW.md §2 檔名規則）。info/ 絕不打包（RQ-2）。
# 用法：bash scripts/make_submission.sh <學號> [網站URL] [repo URL]
set -euo pipefail
cd "$(dirname "$0")/.."
SID="${1:?用法: bash scripts/make_submission.sh <學號> [網站URL] [repoURL]}"
SITE_URL="${2:-https://<username>.github.io/<repo>/}"
REPO_URL="${3:-https://github.com/<username>/<repo>}"

grep -q "studentId: \"$SID\"" site/assets/config.js || echo "⚠️  site/assets/config.js 的 studentId 不是 $SID，請確認網站上的學號"
[ -f deliverables/Reflection.pdf ] || { echo "❌ 缺 deliverables/Reflection.pdf"; exit 1; }

OUT="dist/hw1_${SID}"; rm -rf "$OUT"; mkdir -p "$OUT"
cat > "$OUT/00_LINKS.md" <<MD
# HW1 Submission — Student ID ${SID}

1. **Live Website URL:** ${SITE_URL}
2. **Source Code:** ${REPO_URL}  （另附 source/ 目錄）
3. **AI Interaction Log:** AI_Interaction_Log.md
4. **Reflection (PDF):** Reflection.pdf
MD
cp deliverables/AI_Interaction_Log.md deliverables/Reflection.pdf "$OUT/"
mkdir -p "$OUT/source"
cp -r site .github README.md SPEC.md HISTORY.md "$OUT/source/"
find "$OUT" -path '*info*' -name '*.pdf' -print -delete || true
(cd dist && rm -f "hw1_${SID}.zip" && zip -rq "hw1_${SID}.zip" "hw1_${SID}" -x '*.DS_Store')
echo "✅ dist/hw1_${SID}.zip"; unzip -l "dist/hw1_${SID}.zip" | tail -n +1
