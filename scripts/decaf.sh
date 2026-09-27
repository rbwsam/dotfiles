#!/bin/sh
# Sets display sleep to 10 minutes; pairs with doppio.sh.
set -eu
# DISPLAY falls back to :0 so this also works from a TTY or ssh session.
# dpms args: standby, suspend, off timeouts in seconds.
exec xset -display "${DISPLAY:-:0}" dpms 600 600 600
