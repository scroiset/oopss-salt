
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
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
            - file: /etc/postfix/sasl_password
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
        - source: salt://oopss/mail/postfix/files/main.cf
        - template: jinja
        - mode: 444
        - user: root
        - group: root
        - require:
            - pkg: postfix

/etc/mailname:
    file.managed:
        - contents: {{ grains['fqdn'] }}

oopss_postfix_aliases:
    alias:
        - name: root
        {% if salt['pillar.get']('oopss:postfix:root_alias', False) %}
        - present
        - target: "{{ salt['pillar.get']('oopss:postfix:root_alias') }}, root"
        {% else %}
        - absent
        {% endif %}

/etc/postfix/transport:
    file.managed:
        - source: salt://oopss/mail/postfix/files/transport
        - template: jinja
        - mode: 400
        - user: root
        - group: root

postmap-transport:
    cmd:
        - run
        - name: "postmap /etc/postfix/transport"
        - onchanges:
            - file: /etc/postfix/transport

/etc/postfix/sasl_password:
    file.managed:
        - source: salt://oopss/mail/postfix/files/sasl_password
        - template: jinja
        - mode: 400
        - user: root
        - group: root

postmap-sasl_password:
    cmd:
        - run
        - name: "postmap /etc/postfix/sasl_password"
        - onchanges:
            - file: /etc/postfix/sasl_password

/etc/postfix/header_checks:
    file.managed:
        - mode: 640
        - user: root
        - group: adm

