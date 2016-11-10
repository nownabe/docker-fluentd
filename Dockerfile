FROM ruby:2.3.1-alpine
MAINTAINER nownabe

ENV build_deps "build-base"
RUN apk add --no-cache --update ${build_deps} \
  && apk add --no-cache ca-certificates \
  && gem install fluentd --no-document -v "0.14.8" \
  && apk del ${build_deps} \
  && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /usr/lib/ruby/gems/*/cache/*.gem \
  && mkdir -p /etc/fluentd/plugins

COPY ./fluentd.conf /etc/fluentd/

ENV FLUENTD_OPTS=""
ENV FLUENTD_CONF="/etc/fluentd/fluentd.conf"

CMD /usr/bin/fluentd -c $FLUENTD_CONF -p /etc/fluentd/plugins $FLUENTD_OPTS
