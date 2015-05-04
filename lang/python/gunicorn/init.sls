
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2015 Oopss.org <team@oopss.org>
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
        - source: salt://oopss-infra/lang/python/gunicorn/gunicorn-restart

{% for user, userinfo in salt['pillar.get']('http:users', {}).iteritems() %}

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

{% for root_path, root_pathinfo in userinfo.get('root_paths', {}).iteritems() %}
{% if 'gunicorn' == root_pathinfo.get('type', '') %}
/etc/gunicorn.d/{{ user }}-{{ root_path }}:
    file.managed:
        - user: root
        - group: adm
        - mode: 440
        - source: salt://oopss-infra/lang/python/gunicorn/config
        - template: jinja
        - context:
            user: {{ user }}
            root_path: {{ root_path }}
        - require:
            - pkg: gunicorn
        - watch_in:
            - service: gunicorn

{% endif %}
{% endfor %}
{% endfor %}

