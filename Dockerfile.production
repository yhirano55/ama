FROM node:10-alpine as node
FROM ruby:2.6.1-alpine
ENV LANG="ja_JP.UTF-8" \
    APP_PATH="/ama" \
    RAILS_ENV="production"
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /opt/yarn-v* /opt/yarn
RUN apk --update --no-cache add build-base \
                                linux-headers \
                                git \
                                cmake \
                                less \
                                postgresql-dev \
                                tzdata \
    && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg
WORKDIR $APP_PATH
ADD Gemfile* ./
RUN bundle install --jobs=4 --without development test
ADD package.json yarn.lock ./
RUN yarn
COPY . $APP_PATH
RUN rails assets:precompile
