
FROM hugo
COPY src/ /tmp/
RUN hugo -v --cleanDestinationDir

FROM caddy
COPY config/Caddyfile /etc/Caddyfile
COPY --from=hugo /tmp/public/ /var/www/
