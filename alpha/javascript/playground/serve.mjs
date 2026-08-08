import http from "node:http";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { exec } from "node:child_process";

const root = path.dirname(fileURLToPath(import.meta.url)); // alpha/javascript/playground
const base = path.dirname(root); // alpha/javascript
const port = 5183;

// インストーラー（install_alpha.ps1）経由でダブルクリック起動する非開発者ユーザーを
// 想定し、URLをコンソールに出すだけでなく既定ブラウザで自動的に開く
// （root/run_playground.jsと同じ挙動に揃える）。
function openBrowser(url) {
  const cmd = process.platform === "win32" ? `start ${url}` : process.platform === "darwin" ? `open ${url}` : `xdg-open ${url}`;
  exec(cmd, (err) => {
    if (err) console.log(`ブラウザで開けませんでした。手動で ${url} を開いてください。`);
  });
}

const MIME = { ".html": "text/html", ".js": "text/javascript", ".mjs": "text/javascript", ".css": "text/css", ".svg": "image/svg+xml" };

http
  .createServer((req, res) => {
    let p = req.url.split("?")[0];
    if (p === "/") p = "/playground/index.html";
    const file = path.join(base, p);
    if (!file.startsWith(base)) {
      res.writeHead(403);
      res.end();
      return;
    }
    fs.readFile(file, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end("not found: " + p);
        return;
      }
      res.writeHead(200, { "Content-Type": MIME[path.extname(file)] || "application/octet-stream" });
      res.end(data);
    });
  })
  .listen(port, () => {
    const url = `http://localhost:${port}`;
    console.log(`playground server on ${url}`);
    openBrowser(url);
  });
