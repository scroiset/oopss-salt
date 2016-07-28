
================
oopss.http.nginx
================

Formula for managing the NGINX web server.

Global configuration directives are defined in the ``conf.d/local.conf`` file
in the NGINX configuration dir. They overwrite directives defined in the
nginx.conf file, which is not modified by this formula.

================   ==========================================================
File               Description
================   ==========================================================
common.conf        Common set of directives included in all virtual servers
default_server     Config file for the default HTTP/HTTPS virtual server
init.sls           Salt states
local.conf         Template to generate the ``conf.d/local.conf`` config file
map.jinja          Default global configuration directives
pillar.example     Example of pillar data
vhost              Template to generate virtual host files
================   ==========================================================

