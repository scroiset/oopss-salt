
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

include:
    - git

{{ pillar['git_root'] }}/:
    file.directory:
        - mode: 755
        - user: root
        - group: root
        - makedirs: True

{% for git_project, git_projectinfo in pillar['git_projects'].iteritems() %}
{{ git_project }}:
    group.present:
        - gid: {{ git_projectinfo['uid'] }}

    user.present:
        - uid: {{ git_projectinfo['uid'] }}
        - gid: {{ git_projectinfo['uid'] }}
        - home: "{{ pillar['git_root'] }}/{{ git_project }}"
        - createhome: False
        - shell: "/usr/bin/git-shell"
        - groups:
            - sshusers
        - require:
            - group: {{ git_project }}
            - group: sshusers

    # Add keys for authorized users
    ssh_auth:
        - present
        - user: {{ git_project }}
        - names:
{% for user in git_projectinfo['allowed_users'] %}
{% for ssh_key in pillar['users'][user]['ssh_auth'] %}
            - {{ ssh_key }}
{% endfor %}
{% endfor %}
        - require:
            - file: {{ pillar['git_root'] }}/{{ git_project }}

{{ pillar['git_root'] }}/{{ git_project }}:
    file.directory:
        - mode: 700
        - user: {{ git_project }}
        - group: {{ git_project }}
        - makedirs: True
        - require:
            - user: {{ git_project }}

# Generate SSH key if ssh_keygen is defined for this user
{% if git_projectinfo['ssh_keygen'] %}
ssh_keygen_{{ git_project }}:
    cmd.run:
        - name: 'ssh-keygen -N "" -f $HOME/.ssh/id_rsa'
        - user: {{ git_project }}
        - unless: 'test -f $HOME/.ssh/id_rsa'
        - require:
            - user: {{ git_project }}
            - file: {{ pillar['git_root'] }}/{{ git_project }}
{% endif %}

{% for repo in git_projectinfo['repos'] %}
{{ pillar['git_root'] }}/{{ git_project }}/{{ repo }}.git:
    git.present:
        - runas: {{ git_project }}
        - require:
            - file: {{ pillar['git_root'] }}/{{ git_project }}
{% endfor %}
{% endfor %}

