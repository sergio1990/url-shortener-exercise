FROM nginx:1.16.1

ARG server_name
ARG api_host
ENV SERVER_NAME ${server_name}
ENV API_HOST ${api_host}

ADD nginx.conf.tmpl /tmp
RUN sed \
  -e "s/{{SERVER_NAME}}/$SERVER_NAME/g" \
  -e "s/{{API_HOST}}/$API_HOST/g" \
  /tmp/nginx.conf.tmpl > /etc/nginx/nginx.conf

RUN mkdir -p /usr/share/nginx/html/admin-service
