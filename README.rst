
Oopss infrastructure files using SaltStack
==========================================

Introduction
------------

This is a collection of SaltStack formulas used run the Oopss.org infrastructure.

Each formula should be provided with a ``README.rst`` file and a ``pillar.example`` file.

Feel free to use them directly or as a way to learn SaltStack.

Requirements
------------

These Salt formulas are currently designed only for Debian 7.0 Wheezy.

SaltStack above version 0.17 is required.

Quickstart
----------

Install Salt master and minion.

Clone this repository under ``/srv/salt/oopss-infra``.

Create top file ``/srv/salt/top.sls`` and call formulas you want to use. Example : ::

    base:
        '*':
            - oopss-infra.utils
            - oopss-infra.dns.unbound
            - oopss-infra.mail.postfix
            - oopss-infra.net.ssh.server

Bind the minion to the master and execute ``state.highstate``.

Guidelines
----------
- The project is sub-divised in formulas
- Each formula resides in a sub-directory of a category (e.g. http/nginx/)
- Software configuration should be defined in a map.jinja file
- Users can overwrite map.jinja using Pillar
- Each formula has a README.rst file
- Each formula has a pillar.example file
- Each dependency to another formula should be documented
- Each file should have the standard header
- Each formula's file should be documented in the README.rst file
- Formulas should be generic if it don't increase complexity overmuch

