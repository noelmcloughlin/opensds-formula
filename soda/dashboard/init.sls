###  soda/dashboard/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.dashboard.release
  - soda.dashboard.repo
  - soda.dashboard.config
  - soda.dashboard.daemon

    {%- endif %}
