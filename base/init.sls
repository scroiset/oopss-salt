
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.base.apt-listchanges
    - oopss.base.bash
    - oopss.base.git
    - oopss.base.hosts
    - oopss.base.locales
    - oopss.base.motd
    - oopss.base.timezone
    - oopss.base.users
    - oopss.base.userslock
    - oopss.base.vim

oopss_base_pkg:
    pkg:
        - installed
        - names:
            - bzip2
            - curl
            - dos2unix
            - elinks
            - fetchmail
            - heirloom-mailx
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

