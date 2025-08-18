#!/usr/bin/env node
/* eslint-env node */
import { spawnSync } from 'child_process'
import path from 'path'
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
  process.env.FEATURES_DIR = path.resolve(process.cwd(), featuresPath)
}

const outDir = getArgValue('--out')
if (outDir) {
  process.env.OUT_DIR = path.resolve(process.cwd(), outDir)
}

const basePath = getArgValue('--base')
if (basePath) {
  process.env.BASE_PATH = basePath
}

const result = spawnSync('npm', ['run', 'build'], { stdio: 'inherit', cwd: pkgRoot })
process.exit(result.status)
