###  sodafoundation/sushi/plugin/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

   {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.sushi.plugin.daemon.clean
  - sodafoundation.sushi.plugin.config.clean

   {%- endif %}
