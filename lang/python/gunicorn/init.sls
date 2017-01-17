
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

gunicorn:
    pkg:
        - installed

    service:
        - running
        - require:
            - pkg: gunicorn

/etc/gunicorn.d/django.example:
    file.absent

/etc/gunicorn.d/wsgi.example:
    file.absent

/usr/local/bin/gunicorn-restart:
    file.managed:
        - mode: 755
        - user: root
        - group: root
        - source: salt://oopss/lang/python/gunicorn/gunicorn-restart

{% for user, userinfo in salt['pillar.get']('http:users', {}).iteritems() %}
{% set user_is_active = userinfo.get('is_active', True) %}

{% if user_is_active %}

{{ salt['pillar.get']('http:basedir') }}/{{ user }}/.gunicorn:
    file.directory:
        - mode: 700
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}

{{ salt['pillar.get']('http:basedir') }}/{{ user }}/.wsgi:
    file.directory:
        - mode: 700
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - file: {{ salt['pillar.get']('http:basedir') }}/{{ user }}

{% endif %} {# user_is_active #}

{% for root_path, root_pathinfo in userinfo.get('root_paths', {}).iteritems() %}
{% if 'gunicorn' == root_pathinfo.get('type', '') %}
/etc/gunicorn.d/{{ user }}-{{ root_path }}:
    file:
        {%- if user_is_active and root_pathinfo.get('is_active', True) %}
        - managed
        - user: root
        - group: adm
        - mode: 440
        - source: salt://oopss/lang/python/gunicorn/config
        - template: jinja
        - context:
            user: {{ user }}
            root_path: {{ root_path }}
        - require:
            - pkg: gunicorn
        {%- else %}
        - absent
        {%- endif %}
        - watch_in:
            - service: gunicorn

{% endif %}
{% endfor %}
{% endfor %}

