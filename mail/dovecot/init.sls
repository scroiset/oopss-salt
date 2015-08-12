
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

dovecot_pkg:
    pkg:
        - installed
        - names:
            - dovecot-imapd
            - dovecot-pop3d
            - dovecot-pgsql
            - dovecot-lmtpd

dovecot_service:
    service:
        - name: dovecot
        - running
        - reload: True
        - watch:
            - file: dovecot_conf_mail

dovecot_conf_mail:
    file.managed:
        - name: /etc/dovecot/conf.d/10-mail.conf
        - source: salt://oopss/mail/dovecot/files/10-mail.conf
        - user: root
        - group: adm
        - mode: 440

dovecot_conf_auth:
    file.managed:
        - name: /etc/dovecot/conf.d/10-auth.conf
        - source: salt://oopss/mail/dovecot/files/10-auth.conf
        - user: root
        - group: adm
        - mode: 440

dovecot_conf_sql:
    file.managed:
        - name: /etc/dovecot/dovecot-sql.conf.ext
        - source: salt://oopss/mail/dovecot/files/dovecot-sql.conf.ext
        - template: jinja
        - user: root
        - group: adm
        - mode: 440
        - context:
            mail_root: {{ salt['pillar.get']('mail:dovecot:mail_root', '') }}

dovecot_conf_master:
    file.managed:
        - name: /etc/dovecot/conf.d/10-master.conf
        - source: salt://oopss/mail/dovecot/files/10-master.conf
        - user: root
        - group: adm
        - mode: 440

