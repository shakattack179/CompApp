FROM ruby:2.5.1-alpine

RUN apk add --update --no-cache build-base nodejs postgresql-dev tzdata libxml2-dev curl libcurl curl-dev git yarn

ENV INSTALL_PATH /app/competition_app
ENV RAILS_ENV production

ENV TZ=Africa/Johannesburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ADD Gemfile $INSTALL_PATH/Gemfile
ADD Gemfile.lock $INSTALL_PATH/Gemfile.lock

RUN cd $INSTALL_PATH && bundle install

COPY . .

RUN cd $INSTALL_PATH && rake assets:precompile
