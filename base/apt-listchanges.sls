
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_apt-listchanges_pkg:
    pkg:
        - name: apt-listchanges
        - installed

oopss_base_apt-listchanges_config:
    file.managed:
        - name: /etc/apt/listchanges.conf
        - source: salt://oopss/base/files/listchanges.conf
        - user: root
        - group: adm
        - mode: 440

