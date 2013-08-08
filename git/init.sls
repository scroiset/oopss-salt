
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

git:
    pkg.installed

/etc/gitconfig:
    file.managed:
        - source: salt://git/gitconfig
        - mode: 644
        - user: root
        - group: root

