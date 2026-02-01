
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const file = path.join(__dirname, 'test_pointfree.sn');
const buffer = fs.readFileSync(file);
console.log("Hex Dump:");
for (let i = 0; i < buffer.length; i++) {
    process.stdout.write(buffer[i].toString(16).padStart(2, '0') + " ");
}
console.log("\nASCII:");
console.log(buffer.toString('utf8'));
