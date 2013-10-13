
Oopss infrastructure files using SaltStack
==========================================

Introduction
------------

These SaltStack formulas run the Oopss.org infrastructure.

Feel free to use them as is, or as a way to learn SaltStack.

This is tightly related to our infrastructure, but we plan to make it more generic.

Requirements
------------

These Salt formulas are currently designed only for Debian GNU/Linux, and
tested with versions 6.0 and 7.0 (Squeeze and Wheezy).

SaltStack above version 0.16 is required.

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

