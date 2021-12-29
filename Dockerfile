FROM ruby:2.7.2

# Include VIM in case we want to connect to the container
RUN apt-get update -qq && apt-get install -y build-essential && apt-get install -y vim

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME/
# Copy the hidden .env file
COPY .env $APP_HOME/

RUN bundle install --without development test
