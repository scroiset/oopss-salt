
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

{% for user, password in salt['pillar.get']('oopss:mysql:users', {}).iteritems() %}
oopss_mysql_users_{{ user }}:
    mysql_user:
        - present
        - name: {{ user }}
        - host: localhost
        - password_hash: '{{ password }}'
        - require:
            - pkg: oopss_mysql_server_pkg

oopss_mysql_users_db_{{ user }}:
    mysql_database:
        - present
        - name: {{ user }}
        - require:
            - mysql_user: oopss_mysql_users_{{ user }}

oopss_mysql_users_grant_{{ user }}:
    mysql_grants:
        - present
        - grant: all privileges
        - database : {{ user }}.*
        - user : {{ user }}
        - host: localhost
        - require:
            - mysql_database: oopss_mysql_users_db_{{ user }}
{% endfor %}
