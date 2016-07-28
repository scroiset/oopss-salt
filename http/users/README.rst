
================
oopss.http.users
================

Requirements
------------
A web server package should be installed, so that the ``www-data`` user exists.

Pillar example
--------------

Create ``example`` user with a ``htdocs`` root path served by the ``www.example.com`` domain : ::

    http:
        users:
            example:
                uid: 5001
                root_paths:
                    htdocs:
                        server_names:
                            - www.example.com

Pillar description
------------------

User properties :

==========  =======  =======  ===========================================
Property    Type     Default  Description
==========  =======  =======  ===========================================
==========  =======  =======  ===========================================

