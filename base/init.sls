
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.base.apt-listchanges
    - oopss.base.locales
    - oopss.base.motd
    - oopss.base.timezone
    - oopss.base.users
    - oopss.base.userslock

oopss_base_pkg:
    pkg:
        - installed
        - names:
            - curl
            - dos2unix
            - elinks
            - fetchmail
            - lftp
            - man-db
            - manpages
            - multitail
            - mutt
            - netcat
            - openssh-client
            - screen
            - socat
            - unrar-free
            - unzip
            - wget

{% if salt['pillar.get']('oopss:base:pkg', False) %}
oopss_base_pkg_custom:
    pkg:
        - installed
        - names:
        {% for pkg in salt['pillar.get']('oopss:base:pkg') %}
            - {{ pkg }}
        {% endfor %}
{% endif %}

