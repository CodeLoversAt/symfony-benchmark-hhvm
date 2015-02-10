FROM codelovers/hhvm-composer-mongo

MAINTAINER Daniel Holzmann <daniel@codelovers.at>

ENV HOME /home/www-data
ENV TIMEZONE Europe/Vienna

RUN apt-get update && apt-get upgrade -y

# update config
ADD conf/php.ini /etc/hhvm/php.ini
ADD conf/server.ini /etc/hhvm/server.ini
RUN echo date.timezone=$TIMEZONE | tee -a /etc/hhvm/server.ini /etc/hhvm/php.ini

RUN mkdir -p /home/www-data
RUN chown -R www-data:www-data /home/www-data
RUN mkdir -p /tmp
RUN chmod -R 777 /var/run/hhvm

VOLUME /www

WORKDIR /www/web
ENTRYPOINT ["sudo", "-u", "www-data", "hhvm", "--mode",  "server",  "-vServer.Port=9000", "-vServer.Type=fastcgi"]

EXPOSE 9000
