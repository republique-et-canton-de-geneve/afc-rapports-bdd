import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { spawnSync } from 'node:child_process'
import fs from 'node:fs'
import process from 'node:process'
import { prepareGitFeatureSources } from './gitFeatureSources.js'

const scriptDirectory = path.dirname(fileURLToPath(import.meta.url))
const packageRoot = path.resolve(scriptDirectory, '..')
const inputFeaturesDirectory = process.env.FEATURES_DIR || path.join(packageRoot, 'public')
let stagedFeaturesDirectory
let exitCode = 1

function run(command, args) {
  const result = spawnSync(command, args, {
    cwd: packageRoot,
    env: process.env,
    stdio: 'inherit',
    shell: false,
    windowsHide: true
  })
  if (result.error) throw result.error
  return result.status ?? 1
}

try {
  stagedFeaturesDirectory = prepareGitFeatureSources(inputFeaturesDirectory)
  if (stagedFeaturesDirectory) process.env.FEATURES_DIR = stagedFeaturesDirectory

  const steps = [
    [process.execPath, ['scripts/generateFeatureFiles.js']],
    [process.execPath, ['node_modules/vite/bin/vite.js', 'build']],
    [process.execPath, ['scripts/postBuildCopy404.js']]
  ]

  exitCode = 0
  for (const [command, args] of steps) {
    exitCode = run(command, args)
    if (exitCode !== 0) break
  }
} catch (error) {
  console.error(`[build] ${error.message}`)
} finally {
  if (stagedFeaturesDirectory) fs.rmSync(stagedFeaturesDirectory, { recursive: true, force: true })
}

process.exitCode = exitCode
