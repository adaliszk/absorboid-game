#!/usr/bin/env bash

if [[ -f ".git/PROJECT_INITIALIZED" ]]; then
	echo "This repository has already been initialized, skipping..."
	exit 0
fi

SCRIPT="git describe --tags --abbrev=0 2>/dev/null || git rev-parse --short HEAD > git_version.txt"
echo "${SCRIPT}" >> ".git/hooks/update-git-version.sh"

echo ".git/hooks/update-git-version.sh" >> ".git/hooks/post-checkout"
echo ".git/hooks/update-git-version.sh" >> ".git/hooks/post-commit"

mkdir -p build/web
mkdir -p build/windows
mkdir -p build/mac

.git/hooks/update-git-version.sh
touch .git/PROJECT_INITIALIZED
