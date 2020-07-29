###  sodafoundation/hotpot/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

   {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.hotpot.release
  - sodafoundation.hotpot.repo
  - sodafoundation.hotpot.config
  - sodafoundation.hotpot.daemon

   {%- endif %}
