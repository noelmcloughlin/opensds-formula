# -*- coding: utf-8 -*-
# vim: ft=sls

sodafoundation infra conflicts start nginx after devstack stack.sh:
  cmd.run:
    - names:
      - docker container start dashboard
      - rm /tmp/sodafoundation_stopped_dashboard
    - onlyif: test -f /tmp/sodafoundation_stopped_dashboard
