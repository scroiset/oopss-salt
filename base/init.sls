
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.base.bash
    - oopss.base.hosts
    - oopss.base.locales
    - oopss.base.motd
    - oopss.base.resolv
    - oopss.base.rsyslog
    - oopss.base.sysutils
    - oopss.base.sudo
    - oopss.base.timezone
    - oopss.base.users
    - oopss.base.userslock
    - oopss.base.utils
    - oopss.base.vim

    {% if grains['os'] == 'Debian' %}
    - oopss.base.debian
    {% endif %}

