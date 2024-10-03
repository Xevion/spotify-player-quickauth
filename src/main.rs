use std::{env, fs::File, process::exit};

use futures::StreamExt;
use librespot_core::config::DeviceType;
use librespot_discovery::Discovery;
use log::{info, warn};
use sha1::{Digest, Sha1};
use librespot_core::SessionConfig;
use std::io::Write;

#[tokio::main(flavor = "current_thread")]
async fn main() {   
    if env::var("RUST_LOG").is_err() {
        env::set_var("RUST_LOG", "info")
    }
    env_logger::builder().init();

    let credentials_file = match home::home_dir() {
        // ~/.cache/spotify_player/credentials.json
        Some(path) => path.join(".cache/spotify_player/credentials.json"),
        None => {
            warn!("Cannot determine home directory for credentials file.");
            exit(1);
        }
    };
    info!("Credentials file: {}", &credentials_file.display());

    // TODO: If credentials file exists, confirm overwrite
    if credentials_file.exists() {
        warn!("Credentials file already exists: {}", &credentials_file.display());
        exit(1);
    }

    // TODO: If spotifyd is running, ask if shutdown is desired
    
    let username = match env::consts::OS {
        "windows" => env::var("USERNAME"),
        _ => env::var("USER"),
    }.unwrap_or_else(|_| "unknown".to_string());

    let device_name = format!("spotify-quickauth-{}", username);
    let device_id = hex::encode(Sha1::digest(device_name.as_bytes()));
    let device_type = DeviceType::Computer;

    let mut server = Discovery::builder(device_id, SessionConfig::default().client_id)
        .name(device_name.clone())
        .device_type(device_type)
        .launch()
        .unwrap();

    println!("Open Spotify and select output device: {}", device_name);

    let mut written = false;
    while let Some(credentials) = server.next().await {
        let result = File::create(&credentials_file).and_then(|mut file| {
            let data = serde_json::to_string(&credentials)?;
            write!(file, "{data}")
        });
        written = true;

        if let Err(e) = result {
            warn!("Cannot save credentials to cache: {}", e);
            exit(1);
        } else {
            println!("Credentials saved: {}", &credentials_file.display());
            exit(0);
        }
    }

    if !written {
        warn!("No credentials were written.");
        exit(1);
    }
}
