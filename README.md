# PHP Continuous Updation

これは [WEB+DB PRESS vol.104][webdb-press-link] に掲載されている *事業を支えるPHP* の動作確認環境です。

[webdb-press-link]: http://gihyo.jp/magazine/wdpress/archive/2018/vol104

## 動作環境の入手

[Docker][docker-ce]を使ってイメージを取得、動作させることが可能です。

[docker-ce]: https://www.docker.com/community-edition

```console
# Docker registry経由でのイメージ取得
$ docker pull nishigori/webdb-php:vol104
$ docker tag nishigori/webdb-php:vol104 webdb-php:vol104

# 手元でイメージビルドする場合
$ git clone https://github.com/nishigori/webdb_press-php_versions_updation.git
$ cd webdb_press-php_versions_updation
$ docker build -f centos6.Dockerfile -t webdb-php:vol104 .
```

docker runコマンドでDockerコンテナを起動します

```console
$ docker run --rm -it webdb-php:vol104
   __        _______ ____        ____  ____    ____  ____  _____ ____ ____
   \ \      / / ____| __ )   _  |  _ \| __ )  |  _ \|  _ \| ____/ ___/ ___|
    \ \ /\ / /|  _| |  _ \ _| |_| | | |  _ \  | |_) | |_) |  _| \___ \___ \
     \ V  V / | |___| |_) |_   _| |_| | |_) | |  __/|  _ <| |___ ___) |__) |
      \_/\_/  |_____|____/  |_| |____/|____/  |_|   |_| \_\_____|____/____/

                 #### vol.104 連載 ~ 事業を支えるPHP ####


#############
# PHP Version
#############
/usr/bin/php
PHP 5.4.45 (cli) (built: Mar  1 2018 10:09:59)
Copyright (c) 1997-2014 The PHP Group
Zend Engine v2.4.0, Copyright (c) 1998-2014 Zend Technologies
    with Zend OPcache v7.0.5, Copyright (c) 1999-2015, by Zend Technologies
    with Xdebug v2.4.1, Copyright (c) 2002-2016, by Derick Rethans

# For multiple versions compatibility
/usr/bin/php71
PHP 7.1.15 (cli) (built: Feb 28 2018 13:40:50) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2018 Zend Technologies
    with Zend OPcache v7.1.15, Copyright (c) 1999-2018, by Zend Technologies
    with Xdebug v2.6.0, Copyright (c) 2002-2018, by Derick Rethans

##################
# Composer version
##################
/usr/local/bin/composer.phar
Composer version 1.6.3 2018-01-31 16:28:17

###########################################
NOTE: Please exec more commands if you want
###########################################
$ rpm -qa php\*                  #=> Installed PHP packages from RPM
$ php -i                         #=> PHP information
$ pecl list                      #=> Installed PECL packages
$ curl localhost/php_version.php #=> PHP version + bit more from http
$ curl localhost/index.php       #=> phpinfo() from http

Start daemon processes ...
Starting php-fpm:                                          [  OK  ]
Starting nginx:                                            [  OK  ]

[webdb-php@xxxxxxxxxxxx ~]$
```
