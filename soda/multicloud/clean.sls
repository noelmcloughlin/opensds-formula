###  soda/multicloud/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('controller',)  %}

include:
  - soda.multicloud.daemon.clean
  - soda.multicloud.release.clean
  - soda.multicloud.repo.clean
  - soda.multicloud.config.clean

    {%- endif %}
