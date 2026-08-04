import http from "node:http";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.dirname(fileURLToPath(import.meta.url)); // alpha/javascript/playground
const base = path.dirname(root); // alpha/javascript
const port = 5183;

const MIME = { ".html": "text/html", ".js": "text/javascript", ".mjs": "text/javascript", ".css": "text/css" };

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
  .listen(port, () => console.log(`playground server on http://localhost:${port}`));
