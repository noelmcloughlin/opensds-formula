###  sodafoundation/auth/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.auth.daemon.clean
  - sodafoundation.auth.config.clean

    {%- endif %}
