
==========
oopss.base
==========

Configure base system.
See ``pîllar.example`` file.

Available states
================

``oopss.base``
--------------

Include every sub-states of this formula.

``oopss.base.locales``
----------------------

Enable French and US locales.

``oopss.base.motd``
-------------------

Edit ``/etc/motd`` according to content defined in pillar ``oopss:base:motd``.

``oopss.base.pkg``
-----------------------

Install standard and useful packages.
Also install packages defined in pillar list ``oopss:base:pkg``.

``oopss.base.timezone``
-----------------------

Configure timezone according to pillar ``oopss:base:timezone``.

``oopss.base.users``
--------------------

Create UNIX users according to pillar list ``oopss:base:users``.

``oopss.base.userslock``
------------------------

Disallow users to change their account parameters (because Salt manages it).

