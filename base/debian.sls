
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_debian_apt-listchanges_pkg:
    pkg:
        - name: apt-listchanges
        - installed

oopss_base_debian_apt-listchanges_config:
    file.managed:
        - name: /etc/apt/listchanges.conf
        - source: salt://oopss/base/files/listchanges.conf
        - user: root
        - group: adm
        - mode: 440

oopss_base_debian_unattended_pkg:
    pkg:
        - name: unattended-upgrades
        - installed

oopss_base_debian_unattended_config:
    file:
        - managed
        - name: /etc/apt/apt.conf.d/50unattended-upgrades
        - source: salt://oopss/base/files/50unattended-upgrades
        - template: jinja
        - user: root
        - group: root
        - mode: 444

