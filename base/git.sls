
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_git_pkg:
    pkg:
        - name: git
        - installed

oopss_base_git_config:
    file:
        - name: /etc/gitconfig
        - managed
        - source: salt://oopss/base/files/gitconfig
        - mode: 444
        - user: root
        - group: root

