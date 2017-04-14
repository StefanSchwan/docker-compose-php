FROM nginx:stable-alpine

RUN apk add --update --no-cache \
          bash \
          curl  \
          tree \
          vim \
          less

ADD ./etc/default.conf /etc/nginx/conf.d/mysite.template
ADD ./etc/nginx.conf /etc/nginx/nginx.conf
