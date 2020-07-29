###  sodafoundation/gelato/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

   {%- if sodafoundation.deploy_project not in ('hotpot',)  %}

include:
  - sodafoundation.gelato.release
  - sodafoundation.gelato.repo
  - sodafoundation.gelato.config
  - sodafoundation.gelato.daemon

   {%- endif %}
