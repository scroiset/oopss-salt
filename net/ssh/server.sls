
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.net.ssh

openssh-server:
    pkg:
        - installed

ssh:
    service:
        - running
        - reload: True
        - require:
            - pkg: openssh-server
        - watch:
            - file: /etc/ssh/sshd_config
            - file: /etc/init.d/ssh

/etc/ssh/sshd_config:
    file.managed:
        - source: salt://oopss-infra/net/ssh/sshd_config
        - mode: 440
        - user: root
        - group: adm
        - template: jinja
        - require:
            - pkg: openssh-server

/etc/init.d/ssh:
    file.sed:
        - before: 'umask .*'
        - after: 'umask 027'
        - limit: '^umask .*'
        - require:
            - pkg: openssh-server

