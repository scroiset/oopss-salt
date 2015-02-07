
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_bash_pkg:
    pkg:
        - names:
            - bash
            - bash-completion
        - installed

oopss_base_bash_bashrc:
    file:
        - name: /etc/bash.bashrc
        - managed
        - source: salt://oopss/base/files/bash.bashrc
        - mode: 444
        - user: root
        - group: root

oopss_base_bash_rootbashrc:
    file:
        - name: /root/.bashrc
        - managed
        - source: salt://oopss/base/files/root.bashrc
        - mode: 444
        - user: root
        - group: root

