use std::env;
use std::process::Command;
use std::io;

fn main() {
    let os = env::consts::OS;
    let arch = env::consts::ARCH;
    let username = env::var("USER").unwrap_or_else(|_| "unknown".to_string());
    let hostname = Command::new("hostname")
        .output()
        .map(|output| String::from_utf8_lossy(&output.stdout).trim().to_string())
        .unwrap_or_else(|_| "unknown".to_string());
    let execution_path = env::current_exe()
        .map(|path| path.display().to_string())
        .unwrap_or_else(|_| "unknown".to_string());
    let working_directory = env::current_dir()
        .map(|path| path.display().to_string())
        .unwrap_or_else(|_| "unknown".to_string());

    println!(
        "{}@{} ({}/{}) [{}] [{}]",
        username, hostname, os, arch, working_directory, execution_path
    );
}
