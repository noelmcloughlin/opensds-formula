###  soda/controller/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.controller.release
  - soda.controller.repo
  - soda.controller.config
  - soda.controller.daemon

   {%- endif %}
