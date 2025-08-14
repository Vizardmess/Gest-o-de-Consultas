
const fs = require('fs');
const path = require('path');

const src = path.join(__dirname, '..', 'public');
const dst = path.join(__dirname, '..', 'dist');

fs.rmSync(dst, { recursive: true, force: true });
fs.mkdirSync(dst, { recursive: true });

function copyDir(s, d) {
  for (const entry of fs.readdirSync(s, { withFileTypes: true })) {
    const sp = path.join(s, entry.name);
    const dp = path.join(d, entry.name);
    if (entry.isDirectory()) {
      fs.mkdirSync(dp, { recursive: true });
      copyDir(sp, dp);
    } else {
      fs.copyFileSync(sp, dp);
    }
  }
}

copyDir(src, dst);
console.log('✓ Build estático copiado para dist/');
