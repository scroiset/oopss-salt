
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

oopss_iptables_script:
    file:
        - managed
        - name: /etc/network/if-pre-up.d/iptables
        - source: salt://oopss/iptables/files/iptables
        - mode: 755
        - user: root
        - group: root

