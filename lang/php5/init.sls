
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

php5-pkg:
    pkg:
        - installed
        - names:
            - php5-cli
            - php5-mysql
            - php5-gd

