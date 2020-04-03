###  soda/auth/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.auth.config
  - soda.auth.daemon

   {%- endif %}
