#!/usr/bin/env python3
"""deliverables/Reflection.md → deliverables/Reflection.pdf（需要 reportlab）。
修改 Reflection.md 後重新執行：python3 scripts/build_reflection_pdf.py
"""
import re, pathlib
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import cm
from reportlab.lib.enums import TA_JUSTIFY
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.cidfonts import UnicodeCIDFont
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer

D = pathlib.Path(__file__).resolve().parent.parent / "deliverables"
src = (D / "Reflection.md").read_text(encoding="utf-8")
# 優先嵌入系統 TrueType 中文字型（任何 PDF 閱讀器都能顯示）；找不到才用 reportlab 內建 CID 字型
CJK = "CJK"
for f in ["/System/Library/Fonts/Supplemental/Arial Unicode.ttf", "/Library/Fonts/Arial Unicode.ttf",
          "/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc", "C:/Windows/Fonts/msjh.ttc"]:
    try:
        pdfmetrics.registerFont(TTFont(CJK, f, subfontIndex=0) if f.endswith(".ttc") else TTFont(CJK, f)); break
    except Exception:
        continue
else:
    CJK = "MSung-Light"; pdfmetrics.registerFont(UnicodeCIDFont(CJK))

def inline(s):
    s = s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    s = re.sub(r"\*\*(.+?)\*\*", r"<b>\1</b>", s)
    s = re.sub(r"\*(.+?)\*", r"<i>\1</i>", s)
    s = re.sub(r"`(.+?)`", r"<font face='Courier'>\1</font>", s)
    return re.sub(r"([㐀-鿿＀-￯]+)", f"<font face='{CJK}'>\\1</font>", s)

title = ParagraphStyle("t", fontName="Helvetica-Bold", fontSize=16, leading=20, spaceAfter=6)
meta  = ParagraphStyle("m", fontName="Helvetica", fontSize=10, leading=14, textColor="#475569", spaceAfter=14)
body  = ParagraphStyle("b", fontName="Times-Roman", fontSize=11.5, leading=16.5, alignment=TA_JUSTIFY, spaceAfter=10)

story = []
for block in [b.strip() for b in src.split("\n\n") if b.strip()]:
    if block.startswith("> "):          # 草稿提示不輸出到 PDF
        continue
    if block.startswith("# "):
        story.append(Paragraph(inline(block[2:]), title))
    elif block.startswith("**") and "·" in block.splitlines()[0] and len(block) < 120:
        story.append(Paragraph(inline(block.strip("*")), meta))
    else:
        story.append(Paragraph(inline(" ".join(block.splitlines())), body))

words = len(re.findall(r"[A-Za-z0-9'’-]+", src.split("**Process.**", 1)[-1]))
SimpleDocTemplate(str(D / "Reflection.pdf"), pagesize=A4, leftMargin=2.4*cm, rightMargin=2.4*cm,
                  topMargin=2.2*cm, bottomMargin=2.2*cm, title="HW1 Reflection - Kuan-Yin Lee").build(story)
print(f"✅ deliverables/Reflection.pdf  (body ≈ {words} words; required 300–500)")
