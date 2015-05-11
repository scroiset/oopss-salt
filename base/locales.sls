
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2015 Oopss.org <team@oopss.org>
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

# If oopss:base:locales:default is defined, then apply this locale as default.
# If not, remove the /etc/default/locale so no preferred locale is defined.
oopss_base_locales_default:
    file:
        - name: /etc/default/locale
{% if salt['pillar.get']('oopss:base:locales:default', False) %}
        - managed
        - source: salt://oopss/base/files/default_locale
        - template: jinja
        - user: root
        - group: root
        - mode: 644
        - context:
            locale: {{ salt['pillar.get']('oopss:base:locales:default') }}
{% else %}
        - absent
{% endif %}

