
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_userslock:
    file.managed:
        - names:
            - /usr/bin/chfn
            - /usr/bin/chsh
            - /usr/bin/passwd
        - mode: 0755
        - replace: False

