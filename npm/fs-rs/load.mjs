import { dlopen } from 'node:process';
import { constants } from 'node:os';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
const __dirname = dirname(fileURLToPath(import.meta.url));
const module = { exports: {} };
let target;
if (process.env.FS_RS_PATH) {
    target = process.env.FS_RS_PATH;
}
else if (process.platform === 'linux' && process.arch === 'x64') {
    target = join(__dirname, 'x86_64-unknown-linux-gnu.node');
}
else if (process.platform === 'linux' && process.arch === 'arm64') {
    target = join(__dirname, 'aarch64-unknown-linux-gnu.node');
}
else if (process.platform === 'darwin' && process.arch === 'x64') {
    target = join(__dirname, 'x86_64-apple-darwin.node');
}
else if (process.platform === 'darwin' && process.arch === 'arm64') {
    target = join(__dirname, 'aarch64-apple-darwin.node');
}
else if (process.platform === 'win32' && process.arch === 'x64') {
    target = join(__dirname, 'x86_64-pc-windows-msvc.node');
}
else if (process.platform === 'win32' && process.arch === 'arm64') {
    target = join(__dirname, 'aarch64-pc-windows-msvc.node');
}
else {
    console.log('PLATFORM NOT SUPPORTED');
    process.exit(1);
}
dlopen(module, target, constants.dlopen.RTLD_NOW);
export default module.exports;
