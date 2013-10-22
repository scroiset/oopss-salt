
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

include:
    - oopss-infra.http.clients
    - oopss-infra.scm.git
    - oopss-infra.utils.bash
    - oopss-infra.utils.screen
    - oopss-infra.utils.vim
    - oopss-infra.utils.man

