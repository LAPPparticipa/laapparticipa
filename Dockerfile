FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
  build-essential libpq-dev nodejs yarn

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test --verbose

COPY . .

ENV RAILS_ENV=production
ENV NODE_ENV=production

RUN bundle exec rake assets:precompile

RUN yarn cache clean && \
    rm -rf tmp/cache && \
    rm -rf node_modules/.cache

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
