FROM ruby:2.5
ENV LANG C.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y cmake nodejs postgresql-client --no-install-recommends && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

WORKDIR /usr/src/app

COPY package.json .
COPY yarn.lock .
RUN yarn

COPY . /usr/src/app

EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
