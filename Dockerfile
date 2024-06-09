FROM ruby:3.3.1
COPY Gemfile /app/
COPY Gemfile.lock /app/
WORKDIR /app
RUN bundle install
