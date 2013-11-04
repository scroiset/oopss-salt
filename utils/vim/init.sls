
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

vim:
    pkg.installed

/etc/vim/vimrc.local:
    file.managed:
        - source: salt://oopss-infra/utils/vim/vimrc
        - mode: 444
        - user: root
        - group: root

