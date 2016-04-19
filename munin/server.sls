
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_munin_server_pkg:
    pkg:
        - installed
        - name: munin

oopss_munin_server_mainconf:
    file:
        - managed
        - name: /etc/munin/munin.conf
        - contents: 'includedir /etc/munin/munin-conf.d'
        - require:
            - pkg: oopss_munin_server_pkg

oopss_munin_server_conf:
    file:
        - managed
        - name: /etc/munin/munin-conf.d/munin.conf
        - source: salt://oopss/munin/files/munin.conf
        - template: jinja
        - user: root
        - group: root
        - mode: 444
        - require:
            - pkg: oopss_munin_server_pkg

