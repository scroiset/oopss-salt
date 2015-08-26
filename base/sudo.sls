
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_sudo_localconf:
    file:
        - managed
        - name: /etc/sudoers.d/local
        - source: salt://oopss/base/files/sudo
        - template: jinja
        - user: root
        - group: root
        - mode: 440

