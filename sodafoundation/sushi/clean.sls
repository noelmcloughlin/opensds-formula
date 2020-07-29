###  sodafoundation/sushi/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

   {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.sushi.plugin.clean
  - sodafoundation.sushi.config.clean
  - sodafoundation.sushi.release.clean
  - sodafoundation.sushi.repo.clean
  # iscsi.initiator.remove     ### https://github.com/saltstack-formulas/iscsi-formula/issues/12
  - kubernetes.kubectl.clean

   {%- endif %}
