
==========
oopss.base
==========

Prepare base system.
See ``pîllar.example`` file.

Available states
================

``oopss.base``
--------------

Include non-server states of this formula.
Install standard and useful packages.
Also install packages defined in pillar list ``oopss:base:pkg``.

``oopss.base.bash``
------------------

Configure Bash.

``oopss.base.git``
------------------

Install and configure Git.

``oopss.base.locales``
----------------------

Enable French and US locales.

``oopss.base.motd``
-------------------

Edit ``/etc/motd`` according to content defined in pillar ``oopss:base:motd``.

``oopss.base.server``
-----------------------

Include server states of this formula in addition of ``oopss.base``.
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

``oopss.base.vim``
------------------

Install and configure Vim.

