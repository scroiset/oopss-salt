
================================
oopss-infra.databases.postgresql
================================

Usage
-----
``oopss-infra.databases.postgresql`` installs PostgreSQL client.

``oopss-infra.databases.postgresql.server`` installs PostgreSQL server and
create required users and databases.

Pillar example
--------------

Create users ``user1`` and ``user2``, each one owning a corresponding database
with the same name : ::

databases:
    postgresql:
        users:
            - user1
            - user2

Pillar description
------------------

databases:postgresql:daily_dump
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If True, dumps each database in ``/var/backups/dump_pgsql`` as part of the
daily cronjobs.

