FROM ruby:2.5

ENV APP_HOME /app

RUN apt-get update -qq && apt-get install -y build-essential

RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/lib
WORKDIR $APP_HOME

COPY Gemfile* ./
RUN bundle install --without development test

COPY . ./

CMD ["bundle", "exec", "puma", "-C", "puma.rb"]
