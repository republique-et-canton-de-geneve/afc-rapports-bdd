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

// Additional step: when FEATURES_DIR is a plain folder (no 'projects' subfolder),
// Vite places .feature files at the root of dist (keeping their relative paths).
// The app expects them under /projects/<slug>/. Mirror them accordingly.
try {
  const featuresDirEnv = process.env.FEATURES_DIR ? path.resolve(process.env.FEATURES_DIR) : undefined
  if (featuresDirEnv && fs.existsSync(featuresDirEnv)) {
    const hasProjectsSubfolder = fs.existsSync(path.join(featuresDirEnv, 'projects'))
    if (!hasProjectsSubfolder) {
      const slug = path.basename(path.resolve(featuresDirEnv))
      const distProjectsSlugDir = path.join(outDir, 'projects', slug)

      // Recursively walk FEATURES_DIR to find all .feature files and mirror them into dist/projects/<slug>
      const walk = (dir, baseDir) => {
        const entries = fs.readdirSync(dir)
        for (const entry of entries) {
          const fullPath = path.join(dir, entry)
          const stat = fs.statSync(fullPath)
          if (stat.isDirectory()) {
            walk(fullPath, baseDir)
          } else if (fullPath.endsWith('.feature')) {
            const relative = path.relative(baseDir, fullPath)
            const srcInDist = path.join(outDir, relative)
            const destInDist = path.join(distProjectsSlugDir, relative)
            const destDir = path.dirname(destInDist)
            if (!fs.existsSync(destDir)) {
              fs.mkdirSync(destDir, { recursive: true })
            }
            if (fs.existsSync(srcInDist)) {
              fs.copyFileSync(srcInDist, destInDist)
              console.log(`[postBuildCopy404] Mirrored feature: ${srcInDist} -> ${destInDist}`)
            } else {
              // If vite didn't copy the source (e.g., different publicDir structure), skip silently
              // to avoid failing the build.
              // console.log(`[postBuildCopy404] Source not found in dist, skipping: ${srcInDist}`)
            }
          }
        }
      }

      walk(featuresDirEnv, featuresDirEnv)
    }
  }
} catch (err) {
  console.warn(`[postBuildCopy404] Mirroring warning: ${err?.message || err}`)
}