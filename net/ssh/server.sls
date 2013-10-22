
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

include:
    - oopss-infra.net.ssh

openssh-server:
    pkg:
        - installed

ssh:
    service:
        - running
        - require:
            - pkg: openssh-server
        - watch:
            - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
    file.managed:
        - source: salt://oopss-infra/net/ssh/sshd_config
        - mode: 440
        - user: root
        - group: adm
        - template: jinja
        - require:
            - pkg: openssh-server
        - backup: minion

