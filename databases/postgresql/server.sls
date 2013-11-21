
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.databases.postgresql

postgresql-9.1:
    pkg.installed

postgresql:
    service:
        - running
        - reload: True
        - require:
            - pkg: postgresql-9.1
        - watch:
            - file: /etc/postgresql/9.1/main/pg_hba.conf

/etc/postgresql/9.1/main/pg_hba.conf:
    file.managed:
        - user: postgres
        - group: adm
        - mode: 440
        - source: salt://oopss-infra/databases/postgresql/pg_hba.conf
        - require:
            - pkg: postgresql-9.1


##############################################################################
# Read pillar databases:postgresql:users then create users and databases
##############################################################################

{% for user in salt['pillar.get']('databases:postgresql:users', '') %}
postgresql-user-{{ user }}:
    postgres_user:
        - present
        - name: {{ user }}
        - require:
            - pkg: postgresql-9.1

postgresql-db-{{ user }}:
    postgres_database:
        - present
        - name: {{ user }}
        - owner: {{ user }}
        - encoding: 'UTF-8'
        - require:
            - postgres_user: postgresql-user-{{ user }}
{% endfor %}

