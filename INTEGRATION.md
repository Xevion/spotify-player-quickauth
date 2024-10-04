# integration

A small document explaining how to test this project on any given system.

1. Install `spotify-player` using one of these steps
    - Package Managers
        - MacOS: `brew install spotify_player`
        - Windows (scoop): `scoop install spotify-player`
        - Linux
            - Ubuntu/Debian: `sudo apt install libssl-dev libasound2-dev libdbus-1-dev`
            - Homebrew: `brew install openssl alsa-lib dbus`
            - AUR: `yay -S spotify-player`
            - Void Linux:
            - FreeBSD:
            - NetBSD:
    - Build from Source: `cargo install spotify_player --locked`