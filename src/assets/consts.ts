import type CucumberReportProject from '@/models/cucumber-report-project'
import { FEATURE_SLUGS } from '@/generated/featureFiles'
import { USER_TRANSLATIONS, USER_DEFAULT_CATEGORY, USER_IGNORED_SLUGS } from '@/generated/userConfig'

// Library must stay generic: no built-in project-specific ignores
const BUILTIN_IGNORED_SLUGS: string[] = []
const CATEGORIE_PAR_DEFAUT = USER_DEFAULT_CATEGORY ?? 'Orphelins'

const USER_TRANSLATIONS_TYPED: CucumberReportProject[] = USER_TRANSLATIONS as unknown as CucumberReportProject[]
const ALL_IGNORED = [...BUILTIN_IGNORED_SLUGS, ...USER_IGNORED_SLUGS]

const CUCUMBER_REPORTS: CucumberReportProject[] = FEATURE_SLUGS
  .filter((slug) => !ALL_IGNORED.includes(slug))
  .map((slug) => {
    const translation = USER_TRANSLATIONS_TYPED.find((cucumberReport) => cucumberReport.slug === slug)
    if (translation) {
      return translation
    } else {
      return { name: slug, slug, categorie: CATEGORIE_PAR_DEFAUT }
    }
  })
  .sort((a, b) => a.name.localeCompare(b.name))

export { CUCUMBER_REPORTS }
