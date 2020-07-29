###  sodafoundation/hotpot/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.hotpot.daemon.clean
  - sodafoundation.hotpot.release.clean
  - sodafoundation.hotpot.repo.clean
  - sodafoundation.hotpot.config.clean

    {%- endif %}
