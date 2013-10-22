
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

