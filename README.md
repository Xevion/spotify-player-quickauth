# spotify-quickauth

[![Build Status](https://github.com/Xevion/spotify-quickauth/workflows/Build/badge.svg)](https://github.com/Xevion/spotify-quickauth/actions)
[![Crates.io](https://img.shields.io/crates/v/spotify-quickauth.svg)](https://crates.io/crates/spotify-quickauth)


A simple CLI-based application for creating a `credentials.json` file, used by `librespot` derived applications, such as [spotify-player][spotify-player], [spotifyd][spotifyd], and [raspotify][raspotify].

- One command, no compilation, all platforms (Windows, Linux, MacOS), ARM included
- Automatically places configuration files
- No dependencies, no installation, no fuss

>[!WARNING]
>This README is literally filled with lies. I'm not joking, I've just typed up a bunch of features I plan to implement, and am planning them out now. A fair amount of it works, but most of the specific options aren't currently implemented. I'm working on it, I promise!

## Quickstart

You can run this application without installing anything by using the following commands.

```bash
curl -sSL https://xevion.github.io/spotify-quickauth/run.sh | sh -s --
```

The default invocation is likely fine for most users, it will try to understand the available paths for `credentials.json` to be written to, and allow you to select them.

>[!NOTE]
> Automatic detection is dependent on the related software being installed and/or relevant configuration files being present.

For **Windows**, you can paste this command into PowerShell:

```powershell
iex (irm "https://xevion.github.io/spotify-quickauth/run.ps1")
```

## Usage

This application is dead simple to use. Just run the command, and it'll tell you to connect to a fake 'device' in your Spotify interface.

>[!NOTE]
> You must be connected to the same network running `spotify-quickauth`, as the `zeroconf` technology does not work across networks nor proxies. 

Once you connect, the credentials file will be created, and you'll be prompted to select which location(s) to place it in.

## Installation

Installation is not necessary to use this application, but if you're having trouble, want to compile it yourself, or are using it frequently, you might want to install it.

>[!NOTE]
>The scripts above can be given the `-K` or `--keep` flag to keep the downloaded binary. This will prevent repeated API calls to GitHub if you're using the script frequently within a short period.


### Pre-built Binaries

Binaries are always available for download from the [releases page][releases], and they're the same ones used by the shell scripts above.

Currently, the following targets are available for download:
- x64 Linux (MUSL) `x86_64-unknown-linux-musl`
- ARM64 Linux (MUSL) `aarch64-unknown-linux-musl`
- ARMv7 Linux `armv7-unknown-linux-musleabihf`
- Intel MacOS `x86_64-apple-darwin`
- Apple Silicon MacOS `aarch64-apple-darwin`
- x64 Windows `x86_64-pc-windows-msvc`
- ARM64 Windows `aarch64-pc-windows-msvc`

If you'd like to use the shell script above to install the binary, you can use the `-S` or `--stop` flag to prevent the script from running the binary after downloading it. It implicitly applies the `--keep` flag too.

```bash
curl -sSL https://xevion.github.io/spotify-quickauth/run.sh | sh -s -- -S
mv spotify-quickauth /usr/local/bin
```

You can also install the binary with [`cargo binstall`][binstall] or [`cargo quickinstall`][quickinstall], assuming you have them installed.

### Building from Source

Don't want to run my funky shell script? No problem! You can build the application from source easily.

- You'll need `cargo`, the Rust build system and package manager. It's included with the Rust toolchain, which you can install from [rustup.rs][rustup]
- This is an early project, so the minimum supported version of Rust is not known. I'm developing on 1.81.0 though.

```bash
git clone https://github.com/Xevion/spotify-quickauth.git
cd spotify-quickauth
cargo install --path .
spotify-quickauth --help
```

[spotify-player]: https://github.com/aome510/spotify-player
[spotifyd]: https://github.com/Spotifyd/spotifyd
[raspotify]: https://github.com/dtcooper/raspotify
[rustup]: https://rustup.rs
[git]: https://git-scm.com
[binstall]: https://github.com/cargo-bins/cargo-binstall
[quickinstall]: https://github.com/cargo-bins/cargo-quickinstall