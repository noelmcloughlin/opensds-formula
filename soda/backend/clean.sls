###  soda/backend/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.backend.block.clean
  - soda.backend.config.clean

    {%- endif %}
