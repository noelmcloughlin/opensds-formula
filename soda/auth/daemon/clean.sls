###  soda/auth/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}
{%- from "soda/map.jinja" import golang, packages with context %}

include:
  - soda.auth.config.clean

    {%- endif %}
