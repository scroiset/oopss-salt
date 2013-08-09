
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

include:
    - git

/srv/git/:
    file.directory:
        - mode: 755
        - user: root
        - group: root
        - makedirs: True

{% for user in pillar['git_projects'] %}
{{ user }}:
    group.present:
        - gid: {{ pillar['git_projects'][user]['uid'] }}

    user.present:
        - uid: {{ pillar['git_projects'][user]['uid'] }}
        - gid: {{ pillar['git_projects'][user]['uid'] }}
        - home: "/srv/git/{{ user }}"
        - shell: "/usr/bin/git-shell"
{% endfor %}

