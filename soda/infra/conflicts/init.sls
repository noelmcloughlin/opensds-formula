### soda/infra/conflicts/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls

soda infra conflicts stop nginx before devstack stack.sh:
  cmd.run:
    - names:
      - docker container stop dashboard
      - touch /tmp/soda_stopped_dashboard
    - onlyif: docker inspect dashboard >/dev/null 2>&1
