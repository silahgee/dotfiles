#!/usr/bin/env bash

# ================================================================
# git-filters.sh
# Script to configure git filters to strip personal metadata
# ================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v git >/dev/null 2>&1 && REPO_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null)"; then
	# cleans and strips personal user metadata (name, email) before staging
	git -C "$REPO_ROOT" config filter.strip-user.clean 'sed -E "s/(email *= *).*/\1/; s/(name *= *).*/\1/"'
	git -C "$REPO_ROOT" config filter.strip-user.smudge 'cat'

	# refresh index so existing tracked files respect the filter immediately
	git -C "$REPO_ROOT" add --renormalize .
fi
