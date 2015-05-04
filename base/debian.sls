
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_debian_sourceslist:
    file:
        - name: /etc/apt/sources.list
        - managed
        - source: salt://oopss/base/files/sources.list
        - template: jinja
        - user: root
        - group: root
        - mode: 444

oopss_base_debian_update:
    cmd:
        - run
        - name: "apt-get update"
        - onchanges:
            - file: oopss_base_debian_sourceslist

