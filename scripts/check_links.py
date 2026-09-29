#!/usr/bin/env python3
"""檢查 site/index.html 的站內錨點、本地資源與外部連結（HW-2：no broken links）。
用法：python3 scripts/check_links.py [--offline]
"""
import sys, pathlib, re, urllib.request
from html.parser import HTMLParser

ROOT = pathlib.Path(__file__).resolve().parent.parent / "site"
html = (ROOT / "index.html").read_text(encoding="utf-8")

class P(HTMLParser):
    def __init__(s): super().__init__(); s.ids=set(); s.refs=[]
    def handle_starttag(s, tag, a):
        a = dict(a)
        if "id" in a: s.ids.add(a["id"])
        for k in ("href", "src"):
            if a.get(k): s.refs.append(a[k])
p = P(); p.feed(html)

bad = []
for r in p.refs:
    if r.startswith("#"):
        if len(r) > 1 and r[1:] not in p.ids: bad.append(("anchor", r))
    elif r.startswith("mailto:"):
        if not re.match(r"mailto:[^@\s]+@[^@\s]+\.\w+$", r): bad.append(("mailto", r))
    elif r.startswith("http"):
        if "--offline" in sys.argv or "fonts.g" in r: continue
        try:
            req = urllib.request.Request(r, method="GET", headers={"User-Agent": "Mozilla/5.0 link-check"})
            code = urllib.request.urlopen(req, timeout=15).status
            if code >= 400: bad.append((code, r))
        except Exception as e:
            code = getattr(e, "code", None)
            # IEEE Xplore 常對機器人回 418/403，但瀏覽器可正常開啟 → 視為警告
            (print(f"WARN {code} {r}") if code in (403, 418, 429) else bad.append((str(e)[:60], r)))
    elif not (ROOT / r).exists():
        bad.append(("missing", r))

print(f"checked {len(p.refs)} refs, {len(p.ids)} ids")
for b in bad: print("BROKEN", *b)
sys.exit(1 if bad else 0)
