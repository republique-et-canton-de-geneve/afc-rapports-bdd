import fs from 'node:fs'
import os from 'node:os'
import path from 'node:path'
import { spawnSync } from 'node:child_process'

const SLUG_PATTERN = /^[a-zA-Z0-9][a-zA-Z0-9._-]*$/
const SECRET_FILE_PATTERN = /(^\.env($|\.)|\.pem$|\.key$|\.p12$|\.pfx$|(^|\.)credentials?(\.|$)|(^|\.)secrets?(\.|$)|^id_(rsa|ed25519)$|^\.npmrc$)/i
const PRIVATE_DIRECTORY_PATTERN = /^(\.git|\.ssh|\.aws|node_modules|secrets?|credentials?)$/i

function runGit(args, cwd) {
  const result = spawnSync('git', args, {
    cwd,
    encoding: 'utf8',
    stdio: ['ignore', 'pipe', 'pipe'],
    windowsHide: true
  })
  if (result.error) throw new Error(`Impossible d’exécuter Git : ${result.error.message}`)
  if (result.status !== 0) {
    const details = (result.stderr || result.stdout || '').trim()
    throw new Error(`La commande Git a échoué${details ? ` : ${details}` : '.'}`)
  }
  return result.stdout.trim()
}

function validateRepository(repository) {
  if (typeof repository !== 'string' || !repository.trim() || /[\r\n\0]/.test(repository)) {
    throw new Error('Chaque sourceGit doit avoir une propriété repository valide.')
  }
  if (/^[a-z][a-z\d+.-]*:\/\//i.test(repository)) {
    const parsed = new URL(repository)
    if (parsed.username || parsed.password || parsed.search || parsed.hash) {
      throw new Error('Ne placez pas de jetons, identifiants ou paramètres dans l’URL Git; utilisez le gestionnaire d’identifiants Git ou SSH.')
    }
    if (!['https:', 'ssh:', 'file:'].includes(parsed.protocol)) {
      throw new Error('Les sources Git doivent utiliser HTTPS, SSH ou file://.')
    }
  } else if (!/^(?:[^@/:\s]+@)?[^/:\s]+:.+$/.test(repository)) {
    throw new Error('L’URL Git doit être HTTPS, SSH, file:// ou au format SSH scp.')
  }
}

function validateRelativePath(value, property) {
  if (typeof value !== 'string' || !value.trim() || path.isAbsolute(value) || value.split(/[\\/]/).includes('..')) {
    throw new Error(`La propriété ${property} doit être un chemin relatif sans segment « .. ».`)
  }
  return value
}

function listFeatureFiles(root) {
  const files = []
  const walk = (directory) => {
    for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
      const fullPath = path.join(directory, entry.name)
      if (entry.isSymbolicLink()) continue
      if (entry.isDirectory()) walk(fullPath)
      else if (entry.isFile() && entry.name.endsWith('.feature')) files.push(fullPath)
    }
  }
  if (fs.existsSync(root)) walk(root)
  return files
}

function copyLocalAssets(source, destination, skipFeatures = false) {
  const walk = (sourceDir, destinationDir) => {
    fs.mkdirSync(destinationDir, { recursive: true })
    for (const entry of fs.readdirSync(sourceDir, { withFileTypes: true })) {
      const sourcePath = path.join(sourceDir, entry.name)
      const destinationPath = path.join(destinationDir, entry.name)
      if (entry.isSymbolicLink() || PRIVATE_DIRECTORY_PATTERN.test(entry.name) || SECRET_FILE_PATTERN.test(entry.name)) continue
      if (entry.isDirectory()) walk(sourcePath, destinationPath)
      else if (entry.isFile()) {
        if (skipFeatures && entry.name.endsWith('.feature')) continue
        fs.copyFileSync(sourcePath, destinationPath)
      }
    }
  }
  if (fs.existsSync(source)) walk(source, destination)
}

function copyLocalSimpleFeatures(source, destination, slug) {
  for (const featureFile of listFeatureFiles(source)) {
    const relativePath = path.relative(source, featureFile)
    const destinationPath = path.join(destination, 'projects', slug, relativePath)
    fs.mkdirSync(path.dirname(destinationPath), { recursive: true })
    fs.copyFileSync(featureFile, destinationPath)
  }
}

function copyRemoteFeatures(repoDirectory, featurePaths, destination, slug) {
  const copiedPaths = new Set()
  for (const featurePath of featurePaths) {
    const selectedDirectory = path.resolve(repoDirectory, featurePath)
    const relative = path.relative(repoDirectory, selectedDirectory)
    if (relative.startsWith('..') || path.isAbsolute(relative) || !fs.existsSync(selectedDirectory) || !fs.statSync(selectedDirectory).isDirectory()) {
      throw new Error(`Le chemin features « ${featurePath} » est introuvable ou invalide pour le dépôt du projet « ${slug} ».`)
    }
    const features = listFeatureFiles(selectedDirectory)
    if (!features.length) throw new Error(`Aucun fichier .feature trouvé dans « ${featurePath} » pour le projet « ${slug} ».`)
    for (const featureFile of features) {
      const relativePath = path.relative(selectedDirectory, featureFile)
      const normalizedPath = relativePath.split(path.sep).join('/')
      if (copiedPaths.has(normalizedPath)) {
        throw new Error(`Collision de feature « ${normalizedPath} » entre plusieurs chemins sources du projet « ${slug} ».`)
      }
      copiedPaths.add(normalizedPath)
      const destinationPath = path.join(destination, 'projects', slug, relativePath)
      fs.mkdirSync(path.dirname(destinationPath), { recursive: true })
      fs.copyFileSync(featureFile, destinationPath)
    }
  }
}

