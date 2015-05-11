
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_motd_file:
    file:
        - name: /etc/motd
        - managed
        - user: root
        - group: root
        - mode: 444
        # To define a multiline pillar value, add a pipe symbol (|) after the
        # pillar key, and put the content below, indented with two spaces
        # relatively to the pillar key.
        # Example :
        # pillar_key1:
        #     pillar_key2: |
        #       multiline
        #       pillar
        #       value
        # Warning : the first caracter of the pillar value ("m" in the
        # example) should NOT be a space caracter !
        - contents_pillar: oopss:base:motd

