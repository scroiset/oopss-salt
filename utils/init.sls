
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.scm.git
    - oopss-infra.utils.bash
    - oopss-infra.utils.vim

pkg_utils:
    pkg:
        - installed
        - names:
            - curl
            - dos2unix
            - elinks
            - fetchmail
            - lftp
            - man-db
            - manpages
            - multitail
            - mutt
            - netcat
            - screen
            - socat
            - unrar-free
            - unzip
            - wget

