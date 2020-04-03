### soda/nbp/plugin/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.nbp.plugin.config
  - soda.nbp.plugin.daemon

   {%- endif %}
