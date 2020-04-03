## soda/keystone/conflicts/clean
# -*- coding: utf-8 -*-
# vim: ft=sls

soda keystone conflicts start nginx after devstack stack.sh:
  cmd.run:
    - names:
      - docker container start dashboard
      - rm /tmp/soda_stopped_dashboard
    - onlyif: test -f /tmp/soda_stopped_dashboard
