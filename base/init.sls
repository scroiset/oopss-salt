
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.base.bash
    - oopss.base.git
    - oopss.base.hosts
    - oopss.base.locales
    - oopss.base.motd
    - oopss.base.timezone
    - oopss.base.users
    - oopss.base.userslock
    - oopss.base.vim

    {% if grains['os'] == 'Debian' %}
    - oopss.base.debian
    {% endif %}

