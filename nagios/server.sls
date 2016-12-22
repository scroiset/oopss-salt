
##############################################################################
# oopss-salt
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-salt
# Copyright 2013-2016 Oopss.org <team@oopss.org>
##############################################################################

oopss_nagios_server_pkg:
    pkg:
        - installed
        - names:
            - nagios3
            - php5-cgi
        - install_recommends: False

oopss_nagios_clean_config:
    file:
        - absent
        - names:
            - /etc/nagios3/conf.d/contacts_nagios2.cfg
            - /etc/nagios3/conf.d/extinfo_nagios2.cfg
            - /etc/nagios3/conf.d/generic-host_nagios2.cfg
            - /etc/nagios3/conf.d/generic-service_nagios2.cfg
            - /etc/nagios3/conf.d/hostgroups_nagios2.cfg
            - /etc/nagios3/conf.d/localhost_nagios2.cfg
            - /etc/nagios3/conf.d/services_nagios2.cfg
            - /etc/nagios3/conf.d/timeperiods_nagios2.cfg

