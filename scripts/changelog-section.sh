#!/usr/bin/env bash
# Print the CHANGELOG.md section for one version (without its heading).
# Exits non-zero if the version has no entry.
set -euo pipefail
version="${1:?usage: changelog-section.sh <version>}"
section="$(awk -v v="$version" '
  /^## \[/ { if (found) exit; if (index($0, "## [" v "]") == 1) { found = 1; next } }
  found { print }
' CHANGELOG.md)"
if [ -z "$(echo "$section" | tr -d '[:space:]')" ]; then
  echo "CHANGELOG.md has no entry for $version" >&2
  exit 1
fi
printf '%s\n' "$section"
