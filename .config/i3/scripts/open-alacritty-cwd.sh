#!/bin/bash
set -e
trap 'echo "Error on line $LINENO" >&2' ERR

FOCUSED_PID=$(xdotool getwindowfocus getwindowpid)
CHILD_PID=$(pgrep -P "$FOCUSED_PID" | tail -1)
GRANDCHILD_PID=$(pgrep -P "$CHILD_PID" | tail -1)
TARGET_PID="${GRANDCHILD_PID:-$CHILD_PID}"
CWD=$(readlink /proc/$TARGET_PID/cwd)

exec alacritty --working-directory "$CWD"

