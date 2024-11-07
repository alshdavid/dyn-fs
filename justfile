set windows-shell := ["pwsh", "-NoLogo", "-NoProfileLoadTime", "-Command"]

profile := env_var_or_default("profile", "debug")

os := \
if \
  env_var_or_default("os", "") == "Windows_NT" { "windows" } \
else if \
  env_var_or_default("os", "") != "" { env_var("os") } \
else \
  { os() }

arch := \
if \
  env_var_or_default("arch", "") != "" { env_var("arch") } \
else if \
  arch() == "x86_64" { "amd64" } \
else if \
  arch() == "aarch64" { "arm64" } \
else \
  { arch() }

target := \
if \
  os + arch == "linuxamd64" { "x86_64-unknown-linux-gnu" } \
else if \
  os + arch == "linuxarm64" { "aarch64-unknown-linux-gnu" } \
else if \
  os + arch == "macosamd64" { "x86_64-apple-darwin" } \
else if\
  os + arch == "macosarm64" { "aarch64-apple-darwin" } \
else if \
  os + arch == "windowsamd64" { "x86_64-pc-windows-msvc" } \
else if \
  os + arch == "windowsarm64" { "aarch64-pc-windows-msvc" } \
else \
  { env_var_or_default("target", "debug") }

dll := \
if \
  os == "linux" { "so" } \
else if \
  os == "macos" { "dylib" } \
else if \
  os == "windows" { "dll" } \
else \
  { "" }

profile_cargo := \
if \
  profile != "debug" { "--profile " + profile } \
else \
  { "" }

target_cargo := \
if \
  target == "debug" { "" } \
else if \
  target == "" { "" } \
else \
  { "--target " + target } 

build: build_rs build_ts

[unix]
build_rs:
  cargo build {{profile_cargo}} {{target_cargo}}
  cp "./target/{{target}}/{{profile}}/libdyn_fs_napi.{{dll}}" "./javascript/fs/{{target}}.node"

[windows]
build_rs:
  cargo build {{profile_cargo}} {{target_cargo}}
  cp "./target/{{target}}/{{profile}}/dyn_fs_napi.{{dll}}" "./javascript/fs/{{target}}.node"

build_ts:
  cd "./javascript/fs" && npx tsc

run_node:
  @node \
    --experimental-strip-types \
    --conditions="fs::sources" \
    --disable-warning=ExperimentalWarning \
    ./examples/nodejs_basic/index.mts
