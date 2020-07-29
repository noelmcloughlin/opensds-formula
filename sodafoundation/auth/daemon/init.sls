###  sodafoundation/auth/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.auth.config
        {%- if "keystone" in sodafoundation.hotpot.conf.let.auth_strategy|lower %}
  - devstack.cli
        {%- endif %}

    {%- endif %}
