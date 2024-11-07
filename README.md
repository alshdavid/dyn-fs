# IFileSystem Rust

## File System Trait

This crate offers a trait that looks exactly like the `std::fs` interface and supplies implementations for the os filesystem and an in-memory filesystem.

Useful for substituting the FileSystem in tests and benchmarks

```rust
use ifilesystem::sync::FileSystem;
use ifilesystem::sync::os::OsFileSystem;
use ifilesystem::sync::mem::MemoryFileSystem;

fn read_file(fs: &dyn FileSystem) {
  let contents = fs.read(PathBuf::from("/path/to/file"))?;
  println!("{}", contents.len())
}

fn main() {
  let os_fs = OsFileSystem::default();
  let mem_fs = MemoryFileSystem::default();

  read_file(&os_fs);
  read_file(&mem_fs);
}
```
