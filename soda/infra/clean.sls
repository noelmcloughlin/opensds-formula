### soda/infra/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

include:
  - golang.clean
  - docker.remove
  # memcached.uninstall
  - apache.clean      ### manages port 80
  # nginx.clean       ### https://github.com/saltstack-formulas/nginx-formula/issues/214

   {%- if soda.pkgs %}

soda infra required packages purged:
  pkg.purged:
    - names: {{ soda.pkgs }}

  {%- endif %}

soda infra profile absent:
  file.absent:
    - name: /etc/profile.d/soda.sh
