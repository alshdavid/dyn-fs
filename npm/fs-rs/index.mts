import napi from './load.mts'

export class OsFileSystem {
  #ref
  constructor() {
    this.#ref = napi.new_os_file_system()
  }

  read(path: string) {
    return napi.read(path)
  }
}
