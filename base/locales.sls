
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_base_locales_pkg:
    pkg:
        - name: locales
        - installed

oopss_base_locales_genfile:
    file:
        - name: /etc/locale.gen
        - managed
        - source: salt://oopss/base/files/locale.gen
        - mode: 444
        - user: root
        - group: root
        - require:
            - pkg: oopss_base_locales_pkg

# Run locale-gen(8) if /etc/locale.gen changes
oopss_base_locales_gencmd:
    cmd.wait:
        - name: locale-gen
        - watch:
            - file: oopss_base_locales_genfile

