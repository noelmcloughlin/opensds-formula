###  sodafoundation/gelato/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('hotpot',)  %}

include:
  - sodafoundation.gelato.daemon.clean
  - sodafoundation.gelato.release.clean
  - sodafoundation.gelato.repo.clean
  - sodafoundation.gelato.config.clean

    {%- endif %}
