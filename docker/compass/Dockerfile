FROM alpine:3.5

#install ruby and compass
 RUN apk add --update \
            ruby \
            ruby-irb \
            ruby-json \
            ruby-rake \
            ruby-dev \
            build-base \
            libffi-dev \
        && gem install sass compass --no-ri --no-rdoc \
        && apk del build-base libffi-dev ruby-dev \
        && rm -rf /var/cache/apk/*

ENTRYPOINT ["compass"]
