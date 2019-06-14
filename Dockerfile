FROM ruby:2.6.3-alpine3.9

RUN bundle config --global frozen 1

WORKDIR /app
COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN cat /etc/os-release \
    ; apk add --no-cache --update --virtual .build-deps \
      g++ make \
    && bundle install -j4 --without test development --system \
    && apk del .build-deps

CMD ["terraforming", "help"]
