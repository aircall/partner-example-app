FROM ruby:2.6.1-slim

RUN apt-get update && apt-get install -y \
      build-essential \
      wget \
      && apt-get clean

WORKDIR /app

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4
ENV PATH="${BUNDLE_BIN}:${PATH}"

COPY ./Gemfile .
COPY ./Gemfile.lock .

RUN gem install bundler -v 2.0.1
RUN bundle install

COPY . /app
