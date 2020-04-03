###  soda/auth/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.auth.config
        {%- if "keystone" in soda.controller.conf.let.auth_strategy|lower %}
  - devstack.cli
        {%- endif %}

    {%- endif %}
