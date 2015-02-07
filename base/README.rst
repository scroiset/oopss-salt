
==========
oopss.base
==========

Configure base system.

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

Edit ``/etc/motd`` according to pillar.

``oopss.base.timezone``
-----------------------

Configure timezone according to pillar.

``oopss.base.users``
--------------------

Create UNIX users according to pillar.

``oopss.base.userslock``
------------------------

Disallow users to change their account parameters (because Salt manages it).

