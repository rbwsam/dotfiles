#!/usr/bin/env python3
"""Report Claude subscription usage against elapsed window time."""
import json
import os
import urllib.error
import urllib.request
from datetime import datetime, timedelta, timezone

URL = "https://api.anthropic.com/api/oauth/usage"
WINDOW = {"session": timedelta(hours=5), "weekly": timedelta(days=7)}
CELLS = 30


def bar(label, pct):
    filled = min(CELLS, max(0, round(pct / 100 * CELLS)))
    return f"  {label:<9}{'█' * filled}{'░' * (CELLS - filled)}  {pct:.0f}%"


try:
    creds = json.load(open(os.path.expanduser("~/.claude/.credentials.json")))
    token = creds["claudeAiOauth"]["accessToken"]
except (OSError, KeyError, json.JSONDecodeError):
    raise SystemExit("No Claude subscription credentials found. Run /login, then retry.")

request = urllib.request.Request(
    URL,
    headers={
        "Authorization": f"Bearer {token}",
        "anthropic-beta": "oauth-2025-04-20",
        "Content-Type": "application/json",
    },
)
try:
    with urllib.request.urlopen(request, timeout=10) as response:
        usage = json.load(response)
except urllib.error.HTTPError as err:
    hint = " Token may have expired; /login refreshes it." if err.code == 401 else ""
    raise SystemExit(f"Usage fetch failed: HTTP {err.code}.{hint}")
except (urllib.error.URLError, TimeoutError, json.JSONDecodeError) as err:
    raise SystemExit(f"Usage fetch failed: {err}")

now = datetime.now(timezone.utc)
first = True
for limit in usage["limits"]:
    span = WINDOW.get(limit["group"])
    if not (span and limit["resets_at"]):
        continue
    resets = datetime.fromisoformat(limit["resets_at"])
    elapsed = (now - (resets - span)) / span
    scope = (limit.get("scope") or {}).get("model", {}).get("display_name")
    name = f"{limit['kind']}{f' ({scope})' if scope else ''}"

    print(name if first else f"\n{name}")
    first = False
    print(bar("used", limit["percent"]))
    print(bar("elapsed", elapsed * 100))
    if elapsed >= 0.05:
        print(f"  on pace for ~{limit['percent'] / elapsed:.0f}% by reset")
    print(f"  resets {resets.astimezone():%a %b %d %-I:%M %p %Z}")

spend = usage.get("extra_usage") or {}
if spend.get("is_enabled"):
    print(f"\nextra usage: {spend.get('utilization')}% of monthly limit")
