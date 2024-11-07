
if ([System.IO.File]::Exists("rust-toolchain")) {
  $contents = [IO.File]::ReadAllText("rust-toolchain")
  $rust_toolchain = "--default-toolchain=$contents"
}
$install_dir = "$HOME\.local\rust"

# Create Directories
if (Test-Path $install_dir) {
  Remove-Item -Recurse -Force -Path $install_dir
}
New-Item -ItemType "directory" -Force -Path "$install_dir"
New-Item -ItemType "directory" -Force -Path "$install_dir\rustup"
New-Item -ItemType "directory" -Force -Path "$install_dir\cargo"

# Setup Environment
$env:RUSTUP_HOME = "$install_dir\rustup"
$env:CARGO_HOME = "$install_dir\cargo"
$env:CARGO_BIN = "$install_dir\cargo\bin"
$env:Path += ";$env:CARGO_BIN"

Write-Output "RUSTUP_HOME=$env:RUSTUP_HOME" >> $env:GITHUB_ENV
Write-Output "CARGO_HOME=$env:CARGO_HOME" >> $env:GITHUB_ENV
Write-Output "CARGO_HOME=$env:CARGO_BIN" >> $env:GITHUB_ENV
Write-Output "$env:CARGO_BIN" >> $env:GITHUB_PATH

Invoke-WebRequest 'https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe' -OutFile $HOME\.local\rust\rustup-init.exe

& "$HOME\.local\rust\rustup-init.exe" -y --no-modify-path $rust_toolchain
