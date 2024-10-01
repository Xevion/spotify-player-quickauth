# spotify-player-quickauth

A simple CLI-based application for creating a `credentials.json` file, used by the [spotify-player][spotify-player] library, for authenticating with the Spotify API.

## Usage

You can install this applicaiton, but most people will just need it once.

```bash
curl -sSL https://raw.githubusercontent.com/Xevion/spotify-player-quickauth/refs/heads/master/run.sh | sh
```

## Building from Source

Don't want to run my funky shell script? No problem! You can build the application from source easily.

```bash
git clone https://github.com/Xevion/spotify-player-quickauth.git
cd spotify-player-quickauth
cargo build --release
./target/release/spotify-player-quickauth
```

[spotify-player]: https://github.com/aome510/spotify-player