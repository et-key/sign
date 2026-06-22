// run_playground.js
import http from 'http';
import fs from 'fs';
import path from 'path';
import { exec } from 'child_process';

const PORT = parseInt(process.argv[2], 10) || 3980;
const WORKSPACE_DIR = process.cwd();
const PLAYGROUND_DIR = path.join(WORKSPACE_DIR, 'playground');

const MIME_TYPES = {
  '.html': 'text/html',
  '.css': 'text/css',
  '.js': 'application/javascript',
  '.json': 'application/json',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.jpg': 'image/jpeg'
};

const server = http.createServer((req, res) => {
  // Normalize request path
  let reqPath = req.url.split('?')[0];
  if (reqPath === '/') {
    reqPath = '/index.html';
  }

  // Determine which file system path to map to
  let filePath;
  if (reqPath === '/cat.js') {
    filePath = path.join(WORKSPACE_DIR, 'cat.js');
  } else if (reqPath === '/wabt.js') {
    filePath = path.join(WORKSPACE_DIR, 'node_modules', 'wabt', 'index.js');
  } else if (reqPath.startsWith('/pre_alpha/')) {
    filePath = path.join(WORKSPACE_DIR, reqPath);
  } else {
    filePath = path.join(PLAYGROUND_DIR, reqPath);
  }

  // Check if file exists
  if (fs.existsSync(filePath) && fs.statSync(filePath).isFile()) {
    const ext = path.extname(filePath);
    const contentType = MIME_TYPES[ext] || 'text/plain';
    res.writeHead(200, { 'Content-Type': contentType });
    fs.createReadStream(filePath).pipe(res);
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end(`404: Not Found (${reqPath})`);
  }
});

server.listen(PORT, () => {
  const url = `http://localhost:${PORT}`;
  console.log(`=== Sign Language Playground Server ===`);
  console.log(`Serving at: ${url}`);
  console.log(`Press Ctrl+C to stop the server.`);
  
  // Open the browser
  let command;
  switch (process.platform) {
    case 'darwin':
      command = `open ${url}`;
      break;
    case 'win32':
      command = `start ${url}`;
      break;
    default:
      command = `xdg-open ${url}`;
  }
  
  exec(command, (err) => {
    if (err) {
      console.log(`Please open your browser and go to: ${url}`);
    }
  });
});
