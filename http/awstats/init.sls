
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

{% from "oopss-infra/http/map.jinja" import http_config with context %}

# Package
awstats:
    pkg.installed

# Awstats global config
/etc/awstats/awstats.conf.local:
    file.managed:
        - source: salt://oopss-infra/http/awstats/awstats.conf.local
        - mode: 440
        - user: root
        - group: adm

# Remove awstats standard cron.
# Update is triggered by logrotate.
/etc/cron.d/awstats:
    file.absent:
        - require:
            - pkg: awstats

# Build Awstats static files after logrotate.
/etc/cron.daily/z_awstats_buildstatic:
    file.managed:
        - source: salt://oopss-infra/http/awstats/z_awstats_buildstatic
        - mode: 700
        - user: root
        - group: root
        - require:
            - pkg: awstats

# For each user in pillar http:users
{% for user, userinfo in salt['pillar.get']('http:users', {}).iteritems() %}
{% if userinfo['root_paths'] is defined %}

# Awstats root for each user
{{ http_config['rootdir'] }}/{{ user }}/awstats:
    file.directory:
        - mode: 750
        - user: root
        - group: {{ user }}
        - require:
            - user: {{ user }}
            - file: {{ http_config['rootdir'] }}/{{ user }}

{% for root_path, root_pathinfo in userinfo.get('root_paths', {}).iteritems() %}

# Awstats config file for each user
/etc/awstats/awstats.{{ user }}-{{ root_path }}.conf:
    file.managed:
        - source: salt://oopss-infra/http/awstats/config
        - template: jinja
        - context:
            user: {{ user }}
            root_path: {{ root_path }}
            server_name: {{ root_pathinfo['server_names'][0] }}
        - mode: 440
        - user: root
        - group: adm

# Awstats dir for each root path
{{ http_config['rootdir'] }}/{{ user }}/awstats/{{ root_path }}:
    file.directory:
        - mode: 750
        - user: root
        - group: {{ user }}
        - require:
            - file: {{ http_config['rootdir'] }}/{{ user }}/awstats

# Awstats HTML dir
/var/cache/awstats/{{ user }}-{{ root_path }}:
    file.directory:
        - mode: 750
        - user: root
        - group: www-data

{% endfor %}
{% endif %}
{% endfor %}

