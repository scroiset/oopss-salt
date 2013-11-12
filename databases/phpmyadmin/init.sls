
##############################################################################
# oopss-infra
# Description : Oopss infrastructure files using SaltStack
# URL : https://github.com/oopss/oopss-infra
# Copyright 2013 Oopss.org <team@oopss.org>
##############################################################################

include:
    - lang.php5.fpm

pkg_phpmyadmin:
    pkg:
        - name: phpmyadmin
        - installed

phpmyadmin:
    user.present:
        - system: True
        - createhome: True
        - fullname: "phpMyAdmin web user"

/etc/php5/fpm/pool.d/phpmyadmin.conf:
    file.managed:
        - user: root
        - group: adm
        - mode: 440
        - source: salt://oopss-infra/databases/phpmyadmin/fpm.conf
        - require:
            - pkg: php5-fpm
            - user: phpmyadmin
        - watch_in:
            - service: php5-fpm

/etc/phpmyadmin/config.inc.php:
    file.managed:
        - user: root
        - group: root
        - mode: 444
        - source: salt://oopss-infra/databases/phpmyadmin/config.inc.php
        - require:
            - pkg: pkg_phpmyadmin

