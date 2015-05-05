
==========
oopss.base
==========

Prepare base system.

See ``pîllar.example`` for an exhaustive list of available pillar.

Available states
================

``oopss.base``
--------------

Include all of the above. Be careful.

OS-specific states are included only if applicable.

``oopss.base.bash``
------------------

Configure Bash globally and for root account.

``oopss.base.debian``
---------------------

Manage Debian-specific things : sources.list and apt-listchanges.

``oopss.base.git``
------------------

Install and configure Git.

``oopss.base.hosts``
--------------------

Deploy ``/etc/hosts`` file according to source defined in pillar ``oopss:base:hosts``.

``oopss.base.locales``
----------------------

Enable French and US locales.

Manage the ``/etc/default/locale`` file according to pillar ``oopss:base:locales:default``.
If not defined, don't create the file.

``oopss.base.motd``
-------------------

Edit ``/etc/motd`` according to content defined in pillar ``oopss:base:motd``.

``oopss.base.sysutils``
-----------------------

Install useful sysadmin packages.

``oopss.base.timezone``
-----------------------

Configure timezone according to pillar ``oopss:base:timezone``.

``oopss.base.users``
--------------------

Create UNIX users according to pillar list ``oopss:base:users``.

``oopss.base.userslock``
------------------------

Disallow users to change their account parameters (because Salt manages it).

``oopss.base.utils``
-----------------------

Install standard and useful packages.
Also install packages defined in pillar list ``oopss:base:utils:pkg``.

``oopss.base.vim``
------------------

Install and configure Vim.

