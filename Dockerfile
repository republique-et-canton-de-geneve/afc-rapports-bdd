# @see: https://git.devops.etat-ge.ch/gitlab/INFRA/libraries/containers/middlewares/nginx/ubi-9-nginx-122
FROM oci-release.devops.etat-ge.ch/ch/ge/common/middlewares/web/nginx.122-ubi9:1.0.1

USER root

COPY dist/ /srv/www/html

USER 1001

CMD nginx -g "daemon off;"
