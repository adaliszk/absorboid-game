#!/usr/bin/env bash

if [[ -f ".git/PROJECT_INITIALIZED" ]]; then
	echo "This repository has already been initialized, skipping..."
	exit 0
fi

echo "setup-git-version.sh" >> ".git/hooks/post-checkout"
echo "setup-git-version.sh" >> ".git/hooks/post-commit"

mkdir -p build/web
mkdir -p build/windows
mkdir -p build/mac

touch .git/PROJECT_INITIALIZED
setup-git-version.sh
