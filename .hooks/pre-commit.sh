#!/bin/sh

# Remove all lines starting with >[! from CARGO_README.md
sed -i '/^>\[!/d' CARGO_README.md

# Add the modified file to the commit
git add CARGO_README.md