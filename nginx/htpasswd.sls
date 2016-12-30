
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

oopss_nginx_htpasswd_file:
    file:
        - managed
        - name: /etc/nginx/htpasswd
        - source: salt://oopss/nginx/files/htpasswd
        - template: jinja
        - user: root
        - group: www-data
        - mode: 440

