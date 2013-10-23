
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.lang.php5

php5-fpm:
    pkg.installed

/etc/php5/fpm/pool.d/www.conf:
    file.absent

{% if salt['pillar.get']('http:users') is defined %}
{% for user, userinfo in salt['pillar.get']('http:users').iteritems() %}
{% for root_path, root_pathinfo in userinfo['root_paths'].iteritems() %}
{% if root_pathinfo['config_tags']['php_fastcgi'] is defined %}
/etc/php5/fpm/pool.d/{{ user }}-{{ root_path }}.conf:
    file.managed:
        - user: root
        - group: adm
        - mode: 440
        - source: salt://oopss-infra/lang/php5/fpm/config
        - template: jinja
        - context:
            user: {{ user }}
            root_path: {{ root_path }}
        - require:
            - pkg: php5-fpm
{% endif %}
{% endfor %}
{% endfor %}
{% endif %}

