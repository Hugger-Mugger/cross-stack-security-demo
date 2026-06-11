import { exec } from "child_process";

exec("cargo run --manifest-path ../rust-service/Cargo.toml", (error, stdout) => {
  if (error) {
    console.error("Error running Rust program:", error);
    return;
  }
  console.log("Rust output:", stdout);
});
