
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
        - shell: "/usr/bin/git-shell"
{% endfor %}

