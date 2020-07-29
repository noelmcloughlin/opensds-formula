###  sodafoundation/dock/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.dock.release
  - sodafoundation.dock.repo
  - sodafoundation.dock.config
  - sodafoundation.dock.drivers
  - sodafoundation.dock.daemon

    {%- endif %}
