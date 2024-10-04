# spotify-quickauth

A simple CLI-based application for creating a `credentials.json` file, used by the [spotify-player][spotify-player] library, for authenticating with the Spotify API.

## Usage

You can install this application, but most people will just need it once. The following commands will run the application without installing it.

For Linux and macOS, you can paste this command into your terminal:

```bash
curl -sSL https://xevion.github.io/spotify-quickauth/run.sh | sh -s --
```

For Windows, you can paste this command into PowerShell:

```powershell
iex (irm "https://xevion.github.io/spotify-quickauth/run.ps1")
```

## Building from Source

Don't want to run my funky shell script? No problem! You can build the application from source easily.

- You'll need `cargo`, the Rust build system and package manager. It's included with the Rust toolchain, which you can install from [rustup.rs][rustup]
- This is an early project, so the minimum supported version of Rust is not known. I'm developing on 1.81.0 though.

```bash
git clone https://github.com/Xevion/spotify-quickauth.git
cd spotify-quickauth
cargo build --release
./target/release/spotify-quickauth
```

[spotify-player]: https://github.com/aome510/spotify-player
[rustup]: https://rustup.rs
[git]: https://git-scm.com