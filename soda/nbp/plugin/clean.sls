###  soda/nbp/plugin/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.nbp.plugin.daemon.clean
  - soda.nbp.plugin.config.clean

   {%- endif %}
