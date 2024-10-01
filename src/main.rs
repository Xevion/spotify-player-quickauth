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


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_os_arch() {
        let os = env::consts::OS;
        let arch = env::consts::ARCH;
        
        // Make sure that OS and ARCH are not empty
        assert!(!os.is_empty());
        assert!(!arch.is_empty());
    }

    #[test]
    fn test_username() {
        let username = env::var("USER").unwrap_or_else(|_| "unknown".to_string());
        
        // In CI environments, USER might not be set, so allow "unknown"
        assert!(!username.is_empty());
    }

    #[test]
    fn test_hostname() {
        let hostname = Command::new("hostname")
            .output()
            .map(|output| String::from_utf8_lossy(&output.stdout).trim().to_string())
            .unwrap_or_else(|_| "unknown".to_string());
        
        // Since hostname might vary, just ensure it's not empty
        assert!(!hostname.is_empty());
    }

    #[test]
    fn test_execution_path() {
        let execution_path = env::current_exe()
            .map(|path| path.display().to_string())
            .unwrap_or_else(|_| "unknown".to_string());

        // Ensure execution path is not "unknown" when it's expected to resolve
        assert!(execution_path != "unknown");
    }

    #[test]
    fn test_working_directory() {
        let working_directory = env::current_dir()
            .map(|path| path.display().to_string())
            .unwrap_or_else(|_| "unknown".to_string());
        
        // Ensure the working directory is a valid path
        assert!(working_directory != "unknown");
    }
}