
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

oopss_git_pkg:
    pkg:
        - installed
        - name: git

oopss_git_config:
    file:
        - managed
        - name: /etc/gitconfig
        - source: salt://oopss/git/files/gitconfig
        - mode: 444
        - user: root
        - group: root
        - require:
            - pkg: oopss_git_pkg

