
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

# Configure Nagios agent for SSH checks

# Install Nagios plugins
nagios-plugins:
    pkg.installed

# Add nagios user to group sshusers
nagios:
    user.present:
        - require:
            - pkg: nagios-plugins
            - group: sshusers
        - groups:
            - sshusers

