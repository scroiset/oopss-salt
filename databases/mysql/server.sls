
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.databases.mysql

mysql-server:
    pkg.installed

mysql-pkg:
    pkg:
        - installed
        - names:
            - python-mysqldb
            - mytop
            - mysqltuner
            - percona-toolkit

mysql:
    service:
        - running
        - require:
            - pkg: mysql-server

/etc/mysql/conf.d/local.cnf:
    file.managed:
        - source: salt://oopss-infra/databases/mysql/local.cnf
        - user: root
        - group: adm
        - mode: 440

/root/.my.cnf:
    file.symlink:
        - target: /etc/mysql/debian.cnf
        - require:
            - pkg: mysql-server

mysql-clean:
    cmd.wait:
        - names:
            - mysql -e "delete from user where user = '' or user = 'root'; flush privileges;" mysql
            - mysql -e "delete from db where user = ''; flush privileges; drop database test;" mysql
        - watch:
            - pkg: mysql-server


##############################################################################
# Read pillar databases:mysql:users then create users and databases
##############################################################################

{% for user, password in salt['pillar.get']('databases:mysql:users').iteritems() %}
mysql-user-{{ user }}:
    mysql_user:
        - present
        - name: {{ user }}
        - host: localhost
        - password_hash: '{{ password }}'
        - require:
            - pkg: mysql-server
            - pkg: python-mysqldb

mysql-db-{{ user }}:
    mysql_database:
        - present
        - name: {{ user }}
        - require:
            - mysql_user: mysql-user-{{ user }}

mysql-grant-{{ user }}:
    mysql_grants:
        - present
        - grant: all privileges
        - database : {{ user }}.*
        - user : {{ user }}
        - host: localhost
        - require:
            - mysql_database: mysql-db-{{ user }}
{% endfor %}

