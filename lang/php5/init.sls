
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

php5-pkg:
    pkg:
        - installed
        - names:
            - php5-cli
            - php5-curl
            - php5-mysql
            - php5-pgsql
            - php5-gd
            - php5-intl
            - php5-mcrypt

