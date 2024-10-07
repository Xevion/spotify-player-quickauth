#!/bin/sh

# TODO: Only run when README.md is modified
# TODO: Support partial staging, where the 'Staged' version is copied to CARGO_README.md, and then `sed` is ran.

# Remove markdown extension lines for Cargo publishing
sed '/^>\[!/d' README.md > CARGO_README.md

# Add the modified file to the commit
git add CARGO_README.md