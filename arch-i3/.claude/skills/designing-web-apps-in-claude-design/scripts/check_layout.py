"""Report overlapping frames and title notes, per canvas page, in a Design canvas index.

Usage: uv run --no-project python check_layout.py ROOT/project/canvas.json
A title1 note reserves 223 px of height; frames keep 40 px clear of each other.
"""
import json, sys

c = json.load(open(sys.argv[1]))
rects = {}
for k, b in c["boards"].items():
    rects.setdefault(b.get("page"), []).append((k, b["x"], b["y"], b["x"] + b["w"], b["y"] + b["h"]))
for k, n in c.get("notes", {}).items():
    if n.get("kind") == "title1":
        rects.setdefault(n.get("page"), []).append(("note:" + k, n["x"], n["y"], n["x"] + n.get("maxW", 2000), n["y"] + 223))
bad = 0
for page, rs in rects.items():
    for i, a in enumerate(rs):
        for b in rs[i + 1:]:
            if a[1] < b[3] + 40 and b[1] < a[3] + 40 and a[2] < b[4] + 40 and b[2] < a[4] + 40:
                print(page, a[0], "x", b[0])
                bad += 1
print("overlaps:", bad)