function fetchSource(source, checkoutDirectory) {
  validateRepository(source.repository)
  const ref = source.ref
  if (typeof ref !== 'string' || !ref.trim() || /[\r\n\0]/.test(ref) || ref.startsWith('-')) {
    throw new Error(`La propriété ref est absente ou invalide pour le projet « ${source.slug} ».`)
  }
  const configuredPaths = Array.isArray(source.paths) ? source.paths : [source.path]
  if (!configuredPaths.length) throw new Error(`La liste paths est vide pour le projet « ${source.slug} ».`)
  if (source.paths !== undefined && source.path !== undefined) throw new Error(`Utilisez path ou paths, mais pas les deux, pour le projet « ${source.slug} ».`)
  const featurePaths = [...new Set(configuredPaths.map((featurePath) => validateRelativePath(featurePath, 'path')))]
  if (featurePaths.length !== configuredPaths.length) throw new Error(`La liste paths contient des chemins en double pour le projet « ${source.slug} ».`)
  if (typeof source.slug !== 'string' || !SLUG_PATTERN.test(source.slug) || source.slug === '.' || source.slug === '..') {
    throw new Error('Chaque sourceGit doit avoir une propriété slug contenant uniquement lettres, chiffres, points, tirets ou tirets bas.')
  }

  fs.mkdirSync(checkoutDirectory, { recursive: true })
  runGit(['init', '--quiet'], checkoutDirectory)
  runGit(['remote', 'add', 'origin', source.repository], checkoutDirectory)
  runGit(['-c', 'protocol.file.allow=always', 'fetch', '--depth=1', '--no-tags', 'origin', ref], checkoutDirectory)
  runGit(['checkout', '--quiet', '--detach', 'FETCH_HEAD'], checkoutDirectory)
  return { featurePaths, slug: source.slug }
}

export function prepareGitFeatureSources(localFeaturesDirectory) {
  const localRoot = path.resolve(localFeaturesDirectory)
  const configPath = path.join(localRoot, 'rapports-bdd.config.json')
  if (!fs.existsSync(configPath)) return undefined

  let config
  try {
    config = JSON.parse(fs.readFileSync(configPath, 'utf8'))
  } catch (error) {
    throw new Error(`Le fichier ${configPath} n’est pas un JSON valide : ${error.message}`)
  }
  if (!config || typeof config !== 'object' || Array.isArray(config)) throw new Error('La configuration rapports-bdd.config.json doit être un objet JSON.')
  if (config.sourcesGit === undefined) return undefined
  if (!Array.isArray(config.sourcesGit)) throw new Error('La propriété sourcesGit doit être un tableau.')
  if (!config.sourcesGit.length) return undefined

  const stagingDirectory = fs.mkdtempSync(path.join(os.tmpdir(), 'rapports-bdd-git-'))
  try {
    const projectsSource = path.join(localRoot, 'projects')
    const localHasProjects = fs.existsSync(projectsSource) && fs.statSync(projectsSource).isDirectory()
    const occupiedSlugs = new Set()

    if (localHasProjects) {
      copyLocalAssets(localRoot, stagingDirectory)
      for (const entry of fs.readdirSync(projectsSource, { withFileTypes: true })) {
        if (entry.isDirectory()) occupiedSlugs.add(entry.name)
      }
    } else {
      const localSlug = path.basename(localRoot)
      if (!SLUG_PATTERN.test(localSlug)) throw new Error(`Le nom du dossier de features « ${localSlug} » n’est pas un slug valide.`)
      occupiedSlugs.add(localSlug)
      copyLocalAssets(localRoot, stagingDirectory, true)
      copyLocalSimpleFeatures(localRoot, stagingDirectory, localSlug)
    }

    for (const source of config.sourcesGit) {
      if (!source || typeof source !== 'object' || Array.isArray(source)) throw new Error('Chaque entrée de sourcesGit doit être un objet.')
      if (occupiedSlugs.has(source.slug)) throw new Error(`Le slug « ${source.slug} » est en collision avec un projet existant.`)
      const sourceDirectory = fs.mkdtempSync(path.join(stagingDirectory, '.checkout-'))
      try {
        const { featurePaths, slug } = fetchSource(source, sourceDirectory)
        copyRemoteFeatures(sourceDirectory, featurePaths, stagingDirectory, slug)
        occupiedSlugs.add(slug)
      } finally {
        fs.rmSync(sourceDirectory, { recursive: true, force: true })
      }
    }

    const publicConfig = {}
    if (Array.isArray(config.translations)) publicConfig.translations = config.translations
    if (typeof config.defaultCategory === 'string') publicConfig.defaultCategory = config.defaultCategory
    if (Array.isArray(config.ignoredSlugs)) publicConfig.ignoredSlugs = config.ignoredSlugs
    fs.writeFileSync(path.join(stagingDirectory, 'rapports-bdd.config.json'), `${JSON.stringify(publicConfig, null, 2)}\n`)
    return stagingDirectory
  } catch (error) {
    fs.rmSync(stagingDirectory, { recursive: true, force: true })
    throw error
  }
}
