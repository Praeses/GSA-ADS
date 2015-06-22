FROM ruby:2.2

RUN apt-get update
RUN apt-get install nodejs -y
RUN apt-get install npm -y
RUN npm install -g coffee-script

RUN gem install bundler
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

VOLUME ["/src"]
WORKDIR /src
