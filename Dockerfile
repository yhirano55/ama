FROM ruby:2.5-alpine
ENV LANG="ja_JP.UTF-8" \
    APP_PATH="/ama"
RUN apk --update --no-cache add build-base \
                                linux-headers \
                                git \
                                cmake \
                                less \
                                postgresql-dev \
                                nodejs \
                                yarn \
                                tzdata
WORKDIR $APP_PATH
ADD Gemfile* ./
RUN bundle install --jobs=4
ADD package.json yarn.lock ./
RUN yarn
COPY . $APP_PATH
