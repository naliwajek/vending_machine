FROM ruby:2.5.1-alpine3.7

RUN apk --no-cache add less

WORKDIR /app

COPY Gemfile Gemfile.lock .ruby-version ./

RUN apk --no-cache add alpine-sdk && \
    bundle install && \
    apk del alpine-sdk

ADD . /app
