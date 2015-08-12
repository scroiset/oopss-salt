
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

modoboa_pkg:
    pkg:
        - installed
        - names:
            - python-pip
            - python-dev
            - libxml2-dev
            - libxslt1-dev
