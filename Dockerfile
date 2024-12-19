FROM nginx:1.27.3

USER root

COPY dist/ /srv/www/html

USER 1001

CMD nginx -g "daemon off;"
