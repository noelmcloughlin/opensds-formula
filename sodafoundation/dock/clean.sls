###  sodafoundation/dock/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.dock.daemon.clean
  - sodafoundation.dock.release.clean
  - sodafoundation.dock.repo.clean
  - sodafoundation.dock.config.clean
  - sodafoundation.dock.drivers.clean

    {%- endif %}
