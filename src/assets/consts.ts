import type CucumberReportProject from '@/models/cucumber-report-project'
import { FEATURE_SLUGS } from '@/generated/featureFiles'
const IGNORED_SLUG = ['urbafc-backend-template']
const CATEGORIE_PAR_DEFAUT = 'AFC'

const TRANSLATIONS: CucumberReportProject[] = [
  { name: 'Mes documents', slug: 'mesdocuments-backend', categorie: 'Référentiel' },
  { name: 'Page d\'accueil', slug: 'pageaccueil-backend', categorie: 'Référentiel' },
  { name: 'RVI', slug: 'rvi-backend', categorie: 'Référentiel' },
  { name: 'Assuj IPP', slug: 'assuj-ipp', categorie: 'Référentiel/Assuj' },
  { name: 'Changement periode assuj', slug: 'form-chgt-assuj-backend', categorie: 'Référentiel/Assuj' },
  { name: 'Mes comptes', slug: 'mescomptes-backend', categorie: 'Perception' },
  { name: 'Contrôle barème', slug: 'controle-bareme-lr-backend', categorie: 'Perception/IS' },
  { name: 'Depot LR', slug: 'depotlr-backend', categorie: 'Perception/IS' },
  { name: 'Gestion IBAN', slug: 'gestiban-backend', categorie: 'Perception' },
  { name: 'Prod impot PP', slug: 'prodimpotpp-backend', categorie: 'Taxation' },
  { name: 'Tax Immo', slug: 'tax-immo-backend', categorie: 'Taxation' },
  { name: 'RabbitMQ Admin', slug: 'rabbitmq-admin-backend', categorie: 'Taxation'},
  { name: 'Texte dynamique', slug: 'texte-dynamique-backend', categorie: 'Référentiel' },
  { name: 'E-démarches Autorisations', slug: 'edmautorisations-backend', categorie: 'Plateforme' },
]

const CUCUMBER_REPORTS: CucumberReportProject[] = FEATURE_SLUGS
  .filter((slug) => !IGNORED_SLUG.includes(slug))
  .map((slug) => {
    const translation = TRANSLATIONS.find((cucumberReport) => cucumberReport.slug === slug)
    if (translation) {
      return translation
    } else {
      return { name: slug, slug, categorie: CATEGORIE_PAR_DEFAUT }
    }
  })
  .sort((a, b) => a.name.localeCompare(b.name))

export { CUCUMBER_REPORTS }
