
oopss-infra.http.users
======================

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
                ssh: True
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
ssh         Boolean  False    If True, user can use full SSH command line
==========  =======  =======  ===========================================

Bugs
----

Cannot change "ssh" user property
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The value of this property alters the path of the corresponding user home
directory. Unfortunately, in Salt 0.17.0, the ``user.present`` state is not
able to change the user home directory and this causes an error. As a
workaround, one can changes manually the home directory, then launches Salt.

