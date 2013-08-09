
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
        - shell: "/bin/bash"
        - fullname: {{ pillar['users'][user]['fullname'] }}
        {% if pillar['users'][user]['sudoer'] == True %}
        - groups:
            - sudo
        {% endif %}
{% endfor %}

