FROM centos:6

ENV TZ Asia/Tokyo
RUN /bin/cp -f /usr/share/zoneinfo/Japan /etc/localtime \
      && echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock

RUN yum -y install epel-release \
    && rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org \
    && rpm -Uvh http://www.elrepo.org/elrepo-release-6-8.el6.elrepo.noarch.rpm \
    && yum -y update \
    \
    && yum -y install bash curl lv sudo tree which wget yum-utils \
    \
    && yum clean all

RUN set -xe; \
    rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi; \
    rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm; \
# Install php (php54)
    yum -y install --enablerepo=remi-php54 php php-fpm php-mcrypt php-pear php-pecl-xdebug; \
    \
# Install php71 for checking muiltiple versions compatibility
    yum -y install php71 php71-php-fpm php71-php-mcrypt php71-php-pear php71-php-pecl-xdebug; \
    \
# Install composer like https://getcomposer.org/download/
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"; \
    php composer-setup.php --install-dir=/usr/local/bin; \
    php -r "unlink('composer-setup.php');"; \
    ln -s /usr/local/bin/composer.phar /usr/local/bin/composer; \
    composer --version; \
    \
    yum clean all;

# Install nginx: https://nginx.org/en/linux_packages.html
COPY yum.repos.d/nginx-centos6.repo /etc/yum.repos.d/nginx.repo
RUN yum -y install nginx && yum clean all

COPY nginx/conf.d /tmp/nginx_conf.d
COPY php.d/90-user_overwrite.ini /etc/php.d/90-user_overwrite.ini
COPY app /var/www/webdb-php/app
RUN set -xe; \
    /bin/rm -rf /etc/nginx/conf.d && /bin/cp -R /tmp/nginx_conf.d /etc/nginx/conf.d; \
    php-fpm -t; \
    nginx -t;

# Do not run Composer as root/super user! See https://getcomposer.org/root for details
RUN useradd -m -u 104 webdb-php \
    && id webdb-php

COPY sudoers.d/webdb-php /etc/sudoers.d/webdb-php
COPY docker-entrypoint.sh /home/webdb-php/docker-entrypoint.sh

USER webdb-php
WORKDIR /home/webdb-php
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["/bin/bash"]
