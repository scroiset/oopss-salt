
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

bash-completion:
    pkg.installed

/etc/bash.bashrc:
    file.managed:
        - source: salt://oopss-infra/utils/bash/bash.bashrc
        - mode: 444
        - user: root
        - group: root

/root/.bashrc:
    file.managed:
        - source: salt://oopss-infra/utils/bash/root.bashrc
        - mode: 444
        - user: root
        - group: root

