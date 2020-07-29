###  sodafoundation/auth/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

include:
  - sodafoundation.auth.config.clean

    {%- endif %}
