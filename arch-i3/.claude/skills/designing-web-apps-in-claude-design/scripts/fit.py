"""Fit frame heights in ROOT/project/canvas.json to rendered content, then move rows down until nothing overlaps.
Usage: python fit.py ROOT shot-output.txt [Board.dc.html ...]  (shot.py's printed lines; only the named boards when given)
A named board, or any board when none are named, grows when clipped and shrinks when slack is over 40; its new h is
content + 20, rounded up to 10. A frame that then reaches into the frame or row title below moves that row and
everything under it on its page down: frames keep 40 px apart, a row title keeps 80 px under the frame above it."""
import json, math, pathlib, re, sys

LINE = re.compile(r"^(\S+\.dc\.html) @\d+: frame h=(\d+) content=(\d+)", re.M)


def clear(c):
    B, N = c["boards"], c.get("notes", {})
    titles = {k: n for k, n in N.items() if n.get("kind") == "title1"}
    while True:
        moved = False
        for page in {b.get("page") for b in B.values()}:
            items = [(b["y"], b["x"], b["x"] + b["w"], b["h"], 40) for b in B.values() if b.get("page") == page]
            items += [(n["y"], n["x"], n["x"] + n.get("maxW", 2000), 223, 80) for n in titles.values() if n.get("page") == page]
            for y, x0, x1, _, gap in sorted(items):
                need = max((a[0] + a[3] + gap - y for a in items if a[0] < y and a[1] < x1 and x0 < a[2]), default=0)
                if need > 0:
                    for b in B.values():
                        if b.get("page") == page and b["y"] >= y:
                            b["y"] += need
                    for n in N.values():
                        if n.get("page") == page and n["y"] >= y:
                            n["y"] += need
                    moved = True
                    break
            if moved:
                break
        if not moved:
            return


def main(root, out, only):
    path = pathlib.Path(root) / "project" / "canvas.json"
    c = json.loads(path.read_text())
    B = c["boards"]
    for name, h, content in LINE.findall(pathlib.Path(out).read_text()):
        h, content = int(h), int(content)
        if (only and name not in only) or name not in B or (content <= h and h - content <= 40):
            continue
        new = math.ceil((content + 20) / 10) * 10
        print(f"{name}: h {B[name]['h']} -> {new}")
        B[name]["h"] = new
    clear(c)
    path.write_text(json.dumps(c, indent=1, ensure_ascii=False))


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], set(sys.argv[3:]))
