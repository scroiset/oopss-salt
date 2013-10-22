
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

postfix:
    pkg:
        - installed

    service:
        - running
        - require:
            - pkg: postfix
        - watch:
            - file: /etc/postfix/main.cf

/etc/postfix/main.cf:
    file.managed:
        - source: salt://oopss-infra/mail/postfix/main.cf
        - template: jinja
        - mode: 440
        - user: root
        - group: adm
        - require:
            - pkg: postfix
        - backup: minion

/etc/mailname:
    file.managed:
        - contents: {{ grains['fqdn'] }}
        - backup: minion

/etc/aliases:
    file.sed:
        - before: 'root: .*'
        - after: 'root: {{ salt['pillar.get']('mail:postfix:admin_mail', 'root') }}'
        - limit: '^root: '
        - require:
            - pkg: postfix

newaliases:
    cmd.wait:
        - watch:
            - file: /etc/aliases

