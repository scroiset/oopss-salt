
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

bash-completion:
    pkg.installed

/root/.bashrc:
    file.managed:
        - source: salt://utils/bash/root.bashrc
        - mode: 644
        - user: root
        - group: root
        - backup: minion

