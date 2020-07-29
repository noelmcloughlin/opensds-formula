###  sodafoundation/dashboard/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.dashboard.daemon.clean
  - sodafoundation.dashboard.release.clean
  - sodafoundation.dashboard.repo.clean
  - sodafoundation.dashboard.config.clean

    {%- endif %}
