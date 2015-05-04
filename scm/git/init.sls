
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

git:
    pkg.installed

/etc/gitconfig:
    file.managed:
        - source: salt://oopss-infra/scm/git/gitconfig
        - mode: 444
        - user: root
        - group: root

