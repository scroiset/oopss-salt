
===========
oopss.munin
===========

This Salt formula manages installation and configuration of both Munin server
and node.

Available states
================

``oopss.munin``
---------------

Install and configure munin node.
Server IP address is defined in CIDR notation in pillar ``oopss:munin:server_cidr``.

``oopss.munin.server``
----------------------

Install and configure munin server.
Nodes list is specified in pillar ``oopss:munin:server:nodes``.

