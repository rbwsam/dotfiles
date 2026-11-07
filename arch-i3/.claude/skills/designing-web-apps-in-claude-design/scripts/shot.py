"""Render Design canvas boards locally and report each board's content height against its frame.

Usage: uv run --no-project --with playwright python shot.py ROOT [--width N] Board.dc.html ...

ROOT holds project/ (canvas.json and the .dc.html boards, at their canvas paths)
and runtime/dc-runtime.js (the canvas's artifact-type/dc-runtime.js, served as support.js).
--width renders every named board at N px instead of its canvas width: the narrowest-width check.
PNGs land in ROOT/render-out/.
"""
import functools, http.server, json, pathlib, shutil, sys, threading
from playwright.sync_api import sync_playwright


def main(argv):
    root = pathlib.Path(argv[0]).resolve()
    width = None
    names = argv[1:]
    if names[:1] == ["--width"]:
        width, names = int(names[1]), names[2:]
    project, site, out = root / "project", root / "render-out" / "site", root / "render-out"
    site.mkdir(parents=True, exist_ok=True)
    for f in project.glob("*.dc.html"):
        shutil.copy(f, site / f.name)
    shutil.copy(root / "runtime" / "dc-runtime.js", site / "support.js")
    boards = json.loads((project / "canvas.json").read_text())["boards"]

    class Quiet(http.server.SimpleHTTPRequestHandler):
        def log_message(self, *a):
            pass

    srv = http.server.ThreadingHTTPServer(("127.0.0.1", 0), functools.partial(Quiet, directory=str(site)))
    threading.Thread(target=srv.serve_forever, daemon=True).start()
    base = f"http://127.0.0.1:{srv.server_address[1]}/"
    with sync_playwright() as p:
        browser = p.chromium.launch()
        for name in names:
            b = boards.get(name, {"w": 1280, "h": 900})
            w = width or b["w"]
            page = browser.new_page(viewport={"width": w, "height": b["h"]}, device_scale_factor=1)
            errors = []
            page.on("console", lambda m: errors.append(m.text) if m.type == "error" else None)
            page.on("pageerror", lambda e: errors.append(str(e)))
            page.goto(base + name, wait_until="networkidle")
            page.wait_for_timeout(800)
            content = page.evaluate("""() => { const m = document.querySelector('main') || document.body;
                const pad = parseFloat(getComputedStyle(m).paddingBottom) || 0; let h = 0;
                for (const el of m.children) h = Math.max(h, el.getBoundingClientRect().bottom + window.scrollY);
                return Math.ceil(h + pad); }""")
            wide = page.evaluate("document.documentElement.scrollWidth")
            png = out / (name.replace(".dc.html", "") + (f"@{w}" if width else "") + ".png")
            page.screenshot(path=str(png), full_page=True)
            flags = ["CLIPPED" if content > b["h"] else f"slack {b['h'] - content}"]
            if wide > w:
                flags.append(f"SCROLLS SIDEWAYS ({wide} > {w})")
            print(f"{name} @{w}: frame h={b['h']} content={content} {' '.join(flags)} -> {png.name}" + (f"  ERRORS: {errors[:3]}" if errors else ""))
            page.close()
        browser.close()
    srv.shutdown()


if __name__ == "__main__":
    main(sys.argv[1:])
