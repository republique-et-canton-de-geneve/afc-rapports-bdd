#!/usr/bin/env node
/* eslint-env node */
import { spawnSync } from 'child_process'
import path from 'path'
import fs from 'fs'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const pkgRoot = path.resolve(__dirname, '..')

function getArgValue(flag) {
  const index = process.argv.indexOf(flag)
  return index !== -1 ? process.argv[index + 1] : undefined
}

const featuresPath = getArgValue('--features')
if (featuresPath) {
  const resolvedFeatures = path.resolve(process.cwd(), featuresPath)
  if (fs.existsSync(resolvedFeatures)) {
    process.env.FEATURES_DIR = resolvedFeatures
  } else {
    console.warn(`[rapports-bdd] Features directory not found: ${resolvedFeatures}. Falling back to default public assets.`)
  }
}

const outDir = getArgValue('--out')
if (outDir) {
  process.env.OUT_DIR = path.resolve(process.cwd(), outDir)
}

const basePath = getArgValue('--base')
if (basePath) {
  process.env.BASE_PATH = basePath
}

console.log(`[rapports-bdd] Using FEATURES_DIR="${process.env.FEATURES_DIR ?? ''}", OUT_DIR="${process.env.OUT_DIR ?? ''}", BASE_PATH="${process.env.BASE_PATH ?? ''}"`)
const npmCmd = process.platform === 'win32' ? 'npm.cmd' : 'npm'
const result = spawnSync(npmCmd, ['run', 'build'], { stdio: 'inherit', cwd: pkgRoot, env: { ...process.env }, shell: true })
if (result.error) {
  console.error(`[rapports-bdd] Failed to run build: ${result.error.message}`)
}
process.exit(result.status ?? 1)
