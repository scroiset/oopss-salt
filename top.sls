
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>

base:
    '*':
        - utils.vim
        - git
        - utils.screen
        - utils.cron-apt
        - users

