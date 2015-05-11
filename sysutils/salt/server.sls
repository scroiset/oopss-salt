
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.scm.git

salt-master:
    pkg.installed

salt:
    user.present:
        - system: True
        - createhome: True
        - fullname: "Salt files' owner"
        - groups:
            - sshusers
        - require:
            - group: sshusers

salt_directories:
    file.directory:
        - names:
            - /srv/salt
            - /srv/pillar
        - mode: 750
        - owner: salt
        - group: salt
        - require:
            - user: salt

/etc/salt/master:
    file.managed:
        - user: root
        - group: adm
        - mode: 440
        - source: salt://oopss/sysutils/salt/master

