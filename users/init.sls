
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

{% for user in pillar['users'] %}
{{ user }}:
    group.present:
        - gid: {{ pillar['users'][user]['uid'] }}

    user.present:
        - uid: {{ pillar['users'][user]['uid'] }}
        - gid: {{ pillar['users'][user]['uid'] }}
        - home: "/home/{{ user }}"
        - createhome: False
        - shell: "/bin/bash"
        - fullname: {{ pillar['users'][user]['fullname'] }}
        {% if pillar['users'][user]['sudoer'] == True %}
        - groups:
            - sudo
        {% endif %}
        - require:
            - group: {{ user }}

    ssh_auth:
        - present
        - user: {{ user }}
        - names: {{ pillar['users'][user]['ssh_auth'] }}
        - require:
            - file: /home/{{ user }}

/home/{{ user }}:
    file.directory:
        - mode: 700
        - user: {{ user }}
        - group: {{ user }}
        - makedirs: True
        - require:
            - user: {{ user }}
{% endfor %}

