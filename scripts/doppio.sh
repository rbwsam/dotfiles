#!/bin/sh
# Sets display sleep to 2 hours; pairs with decaf.sh.
set -eu
# DISPLAY falls back to :0 so this also works from a TTY or ssh session.
# dpms args: standby, suspend, off timeouts in seconds.
exec xset -display "${DISPLAY:-:0}" dpms 7200 7200 7200
