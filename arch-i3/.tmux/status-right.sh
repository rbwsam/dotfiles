#!/usr/bin/env bash
path="$1"
base="${path##*/}"
branch=$(git -C "$path" symbolic-ref --short HEAD 2>/dev/null \
  || git -C "$path" rev-parse --short HEAD 2>/dev/null)
if [ -n "$branch" ]; then
  printf '[%s] %s' "$branch" "$base"
else
  printf '%s' "$base"
fi
