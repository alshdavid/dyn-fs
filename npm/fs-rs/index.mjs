import napi from './load.mjs'

export class OsFileSystem {
  #ref
  constructor() {
    this.#ref = napi.new_os_file_system()
  }

  read(path) {
    return napi.read(path)
  }
}
