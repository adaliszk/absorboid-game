#!/usr/bin/env sh

GDSCRIPT=$(
	cat <<-EOF
		extends Node

		const Build = ${GITHUB_RUN_NUMBER:-null}
		const Branch = "$(git rev-parse --abbrev-ref HEAD)"
		const Commit = "$(git rev-parse --short HEAD)"
		const Tag = "$(git describe --tags --exact-match 2>/dev/null)"
	EOF
)

echo "${GDSCRIPT}" > "git_info.gd"
