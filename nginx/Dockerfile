FROM nginx:1.16.1

COPY entrypoint.sh /sbin
COPY nginx.conf.* /tmp/

RUN mkdir -p /usr/share/nginx/html/admin-service

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["run-prod"]
