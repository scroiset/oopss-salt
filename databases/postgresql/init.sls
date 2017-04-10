
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

{% from "oopss/databases/postgresql/map.jinja" import postgresql with context %}
postgresql-client-{{ postgresql.version }}:
    pkg.installed

postgresql-server-dev-{{ postgresql.version }}:
    pkg.installed

