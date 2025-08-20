import type CucumberReportProject from '@/models/cucumber-report-project'
import { FEATURE_SLUGS } from '@/generated/featureFiles'
import { USER_TRANSLATIONS, USER_DEFAULT_CATEGORY, USER_IGNORED_SLUGS } from '@/generated/userConfig'

const BUILTIN_IGNORED_SLUGS = ['urbafc-backend-template']
const CATEGORIE_PAR_DEFAUT = USER_DEFAULT_CATEGORY ?? 'Orphelins'

const TRANSLATIONS: CucumberReportProject[] = [
  { name: 'Mes documents', slug: 'mesdocuments-backend', categorie: '01-R-AFC/e-démarches' },
  { name: 'Page d\'accueil', slug: 'pageaccueil-backend', categorie: '01-R-AFC/e-démarches' },
  { name: 'RVI', slug: 'rvi-backend', categorie: '24-RVI' },
  { name: 'Assuj IPP', slug: 'assuj-ipp', categorie: '06-R-Fisc/Assujettissement' },
  { name: 'Changement periode assuj', slug: 'form-chgt-assuj-backend', categorie: '06-R-Fisc/Assujettissement' },
  { name: 'Mes comptes', slug: 'mescomptes-backend', categorie: '09-R-Perception/e-démarches' },
  { name: 'Contrôle barème', slug: 'controle-bareme-lr-backend', categorie: '12-R-ImpotSource/e-démarches' },
  { name: 'Depot LR', slug: 'depotlr-backend', categorie: '12-R-ImpotSource/e-démarches' },
  { name: 'Gestion IBAN', slug: 'gestiban-backend', categorie: '09-R-Perception/e-démarches' },
  { name: 'Prod impot PP', slug: 'prodimpotpp-backend', categorie: '10-R-TaxPP' },
  { name: 'Tax Immo', slug: 'tax-immo-backend', categorie: '25-Taximmo' },
  { name: 'RabbitMQ Admin', slug: 'rabbitmq-admin-backend', categorie: '01-R-AFC'},
  { name: 'Texte dynamique', slug: 'texte-dynamique-backend', categorie: '01-R-AFC/e-démarches' },
]

const USER_TRANSLATIONS_TYPED: CucumberReportProject[] = USER_TRANSLATIONS as unknown as CucumberReportProject[]
const ALL_IGNORED = [...BUILTIN_IGNORED_SLUGS, ...USER_IGNORED_SLUGS]

const CUCUMBER_REPORTS: CucumberReportProject[] = FEATURE_SLUGS
  .filter((slug) => !ALL_IGNORED.includes(slug))
  .map((slug) => {
    const translation = USER_TRANSLATIONS_TYPED.find((cucumberReport) => cucumberReport.slug === slug)
      || TRANSLATIONS.find((cucumberReport) => cucumberReport.slug === slug)
    if (translation) {
      return translation
    } else {
      return { name: slug, slug, categorie: CATEGORIE_PAR_DEFAUT }
    }
  })
  .sort((a, b) => a.name.localeCompare(b.name))

export { CUCUMBER_REPORTS }