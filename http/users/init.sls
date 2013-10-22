
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

#############################################################################
# Create base directory for websites
#############################################################################

/srv/www:
    file.directory:
        - user: root
        - group: root
        - mode: 711

#############################################################################
# For each user in pillar http:users
# - Ensure UNIX user is present with a dedicated group
# - Ensure base directory exists with log and .sock directories
# - Ensure each defined root_paths has a directory
#############################################################################

{% if salt['pillar.get']('http:users') is defined %}
{% for user, userinfo in salt['pillar.get']('http:users').iteritems() %}
{{ user }}:
    group.present:
        - gid: {{ userinfo['uid'] }}

    user.present:
        - uid: {{ userinfo['uid'] }}
        - gid: {{ userinfo['uid'] }}
        - home: "/srv/www/{{ user }}"
        - createhome: False
        - shell: "/bin/bash"
        - fullname: ""
        - groups:
            - sshusers
        - require:
            - group: {{ user }}

/srv/www/{{ user }}:
    file.directory:
        - mode: 710
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - user: {{ user }}

/srv/www/{{ user }}/.sock:
    file.directory:
        - mode: 710
        - user: {{ user }}
        - group: {{ user }}
        - require:
            - file: /srv/www/{{ user }}

/srv/www/{{ user }}/log:
    file.directory:
        - mode: 710
        - user: {{ user }}
        - group: www-data
        - require:
            - user: {{ user }}
            - file: /srv/www/{{ user }}

{% if userinfo['root_paths'] is defined %}
{% for root_path in userinfo['root_paths'] %}
/srv/www/{{ user }}/{{ root_path }}:
    file.directory:
        - user: {{ user }}
        - group: {{ user }}
        - mode: 750
        - require:
            - file: /srv/www/{{ user }}

/srv/www/{{ user }}/log/{{ root_path }}-access.log:
    file.managed:
        - mode: 660
        - user: {{ user }}
        - group: www-data
        - require:
            - user: {{ user }}
            - file: /srv/www/{{ user }}/log

/srv/www/{{ user }}/log/{{ root_path }}-error.log:
    file.managed:
        - mode: 660
        - user: {{ user }}
        - group: www-data
        - require:
            - user: {{ user }}
            - file: /srv/www/{{ user }}/log
{% endfor %}
{% endif %}
{% endfor %}
{% endif %}

#############################################################################
# Add www-data system user in each user group, so it can access static files
#############################################################################

www-data:
    user.present:
        - groups:
            - www-data
{% if salt['pillar.get']('http:users') is defined %}
{% for user, userinfo in salt['pillar.get']('http:users').iteritems() %}
            - {{ user }}
{% endfor %}
{% endif %}

