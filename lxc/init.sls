
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

oopss_lxc_pkg:
    pkg:
        - installed
        - names:
            # If changed, please update lxc-debootstrap README file
            - bridge-utils
            - debootstrap
            - libcap2-bin
            - libpam-cap
            - lsb-release
            - lxc
