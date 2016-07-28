
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.lang.php5

php5-fpm:
    pkg:
        - installed

    service:
        - running
        - require:
            - pkg: php5-fpm
        - watch:
            - file: /etc/php5/fpm/conf.d/local.ini
            - file: /etc/php5/fpm/pool.d/www.conf
            - file: /etc/default/php5-fpm

/etc/php5/fpm/conf.d/local.ini:
    file.managed:
        - source: salt://oopss/lang/php5/fpm/local.ini
        - user: root
        - group: root
        - mode: 400

/etc/php5/fpm/pool.d/www.conf:
    file.absent

/etc/default/php5-fpm:
    file.managed:
        - source: salt://oopss/lang/php5/fpm/init_default
        - user: root
        - group: root
        - mode: 400

{% for user, userinfo in salt['pillar.get']('http:users', {}).iteritems() %}
{% for root_path, root_pathinfo in userinfo.get('root_paths', {}).iteritems() %}
{% if 'php' == root_pathinfo.get('type', '') or 'php_redirect_to_index' == root_pathinfo.get('type', '') %}
/etc/php5/fpm/pool.d/{{ user }}-{{ root_path }}.conf:
    file.managed:
        - user: root
        - group: adm
        - mode: 440
        - source: salt://oopss/lang/php5/fpm/config
        - template: jinja
        - context:
            user: {{ user }}
            root_path: {{ root_path }}
            max_children: {{ salt['pillar.get']('lang:php5:fpm:max_children', '10') }}
        - require:
            - pkg: php5-fpm
        - watch_in:
            - service: php5-fpm
{% endif %}
{% endfor %}
{% endfor %}

