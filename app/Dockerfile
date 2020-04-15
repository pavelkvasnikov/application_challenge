FROM lambci/lambda:build-ruby2.5
RUN yum -y install mysql-devel
RUN mkdir /var/task/lib
RUN cp /usr/lib64/mysql/libmysqlclient.so.18 /var/task/lib


COPY Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler
RUN bundle install

ENV APP_HOME /app/

RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/tmp
WORKDIR $APP_HOME

ADD . $APP_HOME
