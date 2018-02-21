#!/bin/bash
#
# Docker entrypoint
#
set -e;

IS_EL7=$(test -f /etc/os-release 2>/dev/null; echo $?)

cat <<'DESCRIPTION_EOF'
   __        _______ ____        ____  ____    ____  ____  _____ ____ ____
   \ \      / / ____| __ )   _  |  _ \| __ )  |  _ \|  _ \| ____/ ___/ ___|
    \ \ /\ / /|  _| |  _ \ _| |_| | | |  _ \  | |_) | |_) |  _| \___ \___ \
     \ V  V / | |___| |_) |_   _| |_| | |_) | |  __/|  _ <| |___ ___) |__) |
      \_/\_/  |_____|____/  |_| |____/|____/  |_|   |_| \_\_____|____/____/

                 #### vol.104 連載 ~ 事業を支えるPHP ####

DESCRIPTION_EOF

cat <<'EOF'

#############
# PHP Version
#############
EOF
which php
php -v
echo ""
echo "# For multiple versions compatibility"
which php71
php71 -v

cat <<'EOF'

##################
# Composer version
##################
EOF
which composer.phar
composer.phar --version

if [ "0" != "${IS_EL7}" ]; then
cat <<'EOF'

###########################################
NOTE: Please exec more commands if you want
###########################################
$ rpm -qa php\*                  #=> Installed PHP packages from RPM
$ php -i                         #=> PHP information
$ pecl list                      #=> Installed PECL packages
$ curl localhost/php_version.php #=> PHP version + bit more from http
$ curl localhost/index.php       #=> phpinfo() from http

EOF
else
cat <<'EOF'

###########################################
NOTE: Please exec more commands if you want
###########################################
$ rpm -qa php\*                  #=> Installed PHP packages from RPM
$ php -i                         #=> PHP information
$ pecl list                      #=> Installed PECL packages

EOF
fi

if [ "0" != "${IS_EL7}" ]; then
  echo "Start daemon processes ..."
  sudo service php-fpm start
  sudo service nginx start
  echo ''
fi

exec "$@"
