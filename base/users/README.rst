
sysutils.users
==============

Pillar data
-----------

Example : ::

    users:
        bob:
            uid: 4201
            fullname: "Bob (Oopss.org)"
            sudoer: True
            password: '$6$cDrkUw94$3JCwZFFDsZbDaz4r2WT53i/qAWkHyIFQIyuiFjV1Hzbc48edtjtJTQJ1mVRSxhdo33hz14xkdMpbgtt3u56E4.'
            ssh_auth:
                - 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA7BVKWoCUJ7m3qTFeV+hOKKjwKp9O6nKgLcqfOS6jMfXYyYHJAAFjm1rqcCRh/RPbnThJK59X07jOC3/qSNpLNSLxvPi/GHc9E7prnXYjjBPlanmXDkFQ4d3o44ndGhvCcpsu68gZThwBcTgWNTMQqsmogtnP5oeJUHBUS0mk8wsntZNKyYcizw1YldWXx52jYOnc4HwO0VaqrpaJlWuk05I5Q82xvhJiebJfGOxa3wEkUaWpbI/WGSZ+46LiEcmFbyH0gk7fRcMvL4g9QqYwm8C0c7xJ5Vuge+k7zwqsiAws+Wg2DARhBsAWC8gSXdphYF3iqGbqFH2lwCs80/Dn9w== bob@host1'
                - 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgkiv1/0Rn08DG5fXqdvI57N646NZDjjlIzlyNS5ZS7lgLRiEuIa40R3IutBD2kZvSyABPymD/nFxWexW9EAE0GJJBweguy7VOlQDI/bA4TywzSoQr6mgPz+cebuVP4HckSqotrO+U6HDGajgQHhmaES9gt4wr6rVYcMTpLXtq4OVT+LMAH4RgDPk0N9TywKue7I0OZHrfwmwPS9TtuhhONGoOlpkgPRV2XI9Rm9QrMoBUS5LbVNEDu47Ii8f3RcsxBQwz8teSsT3v8Eon9JmSxu6HoirOx0clTRukLFKQpPeUmJoI9uyNM+Y8M8dxLIiPOp1fR9TIXSugE1fmoqrF bob@host2'

