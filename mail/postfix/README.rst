mail.postfix
============

This state installs and configures a basic Postfix local MTA.

Pillar data
-----------

======================= ================================== =======
Key                     Usage                              Default
======================= ================================== =======
mail:postfix:admin_mail Final destination for root@ emails root
======================= ================================== =======

Example : ::

    mail:
        postfix:
            admin_mail: 'bob@example.com'

