#!/bin/sh

# Remove markdown extension lines for Cargo publishing
sed '/^>\[!/d' README.md > CARGO_README.md

# Add the modified file to the commit
git add CARGO_README.md