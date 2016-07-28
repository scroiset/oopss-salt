
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.ssh

oopss_ssh_server_pkg:
    pkg:
        - name: openssh-server
        - installed

oopss_ssh_server_config:
    file:
        - managed
        - name: /etc/ssh/sshd_config
        - source: salt://oopss/ssh/files/sshd_config.{{ grains['oscodename'] }}
        - mode: 440
        - user: root
        - group: adm
        - template: jinja
        - require:
            - pkg: oopss_ssh_server_pkg

# Restrict umask for logged-in users.
{% if grains['os'] == 'Debian' and grains['osrelease_info'][0] < 8 %}
oopss_ssh_server_initscript:
    file.sed:
        - name: /etc/init.d/ssh
        - before: 'umask .*'
        - after: 'umask 027'
        - limit: '^umask .*'
        - require:
            - pkg: oopss_ssh_server_pkg
        - watch_in:
            - service: oopss_ssh_server_service
{% elif grains['os'] == 'Debian' and grains['osrelease_info'][0] >= 8 %}
oopss_ssh_server_systemd_unit:
    file.managed:
        - name: /etc/systemd/system/ssh.service.d/umask.conf
        - source: salt://oopss/ssh/files/systemd_umask.conf
        - makedirs: True
        - user: root
        - group: adm
        - mode: 440
        - require:
            - pkg: oopss_ssh_server_pkg
        - watch_in:
            - service: oopss_ssh_server_service
{% endif %}

oopss_ssh_server_service:
    service:
        - name: ssh
        - running
        - require:
            - pkg: oopss_ssh_server_pkg
        - watch:
            - file: oopss_ssh_server_config

