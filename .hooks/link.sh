#!/bin/bash
hooks=(
    "pre-commit"
    "pre-push"
)

for hook in "${hooks[@]}"; do
    chmod +x .hooks/$hook.sh
    ln -s -f ../../.hooks/$hook.sh .git/hooks/$hook
done