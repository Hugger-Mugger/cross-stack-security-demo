use sha2::{Sha256, Digest};

pub fn hash_message(msg: &str) -> String {
    let mut hasher = Sha256::new();
    hasher.update(msg.as_bytes());
    format!("{:x}", hasher.finalize())
}

fn main() {
    println!("Security Alert: suspicious log found!");
    let hashed = hash_message("Hello, world!");
    println!("Hashed message: {}", hashed);
}
