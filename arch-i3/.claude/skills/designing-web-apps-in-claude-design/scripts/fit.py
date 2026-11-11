"""Fit frame heights in project/canvas.json to rendered content, pushing frames below in the same column down by the same amount.
Usage: uv run --no-project python fit.py ROOT shot.txt [Board.dc.html ...]  (shot.py's printed lines; only the named boards when given)
Only renders at the board's own width count. A board grows when clipped and shrinks when slack is over 40; its new h is content + 20, rounded up to 10."""
import json, math, pathlib, re, sys

LINE = re.compile(r"^(\S+\.dc\.html) @(\d+): frame h=(\d+) content=(\d+)", re.M)


def main(root, out, only):
    C = pathlib.Path(root) / "project" / "canvas.json"
    c = json.loads(C.read_text())
    B = c["boards"]
    for name, w, h, content in LINE.findall(pathlib.Path(out).read_text()):
        w, h, content = int(w), int(h), int(content)
        if (only and name not in only) or name not in B or w != B[name]["w"] or (content <= h and h - content <= 40):
            continue
        b = B[name]
        new = math.ceil((content + 20) / 10) * 10
        delta, bottom = new - b["h"], b["y"] + b["h"]
        for k, o in B.items():
            if k != name and o.get("page") == b.get("page") and o["y"] >= bottom and o["x"] < b["x"] + b["w"] and b["x"] < o["x"] + o["w"]:
                o["y"] += delta
        for n in c.get("notes", {}).values():
            if n.get("page") == b.get("page") and n["y"] >= bottom and n["x"] < b["x"] + b["w"]:
                n["y"] += delta
        print(f"{name}: h {b['h']} -> {new}")
        b["h"] = new
    C.write_text(json.dumps(c, indent=1, ensure_ascii=False))


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], set(sys.argv[3:]))
