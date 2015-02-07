
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_vim_pkg:
    pkg:
        - name: vim
        - installed

oopss_base_vim_config:
    file:
        - name: /etc/vim/vimrc.local
        - managed
        - source: salt://oopss/base/files/vimrc
        - mode: 444
        - user: root
        - group: root

