
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_utils_pkg:
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

{% if salt['pillar.get']('oopss:base:utils:pkg', False) %}
oopss_base_utils_pkg_custom:
    pkg:
        - installed
        - names:
        {% for pkg in salt['pillar.get']('oopss:base:utils:pkg') %}
            - {{ pkg }}
        {% endfor %}
{% endif %}
