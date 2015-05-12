
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.ssh

oopss_ssh_server_pkg:
    pkg:
        - name: openssh-server
        - installed

oopss_ssh_server_config:
    file.managed:
        - name: /etc/ssh/sshd_config
        - source: salt://oopss/ssh/files/sshd_config
        - mode: 440
        - user: root
        - group: adm
        - template: jinja
        - require:
            - pkg: oopss_ssh_server_pkg

oopss_ssh_server_initscript:
    file.sed:
        - name: /etc/init.d/ssh
        - before: 'umask .*'
        - after: 'umask 027'
        - limit: '^umask .*'
        - require:
            - pkg: oopss_ssh_server_pkg

oopss_ssh_server_service:
    service:
        - name: ssh
        - running
        - require:
            - pkg: oopss_ssh_server_pkg
        - watch:
            - file: oopss_ssh_server_config
            - file: oopss_ssh_server_initscript

