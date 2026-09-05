#!/bin/bash

# =================
# git-filters.sh
# =================

# cleans and strips personal user metadata
# 	- name
# 	- email
# before they are staged
if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	git config filter.strip-user.clean 'sed -E "s/(email *= *).*/\1/; s/(name *= *).*/\1/"';
fi
