###  opensds/hotpot/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "opensds/map.jinja" import opensds with context %}

    {%- if opensds.deploy_project not in ('gelato',)  %}

include:
  - opensds.hotpot.daemon.clean
  - opensds.hotpot.release.clean
  - opensds.hotpot.repo.clean
  - opensds.hotpot.config.clean

    {%- endif %}
