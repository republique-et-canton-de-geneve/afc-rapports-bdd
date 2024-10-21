import type CucumberReportProject from '@/models/cucumber-report-project'
import { FEATURE_SLUGS } from '@/generated/featureFiles'

const TRANSLATIONS: CucumberReportProject[] = [
  { name: 'Assuj IPP', slug: 'assuj-ipp' },
  { name: 'Contrôle barème', slug: 'controle-bareme-lr-backend' },
  { name: 'Depot LR', slug: 'depotlr-backend' },
  { name: 'Gestion IBAN', slug: 'gestiban-backend' },
  { name: 'Prod impot PP', slug: 'prodimpotpp-backend' },
  { name: 'RVI', slug: 'rvi-backend' },
  { name: 'Tax Immo', slug: 'tax-immo-backend' },
  { name: 'Changement periode assuj', slug: 'form-chgt-assuj-backend' },
  { name: 'Mes documents', slug: 'mesdocuments-backend' },
  { name: 'Mes comptes', slug: 'mescomptes-backend' },
  { name: 'Page d\'acceuil', slug: 'pageaccueil-backend' },
  { name: 'RabbitMQ Admin', slug: 'rabbitmq-admin-backend' },
]

const IGNORED_SLUG = ['urbafc-backend-template']

const CUCUMBER_REPORTS: CucumberReportProject[] = FEATURE_SLUGS
  .filter((slug) => !IGNORED_SLUG.includes(slug))
  .map((slug) => {
    const translation = TRANSLATIONS.find((cucumberReport) => cucumberReport.slug === slug)
    if (translation) {
      return translation
    } else {
      return { name: slug, slug }
    }
  })
  .sort((a, b) => a.name.localeCompare(b.name))

export { CUCUMBER_REPORTS }
