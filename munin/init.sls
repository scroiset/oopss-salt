
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013-2014 Oopss.org <team@oopss.org>
##############################################################################

oopss_munin_pkg:
    pkg:
        - installed
        - names:
            - munin-node
            - libdbd-pg-perl

oopss_munin_service:
    service:
        - running
        - name: munin-node
        - enable: True

oopss_munin_conf:
    file:
        - managed
        - name: /etc/munin/munin-node.conf
        - source: salt://oopss/munin/files/munin-node.conf
        - template: jinja
        - user: root
        - group: root
        - mode: 400
        - watch_in:
            service: oopss_munin_service
        - require:
            - pkg: oopss_munin_pkg

{% for plugin, arg_list in salt['pillar.get']('oopss:munin:plugins', {}).iteritems() %}
{% if arg_list is sequence %}
{% for arg in arg_list %}
oopss_munin_plugin_{{ plugin }}_{{ arg }}:
    file:
        - symlink
        - name: /etc/munin/plugins/{{ plugin+arg }}
        - target: /usr/share/munin/plugins/{{ plugin }}
        - require:
            - pkg: oopss_munin_pkg
        - watch_in:
            - service: oopss_munin_service
{% endfor %}
{% else %}
oopss_munin_plugin_{{ plugin }}:
    file:
        - symlink
        - name: /etc/munin/plugins/{{ plugin }}
        - target: /usr/share/munin/plugins/{{ plugin }}
        - require:
            - pkg: oopss_munin_pkg
        - watch_in:
            - service: oopss_munin_service
{% endif %}
{% endfor %}
