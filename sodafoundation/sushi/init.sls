###  sodafoundation/sushi/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

   {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - iscsi.initiator
  - kubernetes.kubectl
  - sodafoundation.sushi.release
  - sodafoundation.sushi.repo
  - sodafoundation.sushi.config
  - sodafoundation.sushi.plugin

   {%- endif %}
