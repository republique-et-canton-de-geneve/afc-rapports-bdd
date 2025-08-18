/* eslint-env node */
import { fileURLToPath } from 'url'
import path, { dirname } from 'path'
import fs from 'fs'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

// Determine the actual output directory used by Vite
const outDirEnv = process.env.OUT_DIR
const outDir = outDirEnv ? path.resolve(outDirEnv) : path.resolve(__dirname, '../dist')

try {
  const indexPath = path.join(outDir, 'index.html')
  const targetPath = path.join(outDir, '404.html')

  if (fs.existsSync(indexPath)) {
    // Ensure directory exists (Vite should have created it already)
    fs.copyFileSync(indexPath, targetPath)
    console.log(`[postBuildCopy404] Copied: ${indexPath} -> ${targetPath}`)
  } else {
    console.log(`[postBuildCopy404] index.html not found in ${outDir}. Skipping 404.html copy.`)
  }
} catch (err) {
  console.warn(`[postBuildCopy404] Warning: ${err?.message || err}`)
  // Do not fail the build because of this convenience step
}