#!/usr/bin/env bash
# Claude Code WorktreeCreate hook: relocate worktrees out of the repo, mirroring
# the ~/code/<org>/<repo> layout at ~/worktrees/<org>/<repo>/<name>. The hook OWNS
# creation (Claude does not run `git worktree add`); only the final path may go to
# stdout. Native .worktreeinclude is skipped when a hook exists, so we copy here.
set -euo pipefail

input=$(cat)
get() { printf '%s' "$input" | jq -r "$1 // empty"; }

name=$(get '.name')
src=$(get '.cwd'); [ -n "$src" ] || src=$PWD
[ -n "$name" ] || { echo "worktree-create: no worktree name in payload" >&2; exit 1; }

repo_root=$(git -C "$src" rev-parse --show-toplevel 2>/dev/null) \
  || { echo "worktree-create: $src is not a git repo" >&2; exit 1; }

# Mirror the canonical <org>/<repo> from the git remote (checkout-independent).
# Fall back to the ~/code/<org>/<repo> layout, then the bare repo name.
rel=""
remote=$(git -C "$repo_root" remote get-url origin 2>/dev/null || true)
if [ -n "$remote" ]; then
  r="${remote%.git}"   # drop .git suffix
  r="${r#*://}"        # drop scheme://
  r="${r#*@}"          # drop user@ (scp form)
  r="${r/://}"         # host:org -> host/org (scp form)
  rel="${r#*/}"        # drop host -> org/repo
fi
if [ -z "$rel" ]; then
  code_root="$HOME/code"
  case "$repo_root/" in
    "$code_root"/*) rel="${repo_root#"$code_root"/}" ;;
    *) rel="$(basename "$repo_root")" ;;
  esac
fi
dest="$HOME/worktrees/$rel/$name"
mkdir -p "$(dirname "$dest")"

git -C "$repo_root" worktree add -b "worktree-$name" "$dest" >&2

# Copy gitignored files named in .worktreeinclude (gitignore-style globs).
inc="$repo_root/.worktreeinclude"
if [ -f "$inc" ]; then
  while IFS= read -r pat || [ -n "$pat" ]; do
    case "$pat" in ''|\#*) continue ;; esac
    ( cd "$repo_root" && shopt -s nullglob globstar dotglob
      for f in $pat; do
        [ -e "$f" ] || continue
        mkdir -p "$dest/$(dirname "$f")"
        cp -a "$f" "$dest/$f"
      done )
  done < "$inc"
fi

printf '%s\n' "$dest"
