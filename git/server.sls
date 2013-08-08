
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

