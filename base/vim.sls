
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
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

oopss_base_vim_alternatives:
    cmd:
        - run
        - names:
            - "update-alternatives --set vi /usr/bin/vim.basic"
            - "update-alternatives --set editor /usr/bin/vim.basic"
        - onchanges:
            - pkg: oopss_base_vim_pkg

