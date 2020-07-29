### sodafoundation/infra/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

include:
  - golang.clean
  - docker.remove
  # memcached.uninstall
  - apache.uninstall      ### manages port 80
  # nginx.clean           ### https://github.com/saltstack-formulas/nginx-formula/issues/214

   {%- if sodafoundation.pkgs %}

sodafoundation infra required packages purged:
  pkg.purged:
    - names: {{ sodafoundation.pkgs }}

  {%- endif %}

sodafoundation infra profile absent:
  file.absent:
    - name: /etc/profile.d/sodafoundation.sh
