###  soda/dashboard/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.dashboard.daemon.clean
  - soda.dashboard.release.clean
  - soda.dashboard.repo.clean
  - soda.dashboard.config.clean

    {%- endif %}
