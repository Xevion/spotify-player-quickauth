# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased v0.2.0]

- Adjusted `github-linguist` statistics, ignoring `.hooks`
- Widened `paths-ignore` for `build` and `test` workflows.
- Removed `paths-ignore` for `build` workflow on `push` trigger.

## v0.1.6

- Began tracking changes in the `CHANGELOG.md` file.
- [breaking] Lowered MSRV to 1.74 to match `librespot`'s `0.5.0-dev` branch.
- Fixed `pre-commit` hook to properly process the `CARGO_README.md` file.
- Added testing workflow to the repository, targeting only major x64 platforms.
- New testing badge in README