### sodafoundation/sushi/plugin/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

   {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.sushi.plugin.config
  - sodafoundation.sushi.plugin.daemon

   {%- endif %}
