
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.mysql

oopss_mysql_server_pkg:
    pkg:
        - installed
        - names:
            - mysql-server
            - python-mysqldb
            - mytop
            - mysqltuner
            - percona-toolkit

oopss_mysql_server_service:
    service:
        - name: mysql
        - running
        - require:
            - pkg: oopss_mysql_server_pkg

oopss_mysql_server_config_base:
    file:
        - managed
        - name: /etc/mysql/conf.d/local.cnf
        - source: salt://oopss/mysql/files/local.cnf
        - user: root
        - group: adm
        - mode: 440

oopss_mysql_server_rootconfig:
    file:
        - symlink
        - name: /root/.my.cnf
        - target: /etc/mysql/debian.cnf
        - require:
            - pkg: oopss_mysql_server_pkg

oopss_mysql_server_cleancmd:
    cmd:
        - wait
        - names:
            - mysql -e "delete from user where user = '' or user = 'root'; flush privileges;" mysql
        - watch:
            - pkg: oopss_mysql_server_pkg

oopss_mysql_server_dumpscript:
    {% if salt['pillar.get']('oopss:mysql:daily_dump') %}
    file:
        - managed
        - name: /etc/cron.daily/dump_mysql
        - source: salt://oopss/mysql/files/dump_mysql
        - user: root
        - group: root
        - mode: 700
    {% else %}
    file:
        - absent
        - name: /etc/cron.daily/dump_mysql
    {% endif %}

