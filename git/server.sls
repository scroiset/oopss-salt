
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

{% for git_project in pillar['git_projects'] %}
{{ git_project }}:
    group.present:
        - gid: {{ pillar['git_projects'][git_project]['uid'] }}

    user.present:
        - uid: {{ pillar['git_projects'][git_project]['uid'] }}
        - gid: {{ pillar['git_projects'][git_project]['uid'] }}
        - home: "/srv/git/{{ git_project }}"
        - createhome: False
        - shell: "/usr/bin/git-shell"

{% for user in pillar['git_projects'][git_project]['allowed_users'] %}
    ssh_auth:
        - present
        - user: {{ git_project }}
        - names: {{ pillar['users'][user]['ssh_auth'] }}
{% endfor %}

/srv/git/{{ git_project }}:
    file.directory:
        - mode: 700
        - user: {{ git_project }}
        - group: {{ git_project }}
        - makedirs: True
{% endfor %}
