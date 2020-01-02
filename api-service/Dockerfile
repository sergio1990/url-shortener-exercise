FROM ruby:2.5

ENV APP_HOME /app

RUN apt-get update -qq && apt-get install -y build-essential

RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/lib
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install --without development test

ADD lib/ $APP_HOME/lib
ADD config.ru $APP_HOME

CMD ["bundle", "exec", "puma", "-C", "puma.rb"]
