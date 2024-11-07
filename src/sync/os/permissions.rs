use std::fs;
#[cfg(target_family = "unix")]
use std::os::unix::fs::PermissionsExt;

use crate::sync::Permissions;

pub struct OsPermissions(fs::Permissions);

impl From<fs::Permissions> for OsPermissions {
  fn from(value: fs::Permissions) -> Self {
    Self(value)
  }
}

impl Permissions for OsPermissions {
  fn readonly(&self) -> bool {
    self.0.readonly()
  }

  fn set_readonly(
    &mut self,
    readonly: bool,
  ) {
    self.0.set_readonly(readonly)
  }

  #[cfg(target_family = "unix")]
  fn mode(&self) -> u32 {
    self.0.mode()
  }

  #[cfg(target_family = "unix")]
  fn set_mode(
    &mut self,
    mode: u32,
  ) {
    self.0.set_mode(mode)
  }
}
