#!/usr/bin/env bash

GDSCRIPT=$(
	cat <<-EOF
		const HASH = "#$(git rev-parse --short HEAD)"
		const BRANCH = "$(git rev-parse --abbrev-ref HEAD)"
		const TAG = "$(git describe --tags --exact-match 2>/dev/null)"
	EOF
)

echo "${GDSCRIPT}" > "git_version.gd"
