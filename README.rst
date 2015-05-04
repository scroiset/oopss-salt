
Oopss' SaltStack formulas
=========================

Introduction
------------

This is a collection of `SaltStack formulas`_.

They are used by the `Oopss.org`_ system team to manage the server
infrastructure of various projects.

It aims to be reusable !

Each formula is provided with a ``README.rst`` file and a ``pillar.example`` file.

Feel free to use them directly or as a way to learn SaltStack.

.. _SaltStack formulas: http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html
.. _Oopss.org: http://www.oopss.org

Requirements
------------

These Salt formulas are currently tested only on Debian 7.0 *Wheezy*. and Salt 2014.7.

Quickstart
----------

**Warning : Using these formulas can break or lower the security of your system
(files will be modified (even removed in some cases), services will be started,
...). Please read the doc and know what you do !**

Install Salt master and minion.

Clone this repository under ``/srv/salt/oopss`` (or wherever your Salt root is).

Create top file ``/srv/salt/top.sls`` and call formulas you want to use. Example : ::

    base:
        '*':
            - oopss.base
            - oopss.unbound
            - oopss.postfix
            - oopss.nginx

Read the README.sls file of each included formula to know what they do, and to
know what pillar data can be used. However, each formula should run without any
pillar data.

Bind the minions to the master and execute ``state.highstate``.

Guidelines for creating/maintaining formulas
--------------------------------------------
- The project is sub-divised in formulas
- Software configuration should be defined in a map.jinja file
- Users can overwrite map.jinja using Pillar
- Each formula has a README.rst file
- Each formula has a pillar.example file
- Each dependency to another formula should be documented
- Each file should have the standard header
- Each formula's file should be documented in the README.rst file
- Formulas should be generic if it don't increase complexity overmuch

