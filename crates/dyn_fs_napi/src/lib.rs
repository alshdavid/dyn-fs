use std::sync::Arc;

use napi::*;

#[napi_derive::napi]
pub struct FileSystem(JsNumber);

#[napi_derive::napi]
pub fn new_os_file_system(env: Env) -> napi::Result<JsNumber> {
  todo!()
}