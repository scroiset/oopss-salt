
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_resolv_file:
    file:
        - name: /etc/resolv.conf
        - managed
        - source: salt://oopss/base/files/resolv.conf
        - template: jinja
        - user: root
        - group: root
        - mode: 644

