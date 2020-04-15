FROM ruby:2.6.0

RUN apt-get update -qq && apt-get install -y build-essential netcat

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler
RUN bundle install

ENV APP_HOME /app/

RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/tmp
WORKDIR $APP_HOME

ADD . $APP_HOME
