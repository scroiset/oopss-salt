
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

/etc/bash.bashrc:
    file.managed:
        - source: salt://utils/bash/bash.bashrc
        - mode: 644
        - user: root
        - group: root

