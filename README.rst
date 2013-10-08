
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
tested only with version 7.0 (Squeeze).

SaltStack above version 0.16 is required.

Quickstart
----------

Install Salt master and minion.

Clone this repository under ``/srv/salt/oopss-infra``.

Create directory ``/srv/salt/local``.

Create top file ``/srv/salt/local/top.sls`` and call formulas you want to use. Example : ::

    base:
        '*':
            - utils
            - dns.unbound
            - mail.postfix
            - net.ssh.server

- Configure ``/etc/salt/master`` with these directives : ::

    file_roots:
        base:
            - /srv/salt/local
            - /srv/salt/oopss-infra

- Bind the minion to the master and execute ``state.highstatè``.

