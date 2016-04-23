
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss.git

{% set git_rootdir = salt['pillar.get']('oopss:git:rootdir', '/srv/git') %}
{% set user_lookup_pillar = salt['pillar.get']('oopss:git:user_lookup_pillar', False) %}

oopss_git_server_rootdir:
    file:
        - directory
        - name: {{ git_rootdir }}
        - mode: 755
        - user: root
        - group: root
        - makedirs: True

{% for git_project, git_projectinfo in salt['pillar.get']('oopss:git:projects', {}).iteritems() %}
oopss_git_server_group_{{ git_project }}:
    group:
        - present
        - name: {{ git_project }}
        - gid: {{ git_projectinfo['uid'] }}

oopss_git_server_user_{{ git_project }}:
    user:
        - present
        - name: {{ git_project }}
        - uid: {{ git_projectinfo['uid'] }}
        - gid: {{ git_projectinfo['uid'] }}
        - home: "{{ git_rootdir }}/{{ git_project }}"
        - createhome: False
        - shell: "/usr/bin/git-shell"
        - groups:
            - sshusers
        - require:
            - group: oopss_git_server_group_{{ git_project }}

oopss_git_server_dir_{{ git_project }}:
    file:
        - directory
        - name: {{ git_rootdir }}/{{ git_project }}
        - mode: 700
        - user: {{ git_project }}
        - group: {{ git_project }}
        - makedirs: True
        - require:
            - user: oopss_git_server_user_{{ git_project }}

{% for repo in git_projectinfo['repos'] %}
oopss_git_server_repo_{{ repo }}:
    git:
        - present
        - name: {{ git_rootdir }}/{{ git_project }}/{{ repo }}.git
        - runas: {{ git_project }}
        - require:
            - file: oopss_git_server_dir_{{ git_project }}
{% endfor %}

# Add keys for authorized users
{% if git_projectinfo['allowed_users'] is defined %}
oopss_git_server_ssh_auth_{{ git_project }}:
    ssh_auth:
        - present
        - user: {{ git_project }}
        - names:
{% for user in git_projectinfo['allowed_users'] %}
{% for ssh_key in salt['pillar.get'](user_lookup_pillar+':'+user+':ssh_auth', []) %}
            - {{ ssh_key }}
{% endfor %}
{% endfor %}
        - require:
            - file: oopss_git_server_dir_{{ git_project }}
{% endif %}

# Generate SSH key if ssh_keygen is defined for this user
{% if git_projectinfo.get('ssh_keygen', False) %}
oopss_git_server_ssh_keygen_{{ git_project }}:
    cmd.run:
        - name: 'ssh-keygen -N "" -f $HOME/.ssh/id_rsa'
        - user: {{ git_project }}
        - unless: 'test -f $HOME/.ssh/id_rsa'
        - require:
            - user: oopss_git_server_user_{{ git_project }}
            - file: oopss_git_server_dir_{{ git_project }}
{% endif %}

{% endfor %}

