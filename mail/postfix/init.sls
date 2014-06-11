
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

postfix:
    pkg:
        - installed

    service:
        - running
        - reload: True
        - require:
            - pkg: postfix
            - file: /etc/postfix/header_checks
        - watch:
            - file: /etc/postfix/main.cf
            - file: /etc/postfix/transport
            - file: /etc/postfix/sasl_password

postfix-pcre:
    pkg:
        - installed

pfqueue:
    pkg:
        - installed

/etc/postfix/main.cf:
    file.managed:
        - source: salt://oopss-infra/mail/postfix/main.cf
        - template: jinja
        - mode: 444
        - user: root
        - group: root
        - require:
            - pkg: postfix

/etc/mailname:
    file.managed:
        - contents: {{ grains['fqdn'] }}

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

/etc/postfix/transport:
    file.managed:
        - source: salt://oopss-infra/mail/postfix/transport
        - template: jinja
        - mode: 400
        - user: root
        - group: root

postmap-transport:
    cmd.wait:
        - name: postmap /etc/postfix/transport
        - watch:
            - file: /etc/postfix/transport

/etc/postfix/sasl_password:
    file.managed:
        - source: salt://oopss-infra/mail/postfix/sasl_password
        - template: jinja
        - mode: 400
        - user: root
        - group: root

postmap-sasl_password:
    cmd.wait:
        - name: postmap /etc/postfix/sasl_password
        - watch:
            - file: /etc/postfix/sasl_password

/etc/postfix/header_checks:
    file.managed:
        - mode: 640
        - user: root
        - group: adm

